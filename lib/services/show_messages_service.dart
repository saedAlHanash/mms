import 'package:e_move/core/util/snack_bar_message.dart';

import '../core/app/app_widget.dart';

class ShowMessagesService {
  static void showErrorSnackBarServise(String message) {
    if (ctx != null) {
      NoteMessage.showErrorSnackBar(
        message: 'Location services are disabled.',
        context: ctx!,
      );
    }
  }
}
