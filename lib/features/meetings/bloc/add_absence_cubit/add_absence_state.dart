part of 'add_absence_cubit.dart';

class AddAbsenceInitial extends AbstractState<bool> {
  // final bool addAbsenceParam;

  const AddAbsenceInitial({
    required super.result,
    super.error,
    // required this.addAbsenceParam,
    super.statuses,
  });

  factory AddAbsenceInitial.initial() {
    return const AddAbsenceInitial(
      result: false,
      error: '',
      // addAbsenceParam: false,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AddAbsenceInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    // bool? addAbsenceParam,
  }) {
    return AddAbsenceInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // addAbsenceParam: addAbsenceParam ?? this.addAbsenceParam,
    );
  }
}
