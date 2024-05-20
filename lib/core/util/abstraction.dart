import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/caching_service/caching_service.dart';
import '../api_manager/request_models/command.dart';
import '../strings/enum_manager.dart';

abstract class AbstractCubit<T> extends Equatable {
  final CubitStatuses statuses;
  final String error;
  final T result;
  final FilterRequest? filterRequest;

  const AbstractCubit({
    this.statuses = CubitStatuses.init,
    this.error = '',
    this.filterRequest,
    required this.result,
  });
}

abstract class AbstractJson {
  AbstractJson fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}

abstract class MCubit<T> extends Cubit<T> {
  MCubit(super.initialState);

  String get nameCache => '';

  String get id => '';

  String get by => '';

  Future<NeedUpdateEnum> needGetData() async {
    if (nameCache.isEmpty) return NeedUpdateEnum.withLoading;
    return await CachingService.needGetData(nameCache, id: id, by: by);
  }

  Future<void> storeData(dynamic data) async {
    await CachingService.sortData(data: data, name: nameCache, id: id, by: by);
  }

  Future<Iterable<dynamic>> getListCached() async {
    final data = await CachingService.getList(nameCache, id: id, by: by);
    return data;
  }

  Future<dynamic> getDataCached() async {
    return (await CachingService.getData(nameCache, id: id, by: by)) ??
        <String, dynamic>{};
  }
}
