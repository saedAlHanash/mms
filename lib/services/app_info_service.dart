import 'package:package_info_plus/package_info_plus.dart';

import '../core/api_manager/api_service.dart';

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
      'version:( ${appInfo.version} ) | Build:( ${appInfo.buildNumber} )';
}
