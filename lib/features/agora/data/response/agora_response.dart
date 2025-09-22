class Agora {
  Agora({
    required this.id,
  });

  final String id;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }

  factory Agora.fromJson(Map<String, dynamic> json) {
    return Agora(
      id: json["id"] ?? "",
    );
  }

}

class Agoras {
  final List<Agora> items;

  const Agoras({
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items,
    };
  }

  factory Agoras.fromJson(Map<String, dynamic> json) {
    return Agoras(
      items: json['items'] as List<Agora>,
    );
  }
}

