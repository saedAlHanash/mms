import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/router/app_router.dart';

import '../../generated/l10n.dart';
import '../app/app_widget.dart';
import '../util/abstraction.dart';
import '../util/snack_bar_message.dart';

class ErrorManager {
  static String getApiError(Response response) {
    switch (response.statusCode) {
      case 401:
        AppProvider.logout();

        if (ctx != null) {
          Navigator.pushNamedAndRemoveUntil(ctx!, RouteName.login, (route) => false);
        }
        return ' المستخدم الحالي لم يسجل الدخول ' '${response.statusCode}';

      case 503:
        return 'حدث تغيير في المخدم رمز الخطأ 503 ' '${response.statusCode}';
      case 481:
        return 'لا يوجد اتصال بالانترنت' '${response.statusCode}';
      case 482:
        return ctx == null ? S().noInternet : S.of(ctx!).noInternet;

      case 404:
      case 500:
      default:
        final errorBody = ErrorBody.fromJson(response.jsonBodyPure);
        return '${errorBody.errors.join('\n')}\n ${response.statusCode}';
    }
  }
}

class ErrorBody {
  ErrorBody({
    required this.errors,
  });

  final List<String> errors;

  factory ErrorBody.fromJson(Map<String, dynamic> json) {
    final item = json["errors"];
    return ErrorBody(
      errors: item == null
          ? []
          : item is Map
              ? [
                  item['message'] ?? item.toString(),
                ]
              : List<String>.from(
                  item!.map((x) => x),
                ),
    );
  }

  Map<String, dynamic> toJson() => {
        "errors": errors.map((x) => x).toList(),
      };
}

showErrorFromApi(AbstractCubit state) {
  if (ctx == null) return;

  NoteMessage.showAwesomeError(context: ctx!, message: state.error);
}
