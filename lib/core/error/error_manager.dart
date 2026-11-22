import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/error/api_error_keys.dart';
import 'package:mms/core/extensions/extensions.dart';

import 'package:mms/generated/l10n.dart';
import 'package:mms/core/app/app_widget.dart';
import 'package:mms/core/util/snack_bar_message.dart';

class ErrorManager {
  static String getApiError(Response response) {
    switch (response.statusCode) {
      case 401:
        AppProvider.logout();
        return S().notLoggedIn;
      case 503:
        return '${S().serverError} ${response.statusCode}';
      case 481:
        return '${response.body} ${response.statusCode}';
      case 482:
        return '${S().noInternet} ${response.statusCode}';

      case 404:
      case 500:
      default:
        final errorBody = ErrorBody.fromJson(response.jsonBody);
        // Backend errors come as keys (e.g. `user_suspended`); show their translation,
        // plus the validator messages of a `validation_error` when there are any.
        final details = errorBody.extensions?.errors.map(ApiErrorKeys.translate).join('\n') ?? '';
        final message = ApiErrorKeys.translate(errorBody.message);
        return '${details.isEmpty ? message : '$message\n$details'}\n ${response.statusCode}';
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
  Extensions({required this.traceId, required this.errors});

  final String traceId;

  /// Validator messages (`Rules:Validation`), flattened from a list or a field map.
  final List<String> errors;

  factory Extensions.fromJson(Map<String, dynamic> json) {
    return Extensions(traceId: json["traceId"] ?? "", errors: _flatten(json["errors"]));
  }

  static List<String> _flatten(Object? value) => switch (value) {
        null => <String>[],
        final String text => text.trim().isEmpty ? <String>[] : [text.trim()],
        final List list => list.expand(_flatten).toList(),
        final Map map => map.values.expand(_flatten).toList(),
        _ => [value.toString()],
      };

  Map<String, dynamic> toJson() => {"traceId": traceId, "errors": errors};
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
