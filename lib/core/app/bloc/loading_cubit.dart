
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingInitial> {
  LoadingCubit() : super(LoadingInitial.initial());

  void startLoading() {
    emit(state.copyWith(isLoading: true));
  }

  void endLoading() {
    emit(state.copyWith(isLoading: false));
  }

  bool isLoadingForPop() {
    if (state.isLoading) {
      endLoading();
      return false;
    }

    return true;
  }
}

void startLoading(BuildContext context) {
  context.read<LoadingCubit>().startLoading();
}

void endLoading(BuildContext context) {
  context.read<LoadingCubit>().endLoading();
}
