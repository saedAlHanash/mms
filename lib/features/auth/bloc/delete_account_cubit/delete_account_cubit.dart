import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountInitial> {
  DeleteAccountCubit() : super(DeleteAccountInitial.initial());
  

  Future<void> deleteAccount(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _logoutApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    await  AppProvider.logout();
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _logoutApi() async {
     
      final response = await APIService().callApi(type: ApiType.post,
        url: 'destroyAccount',
      );

      if (response.statusCode == 200) {
        return Pair(true, null);
      } else {
          return response.getPairError;
      }
     
  }
}
