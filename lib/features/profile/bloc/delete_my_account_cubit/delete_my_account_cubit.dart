import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/abstraction.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';

part 'delete_my_account_state.dart';

class DeleteMyAccountCubit extends Cubit<DeleteMyAccountInitial> {
  DeleteMyAccountCubit() : super(DeleteMyAccountInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> deleteMyAccount(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _deleteMyAccountApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _deleteMyAccountApi() async {
    if (await network.isConnected) {
      final response = await APIService().callApi(
        type: ApiType.get,
        url: 'DeleteUrl.deleteMyAccount',
      );

      if (response.statusCode.success) {
        return Pair(true, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, 'AppStringManager.noInternet');
    }
  }
}
