class TempModel {

  TempModel();

  Map<String, dynamic> toJson() {
    return {};
  }

  factory TempModel.fromJson(Map<String, dynamic> map) {
    return TempModel();
  }

//</editor-fold>
}

class TempList {

  final List<TempModel> data;

//<editor-fold desc="Data Methods">
  const TempList({
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'data': this.data,
    };
  }

  factory TempList.fromJson(Map<String, dynamic> map) {
    return TempList(
      data: map['data'] as List<TempModel>,
    );
  }


}
