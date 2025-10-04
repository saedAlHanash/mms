import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:m_cubit/abstraction.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../generated/l10n.dart';
import '../app/app_widget.dart';
import '../util/snack_bar_message.dart';

class ErrorManager {
  static String getApiError(Response response) {
    switch (response.statusCode) {
      case 401:
        AppProvider.logout();
        return 'المستخدم الحالي لم يسجل الدخول';
      case 503:
        return 'Server error:  ${response.statusCode}';
      case 481:
        return '${response.body} ${response.statusCode}';
      case 482:
        return '${S().noInternet} ${response.statusCode}';

      case 404:
      case 500:
      default:
        final errorBody = ErrorBody.fromJson(response.jsonBody);
        return '${errorBody.message}\n ${response.statusCode}';
    }
  }
}

class ErrorBody {
  ErrorBody({
    required this.statusCode,
    required this.handled,
    required this.message,
    required this.detail,
    required this.extensions,
  });

  final num statusCode;
  final bool handled;
  final String message;
  final dynamic detail;
  final Extensions? extensions;

  factory ErrorBody.fromJson(Map<String, dynamic> json) {
    return ErrorBody(
      statusCode: json["statusCode"] ?? 0,
      handled: json["handled"] ?? false,
      message: json["message"] ?? "",
      detail: json["detail"],
      extensions: json["extensions"] == null ? null : Extensions.fromJson(json["extensions"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "handled": handled,
        "message": message,
        "detail": detail,
        "extensions": extensions?.toJson(),
      };
}

class Extensions {
  Extensions({required this.traceId});

  final String traceId;

  factory Extensions.fromJson(Map<String, dynamic> json) {
    return Extensions(traceId: json["traceId"] ?? "");
  }

  Map<String, dynamic> toJson() => {"traceId": traceId};
}

final shownErrorDialog = <AbstractState>[];

void showErrorFromApi(AbstractState state) {
  // return;
  if (ctx == null) return;

  final canShow = shownErrorDialog.firstWhereOrNull((e) => e.error == state.error) == null;

  if (!canShow) return;
  shownErrorDialog.add(state);
  if (shownErrorDialog.isNotEmpty) {
    NoteMessage.showAwesomeError(context: ctx!, message: state.error).then((value) {
      shownErrorDialog.removeWhere((e) => e.error == state.error);
    });
  }
}
