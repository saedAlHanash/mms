part of 'educational_grade_cubit.dart';

class EducationalGradeInitial extends AbstractCubit<List<EducationalGrade>> {
  // final EducationalGradeRequest request;
  // final  bool educationalGradeParam;
  const EducationalGradeInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.educationalGradeParam,
    super.statuses,
  }); //

  factory EducationalGradeInitial.initial() {
    return const EducationalGradeInitial(
      result: [],
      error: '',
      // educationalGradeParam: false,
      // request: EducationalGradeRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  List<SpinnerItem> getSpinnerItems({int? selectedId}) {
    return List<SpinnerItem>.from(
      result.map(
        (e) => SpinnerItem(
          isSelected: e.id == selectedId,
          name: e.name,
          item: e,
          id: e.id,
        ),
      ),
    );
  }

  EducationalGradeInitial copyWith({
    CubitStatuses? statuses,
    List<EducationalGrade>? result,
    String? error,
  }) {
    return EducationalGradeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
