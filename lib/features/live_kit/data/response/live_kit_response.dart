class LiveKit {
  LiveKit({
    required this.id,
  });

  final String id;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }

  factory LiveKit.fromJson(Map<String, dynamic> json) {
    return LiveKit(
      id: json["id"] ?? "",
    );
  }

}

class LiveKits {
  final List<LiveKit> items;

  const LiveKits({
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items,
    };
  }

  factory LiveKits.fromJson(Map<String, dynamic> json) {
    return LiveKits(
      items: json['items'] as List<LiveKit>,
    );
  }
}

