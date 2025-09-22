import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/strings/enum_manager.dart';import 'package:m_cubit/abstraction.dart';

const latestUpdateBox = 'latestUpdateBox';

class CachingService {
  static Future<void> initial() async {
    await Hive.initFlutter(null);
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

      return;
    }

    await box.put(key, jsonEncode(data));
  }

  static Future<void> clearKeysId({
    required Box<String> box,
    String filter = '',
  }) async {
    final key = '_${filter}_';

    final keys = box.keys.where((e) => e.startsWith(key));

    // loggerObject.e('deleted keys:\n$key \n$keys');

    await box.deleteAll(keys);
  }

  static Future<Iterable<dynamic>> getList(
    String name, {
    String filter = '',
  }) async {
    final key = '_${filter}_';

    final box = await getBox(name);

    final f = box.keys.where((e) => e.startsWith(key)).map((e) => jsonDecode(box.get(e) ?? '{}'));

    // loggerObject.t('getList(): \nkey:$key count ${f.length}');

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

    // loggerObject.t('getList(): \nkey:$key key found $dataByKey');

    return jsonDecode(dataByKey);
  }

  static Future<Box<String>> getBox(String name) async {
    return Hive.isBoxOpen(name) ? Hive.box<String>(name) : await Hive.openBox<String>(name);
  }

  static Future<NeedUpdateEnum> needGetData(String name, {String filter = ''}) async {
    var key = '_${filter}_';

    var message = 'needGetData key: $key';

    final box = await getBox(name);
    final keyFounded = box.keys.firstWhereOrNull((e) => (e).startsWith(key));

    if (keyFounded == null) {
      return NeedUpdateEnum.withLoading;
    }

    message += '\n found Key with ID : ';
    final latest = DateTime.tryParse((await getBox(latestUpdateBox)).get(name) ?? '');

    final haveData = (await getList(name, filter: filter)).isNotEmpty;

    if (latest == null) {
      return NeedUpdateEnum.withLoading;
    }

    final d = DateTime.now().difference(latest).inSeconds.abs();

    if (d > 1) {
      return haveData ? NeedUpdateEnum.noLoading : NeedUpdateEnum.withLoading;
    }
    return NeedUpdateEnum.no;
  }
}
