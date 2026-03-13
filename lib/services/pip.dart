import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:native_plugin/native_plugin.dart';
import 'package:pip/pip.dart';

class PipService {
  static final _pip = Pip();
  static final _nativePlugin = NativePlugin();
  static var _isPipAutoEnterSupported = false;
  static final _playerView = 0;
  static var _pipContentView = 0;
  static var _autoEnterEnabled = false;
  static var _lastAppLifecycleState = AppLifecycleState.resumed;

  static Future<void> start() async {
    await _pip.start();
  }

  static Future<void> stop() async {
    await _pip.stop();
  }

  static Future<void> initial() async {
    try {
      await _nativePlugin.getPlatformVersion();
      _isPipAutoEnterSupported = await _pip.isAutoEnterSupported();
      await _pip.registerStateChangedObserver(PipStateChangedObserver(
        onPipStateChanged: (state, error) {
          if (state == PipState.pipStateFailed) {
            _pip.dispose();
          }
        },
      ));
    } on PlatformException {
      _isPipAutoEnterSupported = false;
    }
    _autoEnterEnabled = true;

    await _setupPip();
  }

  static void dispose() {
    if (Platform.isIOS && _pipContentView != 0) {
      _nativePlugin.disposePipContentView(_pipContentView);
    }
  }

  static Future<void> _setupPip() async {
    if (Platform.isIOS && _pipContentView == 0) {
      _pipContentView = await _nativePlugin.createPipContentView();
    }

    final options = PipOptions(
      autoEnterEnabled: _autoEnterEnabled,
      seamlessResizeEnabled: true,
      useExternalStateMonitor: true,
      externalStateMonitorInterval: 100,
      // ios only
      contentView: _pipContentView,
      sourceContentView: _playerView,
      controlStyle: 2,
    );

    try {
      await _pip.setup(options);
    } catch (_) {}
  }

  PipService._();

  static Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive) {
      if (_lastAppLifecycleState != AppLifecycleState.paused && !_isPipAutoEnterSupported) {
        await _pip.start();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (!Platform.isAndroid) await _pip.stop();
    }

    switch (state) {
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (_lastAppLifecycleState != state) _lastAppLifecycleState = state;
        break;
      default:
        break;
    }
  }
}
