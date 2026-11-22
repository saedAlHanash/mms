part of 'notice_preferences_cubit.dart';

class NoticePreferencesInitial extends AbstractState<NoticePreferences> {
  const NoticePreferencesInitial({required super.result, super.error, super.statuses});

  factory NoticePreferencesInitial.initial() {
    return NoticePreferencesInitial(
      result: NoticePreferences(language: null, groups: []),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  NoticePreferencesInitial copyWith({CubitStatuses? statuses, NoticePreferences? result, String? error}) {
    return NoticePreferencesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
