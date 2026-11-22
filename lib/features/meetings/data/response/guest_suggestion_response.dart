import 'package:mms/features/meetings/data/response/meetings_response.dart';

/// `GuestSuggestionItemDto` from `Meeting/GetGuestSuggestions`.
class GuestSuggestionItem {
  GuestSuggestionItem({required this.id, required this.email, required this.phone});

  final String id;
  final String email;
  final String phone;

  /// Same suggestion as a guest of `Meeting/GetDetails` (by id, else email or phone).
  bool matches(Guest guest) {
    if (id.isNotEmpty && id == guest.id) return true;
    if (email.isNotEmpty && email.toLowerCase() == guest.email.toLowerCase()) return true;
    return phone.isNotEmpty && phone == guest.phone;
  }

  factory GuestSuggestionItem.fromJson(Map<String, dynamic> json) {
    return GuestSuggestionItem(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'phone': phone};
}
