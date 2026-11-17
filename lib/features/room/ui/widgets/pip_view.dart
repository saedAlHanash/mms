import 'package:flutter/material.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/features/room/ui/widgets/video_widget.dart';
import 'package:mms/services/pip.dart';

/// Shows only the call video while the app is in the PiP window, on top of
/// whatever page/dialog is open. The app underneath stays mounted (offstage),
/// so navigation and page state are kept when the window is expanded again.
class PipHost extends StatelessWidget {
  const PipHost({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: PipService.active,
      child: child,
      builder: (context, inPip, app) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Offstage(offstage: inPip, child: app),
            if (inPip)
              const ColoredBox(
                color: AppColorManager.black,
                child: Center(child: VideoRemoteWidget()),
              ),
          ],
        );
      },
    );
  }
}
