import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:m_cubit/abstraction.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/strings/app_color_manager.dart';

import '../../../../services/agora_manager.dart';

part 'agora_state.dart';

class AgoraCubit extends MCubit<AgoraInitial> {
  AgoraCubit() : super(AgoraInitial.initial());

  void _eventCallback(String eventName, Map<String, dynamic> eventArgs) {
    switch (eventName) {
      case 'onConnectionStateChanged':
        emit(state.copyWith(id: state.id + 1));
        break;

      case 'onJoinChannelSuccess':
        emit(state.copyWith(id: state.id + 1));
        break;

      case 'onUserJoined':
        emit(state.copyWith(id: state.id + 1));
        break;

      case 'onUserOffline':
        emit(state.copyWith(id: state.id + 1));
        break;

      default:
        break;
    }
  }

  void _messageCallback(String message) {
    loggerObject.f(message);
  }

  Future<void> leave() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    state.result.dispose();

    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(statuses: CubitStatuses.done));
  }

  Future<void> join() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    await state.result.join();
    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(statuses: CubitStatuses.done));
  }

  Future<void> initialize() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final manager = await AgoraManager.create(
      currentProduct: ProductName.videoCalling,
      eventCallback: _eventCallback,
      messageCallback: _messageCallback,
    );

    emit(state.copyWith(result: manager, statuses: CubitStatuses.done));
  }

  @override
  Future<void> close() {
    leave();
    return super.close();
  }
}
