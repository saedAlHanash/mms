// class Room {
//   Room({
//     required this.id,
//   });
//
//   final String id;
//
//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//     };
//   }
//
//   factory Room.fromJson(Map<String, dynamic> json) {
//     return Room(
//       id: json["id"] ?? "",
//     );
//   }
//
// }
//
// class Rooms {
//   final List<Room> items;
//
//   const Rooms({
//     required this.items,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'items': items,
//     };
//   }
//
//   factory Rooms.fromJson(Map<String, dynamic> json) {
//     return Rooms(
//       items: json['items'] as List<Room>,
//     );
//   }
// }
//
