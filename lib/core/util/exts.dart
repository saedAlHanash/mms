import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/generated/l10n.dart';

extension LKExampleExt on BuildContext {
  //
  Future<bool?> showPublishDialog() => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const DrawableText(text: 'Publish'),
          content: const DrawableText(text: 'Would you like to publish your Camera & Mic ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const DrawableText(text: 'NO'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const DrawableText(text: 'YES'),
            ),
          ],
        ),
      );

  Future<bool?> showPlayAudioManuallyDialog() => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const DrawableText(text: 'Play Audio'),
          content: const DrawableText(text: 
              'You need to manually activate audio PlayBack for iOS Safari !'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const DrawableText(text: 'Ignore'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const DrawableText(text: 'Play Audio'),
            ),
          ],
        ),
      );

  Future<bool?> showUnPublishDialog() => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const DrawableText(text: 'UnPublish'),
          content:
              const DrawableText(text: 'Would you like to un-publish your Camera & Mic ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const DrawableText(text: 'NO'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const DrawableText(text: 'YES'),
            ),
          ],
        ),
      );

  Future<void> showErrorDialog(dynamic exception) => showDialog<void>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: DrawableText(text: S.of(ctx).oops, fontWeight: FontWeight.w700),
          content: DrawableText(text: exception.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: DrawableText(text: S.of(ctx).ok),
            )
          ],
        ),
      );

  Future<bool?> showDisconnectDialog() => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: DrawableText(text: S.of(ctx).endCallConfirm, fontWeight: FontWeight.w700),
          content: DrawableText(text: S.of(ctx).endCallConfirmDescription),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: DrawableText(text: S.of(ctx).cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: DrawableText(text: S.of(ctx).endCall, color: AppColorManager.danger),
            ),
          ],
        ),
      );

  Future<bool?> showReconnectDialog() => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const DrawableText(text: 'Reconnect'),
          content: const DrawableText(text: 'This will force a reconnection'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const DrawableText(text: 'Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const DrawableText(text: 'Reconnect'),
            ),
          ],
        ),
      );

  Future<void> showReconnectSuccessDialog() => showDialog<void>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const DrawableText(text: 'Reconnect'),
          content: const DrawableText(text: 'Reconnection was successful.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const DrawableText(text: 'OK'),
            ),
          ],
        ),
      );

  Future<bool?> showSendDataDialog() => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const DrawableText(text: 'Send data'),
          content: const DrawableText(text: 
              'This will send a sample data to all participants in the room'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const DrawableText(text: 'Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const DrawableText(text: 'Send'),
            ),
          ],
        ),
      );

  Future<bool?> showDataReceivedDialog(String data) => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const DrawableText(text: 'Received data'),
          content: DrawableText(text: data),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const DrawableText(text: 'OK'),
            ),
          ],
        ),
      );

  Future<bool?> showRecordingStatusChangedDialog(bool isActiveRecording) =>
      showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const DrawableText(text: 'Room recording reminder'),
          content: DrawableText(text: isActiveRecording
              ? 'Room recording is active.'
              : 'Room recording is stoped.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const DrawableText(text: 'OK'),
            ),
          ],
        ),
      );

  Future<bool?> showSubscribePermissionDialog() => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const DrawableText(text: 'Allow subscription'),
          content: const DrawableText(text: 
              'Allow all participants to subscribe tracks published by local participant?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const DrawableText(text: 'NO'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const DrawableText(text: 'YES'),
            ),
          ],
        ),
      );

  Future<SimulateScenarioResult?> showSimulateScenarioDialog() =>
      showDialog<SimulateScenarioResult>(
        context: this,
        builder: (ctx) => SimpleDialog(
          title: const DrawableText(text: 'Simulate Scenario'),
          children: SimulateScenarioResult.values
              .map((e) => SimpleDialogOption(
                    child: DrawableText(text: e.name),
                    onPressed: () => Navigator.pop(ctx, e),
                  ))
              .toList(),
        ),
      );
}

enum SimulateScenarioResult {
  signalReconnect,
  fullReconnect,
  speakerUpdate,
  nodeFailure,
  migration,
  serverLeave,
  switchCandidate,
  e2eeKeyRatchet,
  participantName,
  participantMetadata,
  clear,
}
