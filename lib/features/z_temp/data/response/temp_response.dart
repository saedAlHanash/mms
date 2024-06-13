class Temp {
  Temp();

  Map<String, dynamic> toJson() {
    return {};
  }

  factory Temp.fromJson(Map<String, dynamic> map) {
    return Temp();
  }

//</editor-fold>
}

class Temps {
  final List<Temp> items;

  const Temps({
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items,
    };
  }

  factory Temps.fromJson(Map<String, dynamic> map) {
    return Temps(
      items: map['items'] as List<Temp>,
    );
  }
}
