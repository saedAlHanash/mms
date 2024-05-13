import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/strings/enum_manager.dart';

const latestUpdateBox = 'latestUpdateBox';

class CachingService {
  static Future<void> initial() async {
    await Hive.initFlutter();
  }

  static Future<void> sortData({
    required dynamic data,
    required String name,
    String id = '',
    String by = '',
  }) async {
    final boxUpdate = await getBox(latestUpdateBox);

    await boxUpdate.put(name, DateTime.now().toIso8601String());
    final box = await getBox(name);

    if (data is List) {
      await clearKeysId(box: box, id: id, by: by);
      for (var e in data) {
        await box.put('_$id${by}_${box.values.length}', jsonEncode(e));
      }
    } else if (id.isNotEmpty) {
      // loggerObject.d('_$id${by}_\n ${jsonEncode(data)}');
      await box.put('_$id${by}_', jsonEncode(data));
    }
  }

  static Future<void> clearKeysId({
    required Box<String> box,
    required String id,
    String by = '',
  }) async {
    final keys = box.keys.where((e) => (e as String).startsWith('_$id${by}_'));
    // loggerObject.e('Delete :startWtih :${'_$id${by}_'}\n name:${box.name}\n $keys');
    await box.deleteAll(keys);
  }

  static Future<Iterable<dynamic>> getList(String name,
      {String id = '', String by = ''}) async {
    final box = await getBox(name);

    // loggerObject.w('getList Data from : ${box.name}\n key need : _$id${by}_\n${box.keys}');
    final f = box.keys
        .where((e) => (e as String).startsWith('_$id${by}_'))
        .map((e) => jsonDecode(box.get(e) ?? '{}'));

    return f;
  }

  static Future<dynamic> getData(String name,
      {String id = '', String by = ''}) async {
    final box = await getBox(name);

    if (box.values.isEmpty) return null;
    final dataByKey = box.get('_$id${by}_');
    if (dataByKey == null) return null;
    return jsonDecode(dataByKey);
  }

  static Future<Box<String>> getBox(String name) async {
    return Hive.isBoxOpen(name)
        ? Hive.box<String>(name)
        : await Hive.openBox<String>(name);
  }

  static Future<NeedUpdateEnum> needGetData(String name,
      {String id = '', String by = ''}) async {
    if (id.isNotEmpty) {
      final box = await getBox(name);
      // loggerObject.t('GetKey: key: _$id${by}_ \n keys ${box.keys}');
      if (box.keys.firstWhereOrNull(
              (e) => (e as String).startsWith('_$id${by}_')) !=
          null) {
        final latest =
            DateTime.tryParse((await getBox(latestUpdateBox)).get(name) ?? '');

        final haveData = (await getList(name, id: id, by: by)).isNotEmpty;

        if (latest == null) return NeedUpdateEnum.withLoading;

        final d = DateTime.now().difference(latest).inMinutes.abs();

        if (d > 2) {
          return haveData
              ? NeedUpdateEnum.noLoading
              : NeedUpdateEnum.withLoading;
        }

        return NeedUpdateEnum.no;
      } else {
        return NeedUpdateEnum.withLoading;
      }
    }

    final latest =
        DateTime.tryParse((await getBox(latestUpdateBox)).get(name) ?? '');

    final haveData = (await getList(name, id: id, by: by)).isNotEmpty;

    if (latest == null) return NeedUpdateEnum.withLoading;

    final d = DateTime.now().difference(latest).inMinutes.abs();

    if (d > 2) {
      return haveData ? NeedUpdateEnum.noLoading : NeedUpdateEnum.withLoading;
    }

    return NeedUpdateEnum.no;
  }
}
