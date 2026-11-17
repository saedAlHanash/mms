import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:native_plugin/native_plugin.dart';
import 'package:pip/pip.dart';

/// Picture-in-Picture for the online meeting.
///
/// Rules:
/// - PiP is **armed** only while the meeting page is open **and** the online
///   call is connected ([arm] / [disarm]). Outside that it never starts.
/// - When armed, the OS enters PiP by itself when the user leaves the app
///   (auto-enter: Android 12+, and Android 8–11 through `PipActivity`'s
///   `onUserLeaveHint`; iOS through the system controller). It is never
///   started from lifecycle events, so dialogs, the notification shade or the
///   screen-share consent screen don't trigger it.
/// - The back gesture/button on the meeting page enters PiP manually ([enter]).
/// - [active] is reactive, so the UI switches between the full page and the
///   PiP view immediately, and back again when the user expands the window.
/// - Disarming clears auto-enter, and closes the PiP window if the call ended
///   while it was showing.
class PipService {
  PipService._();

  static final _pip = Pip();
  static final _nativePlugin = NativePlugin();

  /// True while the app is shown in the PiP window.
  static final ValueNotifier<bool> active = ValueNotifier(false);

  static bool _initialized = false;
  static bool _supported = false;
  static bool _autoEnterSupported = false;
  static bool _armed = false;
  static int _iosContentView = 0;

  /// PiP is armed for the current call.
  static bool get isArmed => _armed;

  /// The back button can enter PiP (armed and supported on this device).
  static bool get canEnter => _armed && _supported;

  /// Checks device support and listens to PiP state. Safe to call many times.
  static Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    try {
      _supported = await _pip.isSupported();
      _autoEnterSupported = _supported && await _pip.isAutoEnterSupported();
      await _pip.registerStateChangedObserver(
        PipStateChangedObserver(
          onPipStateChanged: (state, error) {
            if (state == PipState.pipStateFailed) {
              loggerObject.w('PiP failed: $error');
              active.value = false;
              return;
            }
            active.value = state == PipState.pipStateStarted;
          },
        ),
      );
    } on PlatformException catch (e) {
      loggerObject.w('PiP not available: $e');
      _supported = false;
      _autoEnterSupported = false;
    }
  }

  /// Arms PiP for a connected call (idempotent).
  static Future<void> arm() async {
    await init();
    if (_armed || !_supported) return;
    _armed = true;

    try {
      if (Platform.isIOS && _iosContentView == 0) {
        _iosContentView = await _nativePlugin.createPipContentView();
      }

      final options = Platform.isIOS
          ? PipOptions(
              autoEnterEnabled: _autoEnterSupported,
              contentView: _iosContentView == 0 ? null : _iosContentView,
              preferredContentWidth: 480,
              preferredContentHeight: 270,
              controlStyle: 2,
            )
          : PipOptions(
              autoEnterEnabled: _autoEnterSupported,
              aspectRatioX: 16,
              aspectRatioY: 9,
            );

      final ok = await _pip.setup(options);
      if (!ok) _armed = false;
    } catch (e) {
      loggerObject.w('PiP setup failed: $e');
      _armed = false;
    }
  }

  /// Disarms PiP (call ended, or the meeting page closed). Idempotent.
  static Future<void> disarm() async {
    if (!_armed) return;
    _armed = false;

    try {
      // The call is over: don't leave the user in an empty PiP window.
      if (active.value) await _pip.stop();
      await _pip.dispose(); // also turns auto-enter off
    } catch (e) {
      loggerObject.w('PiP dispose failed: $e');
    }

    if (Platform.isIOS && _iosContentView != 0) {
      await _nativePlugin.disposePipContentView(_iosContentView);
      _iosContentView = 0;
    }
    active.value = false;
  }

  /// Enters PiP now (back gesture during a call). Returns false when it can't.
  static Future<bool> enter() async {
    if (!canEnter) return false;
    if (active.value) return true;
    try {
      return await _pip.start();
    } catch (e) {
      loggerObject.w('PiP start failed: $e');
      return false;
    }
  }
}
