import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mms/core/api_manager/api_service.dart';

import '../../core/strings/enum_manager.dart';

const latestUpdateBox = 'latestUpdateBox';

class CachingService {
  static Future<void> initial() async {
    await Hive.initFlutter();
  }

  static Future<void> sortData({
    required dynamic data,
    required String name,
    String filter = '',
  }) async {
    final key = '_${filter}_';

    final boxUpdate = await getBox(latestUpdateBox);

    await boxUpdate.put(name, DateTime.now().toIso8601String());

    final box = await getBox(name);

    if (data is List) {
      await clearKeysId(box: box, filter: filter);

      for (var e in data) {
        await box.put('$key${box.values.length}', jsonEncode(e));
      }

      loggerObject.w('cached key $key count ${data.length}');

      return;
    }

    await box.put(key, jsonEncode(data));
    loggerObject.w('cached key $key');
  }

  static Future<void> clearKeysId({
    required Box<String> box,
    String filter = '',
  }) async {
    final key = '_${filter}_';

    final keys = box.keys.where((e) => e.startsWith(key));

    loggerObject.e('deleted keys:\n$key \n$keys');

    await box.deleteAll(keys);
  }

  static Future<Iterable<dynamic>> getList(
    String name, {
    String filter = '',
  }) async {
    final key = '_${filter}_';

    final box = await getBox(name);

    final f = box.keys
        .where((e) => e.startsWith(key))
        .map((e) => jsonDecode(box.get(e) ?? '{}'));

    loggerObject.t('getList(): \nkey:$key count ${f.length}');

    return f;
  }

  static Future<dynamic> getData(
    String name, {
    String filter = '',
  }) async {
    final key = '_${filter}_';

    final box = await getBox(name);

    final dataByKey = box.get(key);

    if (dataByKey == null) return null;

    loggerObject.t('getList(): \nkey:$key key found $dataByKey');

    return jsonDecode(dataByKey);
  }

  static Future<Box<String>> getBox(String name) async {
    return Hive.isBoxOpen(name)
        ? Hive.box<String>(name)
        : await Hive.openBox<String>(name);
  }

  static Future<NeedUpdateEnum> needGetData(String name,
      {String filter = ''}) async {

    var key = '_${filter}_';

    var message = 'needGetData key: $key';

    final box = await getBox(name);
    final keyFounded = box.keys.firstWhereOrNull((e) => (e).startsWith(key));

    if (keyFounded == null) {
      loggerObject.v(box.keys);
      loggerObject.f('need get data (key Not Founded): \n$key With loading');
      return NeedUpdateEnum.withLoading;
    }

    message += '\n found Key with ID : ';
    final latest =
        DateTime.tryParse((await getBox(latestUpdateBox)).get(name) ?? '');

    final haveData = (await getList(name, filter: filter)).isNotEmpty;

    if (latest == null) {
      loggerObject.f('need get data (latest): \n$key With loading');
      return NeedUpdateEnum.withLoading;
    }

    final d = DateTime.now().difference(latest).inMinutes.abs();

    if (d > 2) {
      loggerObject.f(
        'need get data :'
        ' \n$key data > 2 '
        '\n${haveData ? NeedUpdateEnum.noLoading.name : NeedUpdateEnum.withLoading.name}',
      );

      return haveData ? NeedUpdateEnum.noLoading : NeedUpdateEnum.withLoading;
    }
    loggerObject.f('need get data : \n$key Not get data');
    return NeedUpdateEnum.no;
  }
}
