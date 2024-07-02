import 'package:package_info_plus/package_info_plus.dart';

import '../core/api_manager/api_service.dart';
import '../core/app/app_widget.dart';
import '../generated/l10n.dart';

PackageInfo? _appData;

class AppInfoService {
  static Future<void> initial() async {
    try {
      _appData = await PackageInfo.fromPlatform();
    } catch (e) {
      loggerObject.e(e);
    }
  }

  static PackageInfo get appInfo => _appData!;

  static String get fullVersionName =>
      '${S.of(ctx!).version}:( ${appInfo.version} ) | ${S.of(ctx!).build}:( ${appInfo.buildNumber} )';
}
