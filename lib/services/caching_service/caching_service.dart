import 'dart:convert';

import 'package:e_move/core/api_manager/api_url.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/api_manager/api_service.dart';
import '../../core/strings/enum_manager.dart';
import '../../core/util/abstraction.dart';
import '../../features/educational_grade/data/response/educational_grade_response.dart';

const latestUpdateBox = 'latestUpdateBox';

class CachingService {
  static Future<void> initial() async {
    await Hive.initFlutter();
  }

  static Future<void> sortData(
      {required dynamic data, required String name}) async {
    final boxUpdate = await getBox(latestUpdateBox);

    await boxUpdate.put(name, DateTime.now().toIso8601String());

    final box = await getBox(name);

    await box.clear();

    loggerObject.f(jsonEncode(data));
    if (data is List) {
      for (var e in data) {
        await box.add(jsonEncode(e));
      }
    } else {
      await box.add(jsonEncode(data));
    }
  }

  static Future<Iterable<dynamic>> getList(String name) async {
    final box = await getBox(name);

    return box.values.map((e) => jsonDecode(e));
  }

  static Future<dynamic> getData(String name) async {
    final box = await getBox(name);

    if (box.values.isEmpty) return null;

    return jsonDecode(box.values.first);
  }

  static Future<Box<String>> getBox(String name) async {
    return Hive.isBoxOpen(name)
        ? Hive.box<String>(name)
        : await Hive.openBox<String>(name);
  }

  static Future<NeedUpdateEnum> needGetData(String name) async {
    final latest =
        DateTime.tryParse((await getBox(latestUpdateBox)).get(name) ?? '');

    final haveData = (await getList(name)).isNotEmpty;

    if (latest == null) return NeedUpdateEnum.withLoading;

    final d = DateTime.now().difference(latest).inMinutes.abs();

    if (d > 2)
      return haveData ? NeedUpdateEnum.noLoading : NeedUpdateEnum.withLoading;

    return NeedUpdateEnum.no;
  }
}
