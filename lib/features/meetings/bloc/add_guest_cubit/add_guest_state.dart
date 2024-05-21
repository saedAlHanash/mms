part of 'add_guest_cubit.dart';

class AddGuestInitial extends AbstractCubit<bool> {
  final AddGuestRequest request;

  // final bool addGuestParam;

  const AddGuestInitial({
    required super.result,
    super.error,
    required this.request,
    // required this.addGuestParam,
    super.statuses,
  });

  factory AddGuestInitial.initial() {
    return AddGuestInitial(
      result: false,
      error: '',
      // addGuestParam: false,
      request: AddGuestRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, request];

  AddGuestInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    AddGuestRequest? request,
    // bool? addGuestParam,
  }) {
    return AddGuestInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      // addGuestParam: addGuestParam ?? this.addGuestParam,
    );
  }
}
