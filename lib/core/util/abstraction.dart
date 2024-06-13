import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../services/caching_service/caching_service.dart';
import '../api_manager/api_service.dart';
import '../api_manager/request_models/command.dart';
import '../strings/enum_manager.dart';

abstract class AbstractState<T> extends Equatable {
  final CubitStatuses statuses;
  final String error;
  final T result;
  final FilterRequest? filterRequest;
  final dynamic request;

  const AbstractState({
    this.statuses = CubitStatuses.init,
    this.error = '',
    this.filterRequest,
    this.request,
    required this.result,
  });
}

abstract class AbstractState1<T> extends Equatable {
  final CubitStatuses statuses;
  final StateControl control;
  final T result;

  const AbstractState1({
    required this.control,
    this.statuses = CubitStatuses.init,
    required this.result,
  });
}

class StateControl {
  String? error;
  FilterRequest? filterRequest;
  dynamic request;

  StateControl();
}

abstract class MCubit<AbstractState> extends Cubit<AbstractState> {
  MCubit(super.initialState);

  String get nameCache => '';

  String get filter => '';

  Future<NeedUpdateEnum> needGetData() async {
    if (nameCache.isEmpty) return NeedUpdateEnum.withLoading;
    return await CachingService.needGetData(nameCache, filter: filter);
  }

  Future<void> storeData(dynamic data) async {
    await CachingService.sortData(data: data, name: nameCache, filter: filter);
  }

  Future<Iterable<dynamic>> getListCached() async {
    final data = await CachingService.getList(nameCache, filter: filter);
    return data;
  }

  Future<dynamic> getDataCached() async {
    return (await CachingService.getData(nameCache, filter: filter)) ??
        <String, dynamic>{};
  }

  void setNewData({required dynamic state, bool? newData}) {
    if (newData == null) return;
    emit(state.copyWith(newData: newData));
  }

  Future<bool> checkCashed1<T>({
    required dynamic state,
    required T Function(Map<String, dynamic>) fromJson,
    bool newData = false,
  }) async {
    if (newData) {
      emit(state.copyWith(statuses: CubitStatuses.loading));
      return false;
    }

    try {
      final cacheType = await needGetData();
      final emitState = cacheType.getState;
      dynamic data;

      if (state.result is List) {
        data = (await getListCached()).map((e) => fromJson(e)).toList();
      } else {
        data = fromJson(await getDataCached());
      }

      emit(
        state.copyWith(
          statuses: emitState,
          result: data,
        ),
      );

      if (cacheType == NeedUpdateEnum.no) return true;

      return false;
    } catch (e) {
      loggerObject.e(e);
      return false;
    }
  }
}
