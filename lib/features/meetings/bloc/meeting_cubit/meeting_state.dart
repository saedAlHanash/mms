part of 'meeting_cubit.dart';

class MeetingInitial extends AbstractState<Meeting> {
  // final bool meetingParam;

  const MeetingInitial({
    required super.result,
    super.error,
    required super.request,
    // required this.meetingParam,
    super.statuses,
  });

  factory MeetingInitial.initial() {
    return MeetingInitial(
      result: Meeting.fromJson({}),
      error: '',
      // meetingParam: false,
      request: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (request != null) request,
      ];

  MeetingInitial copyWith({
    CubitStatuses? statuses,
    Meeting? result,
    String? error,
    String? request,
    // bool? meetingParam,
  }) {
    return MeetingInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,

      request: request ?? this.request,
      // meetingParam: meetingParam ?? this.meetingParam,
    );
  }

  List<Node> it(List<Agenda> childrenItems) {
    final list = <Node>[];

    if (childrenItems.isEmpty) {
      return list;
    }

    for (var e in childrenItems) {
      list.add(TreeNode(data: e)..addAll(it(e.childrenItems)));
    }

    return list;
  }

  TreeNode<Agenda> getTree() {
    return TreeNode<Agenda>.root(
      data: Agenda.fromJson({}),
    )..addAll(it(result.agendaItems));
  }
}
