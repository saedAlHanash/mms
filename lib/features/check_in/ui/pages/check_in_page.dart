import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/verification_code_widget.dart';
import 'package:mms/features/check_in/bloc/check_in_cubit/check_in_cubit.dart';
import 'package:mms/features/check_in/data/response/check_in_response.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Hall check-in: scan the QR at the door, or type its six digits.
/// Pops `true` once the arrival is recorded.
class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key, required this.meetingId});

  final String meetingId;

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  final _scanner = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  final _codeController = TextEditingController();

  String _code = '';

  CheckInCubit get _cubit => context.read<CheckInCubit>();

  @override
  void dispose() {
    _scanner.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_cubit.state.statuses == CubitStatuses.loading || !_cubit.state.result.isEmpty) return;

    for (final barcode in capture.barcodes) {
      final parsed = parseCheckInQr(barcode.rawValue ?? '');
      if (parsed == null) continue;

      if (parsed.meetingId.isNotEmpty && parsed.meetingId != widget.meetingId) {
        NoteMessage.showErrorSnackBar(message: S.of(context).checkInOtherMeeting, context: context);
        return;
      }
      _cubit.scan(meetingId: widget.meetingId, code: parsed.code);
      return;
    }
  }

  void _submitCode() {
    if (_code.length != 6) return;
    FocusScope.of(context).unfocus();
    _cubit.scan(meetingId: widget.meetingId, code: _code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).checkIn),
      body: BlocConsumer<CheckInCubit, CheckInInitial>(
        listenWhen: (p, c) => p.statuses != c.statuses,
        listener: (context, state) {
          // Recorded: the camera isn't needed any more.
          if (state.statuses == CubitStatuses.done) _scanner.stop();
          // Rejected: start the typed code again.
          if (state.statuses == CubitStatuses.error) {
            _codeController.clear();
            setState(() => _code = '');
          }
        },
        builder: (context, state) {
          if (!state.result.isEmpty) return _Done(result: state.result);

          return ListView(
            padding: MyStyle.pagePadding.copyWith(top: 16.0.h, bottom: 32.0.h),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0.r),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const ColoredBox(color: AppColorManager.neutral900),
                      MobileScanner(
                        controller: _scanner,
                        onDetect: _onDetect,
                        errorBuilder: (context, error) => _CameraError(error: error),
                        overlayBuilder: (context, constraints) => const _Viewfinder(),
                      ),
                      if (state.loading)
                        ColoredBox(
                          color: AppColorManager.neutral900.withValues(alpha: 0.5),
                          child: const Center(child: CircularProgressIndicator(color: AppColorManager.neutral0)),
                        ),
                    ],
                  ),
                ),
              ),
              12.0.verticalSpace,
              DrawableText(
                text: S.of(context).checkInScanHint,
                size: 13.0.sp,
                color: AppColorManager.neutral500,
                textAlign: .center,
                matchParent: true,
              ),
              20.0.verticalSpace,
              const _OrDivider(),
              20.0.verticalSpace,
              MyCardWidget(
                tone: .soft,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.all(16.0.r),
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    DrawableText(
                      text: S.of(context).checkInTypeCode,
                      size: 14.0.sp,
                      fontWeight: .w600,
                      color: AppColorManager.neutral900,
                      textAlign: .center,
                      matchParent: true,
                    ),
                    16.0.verticalSpace,
                    PinCodeWidget(
                      controller: _codeController,
                      enabled: !state.loading,
                      onChange: (value) => setState(() => _code = value),
                      onCompleted: (value) {
                        _code = value;
                        _submitCode();
                      },
                    ),
                    20.0.verticalSpace,
                    MyButton(
                      width: double.infinity,
                      enable: _code.length == 6,
                      loading: state.loading,
                      text: S.of(context).checkIn,
                      onTap: _submitCode,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Dimmed frame with corner brackets marking where the code should sit.
class _Viewfinder extends StatelessWidget {
  const _Viewfinder();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        size: Size.infinite,
        painter: _ViewfinderPainter(
          dim: AppColorManager.neutral900.withValues(alpha: 0.45),
          corner: AppColorManager.neutral0,
          radius: 18.0.r,
        ),
      ),
    );
  }
}

class _ViewfinderPainter extends CustomPainter {
  _ViewfinderPainter({required this.dim, required this.corner, required this.radius});

  final Color dim;
  final Color corner;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final side = size.shortestSide * 0.66;
    final window = Rect.fromCenter(center: size.center(Offset.zero), width: side, height: side);
    final r = radius;

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Offset.zero & size),
        Path()..addRRect(RRect.fromRectAndRadius(window, Radius.circular(r))),
      ),
      Paint()..color = dim,
    );

    final paint = Paint()
      ..color = corner
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final arm = side * 0.16;
    final l = window.left, t = window.top, rt = window.right, b = window.bottom;
    final round = Radius.circular(r);

    canvas
      ..drawPath(
        Path()
          ..moveTo(l, t + arm)
          ..lineTo(l, t + r)
          ..arcToPoint(Offset(l + r, t), radius: round)
          ..lineTo(l + arm, t),
        paint,
      )
      ..drawPath(
        Path()
          ..moveTo(rt - arm, t)
          ..lineTo(rt - r, t)
          ..arcToPoint(Offset(rt, t + r), radius: round)
          ..lineTo(rt, t + arm),
        paint,
      )
      ..drawPath(
        Path()
          ..moveTo(rt, b - arm)
          ..lineTo(rt, b - r)
          ..arcToPoint(Offset(rt - r, b), radius: round)
          ..lineTo(rt - arm, b),
        paint,
      )
      ..drawPath(
        Path()
          ..moveTo(l + arm, b)
          ..lineTo(l + r, b)
          ..arcToPoint(Offset(l, b - r), radius: round)
          ..lineTo(l, b - arm),
        paint,
      );
  }

  @override
  bool shouldRepaint(covariant _ViewfinderPainter old) =>
      old.dim != dim || old.corner != corner || old.radius != radius;
}

/// "—— or ——" between the scanner and the typed code.
class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(height: 1, color: AppColorManager.neutral100)),
        12.0.horizontalSpace,
        DrawableText(text: S.of(context).or, size: 13.0.sp, color: AppColorManager.neutral500),
        12.0.horizontalSpace,
        const Expanded(child: Divider(height: 1, color: AppColorManager.neutral100)),
      ],
    );
  }
}

/// No camera (denied, missing): the code can still be typed in.
class _CameraError extends StatelessWidget {
  const _CameraError({required this.error});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    final denied = error.errorCode == MobileScannerErrorCode.permissionDenied;
    return ColoredBox(
      color: AppColorManager.neutral50,
      child: Padding(
        padding: EdgeInsets.all(24.0.r),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            ImageMultiType(
              url: Icons.no_photography_outlined,
              width: 40.0.r,
              height: 40.0.r,
              color: AppColorManager.neutral500,
            ),
            12.0.verticalSpace,
            DrawableText(
              text: denied ? S.of(context).cameraPermissionDenied : S.of(context).cameraUnavailable,
              size: 14.0.sp,
              color: AppColorManager.neutral700,
              textAlign: .center,
            ),
          ],
        ),
      ),
    );
  }
}

/// "Checked in at 10:02 (in the hall)".
class _Done extends StatelessWidget {
  const _Done({required this.result});

  final CheckInResult result;

  @override
  Widget build(BuildContext context) {
    final time = result.attendedAt;
    final place = switch (result.location) {
      CheckInLocation.physical => S.of(context).checkInInHall,
      CheckInLocation.online => S.of(context).checkInOnline,
      null => '',
    };

    return Padding(
      padding: MyStyle.pagePadding.copyWith(top: 32.0.h, bottom: 32.0.h),
      child: Column(
        children: [
          MyCardWidget(
            tone: .soft,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.all(24.0.r),
            child: Column(
              children: [
                Container(
                  width: 72.0.r,
                  height: 72.0.r,
                  alignment: .center,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColorManager.successSoft),
                  child: ImageMultiType(
                    url: Icons.check_rounded,
                    width: 40.0.r,
                    height: 40.0.r,
                    color: AppColorManager.success,
                  ),
                ),
                16.0.verticalSpace,
                DrawableText(
                  text: result.alreadyCheckedIn ? S.of(context).checkInAlready : S.of(context).checkInDone,
                  size: 18.0.sp,
                  fontWeight: .w700,
                  color: AppColorManager.neutral900,
                  textAlign: .center,
                ),
                if (time != null) ...[
                  8.0.verticalSpace,
                  Wrap(
                    alignment: .center,
                    spacing: 6.0.w,
                    children: [
                      DrawableText(text: S.of(context).checkInAt, size: 14.0.sp, color: AppColorManager.neutral700),
                      Directionality(
                        textDirection: .ltr,
                        child: DrawableText(
                          text: time.formatTime,
                          size: 14.0.sp,
                          fontWeight: .w700,
                          color: AppColorManager.neutral900,
                        ),
                      ),
                      if (place.isNotEmpty)
                        DrawableText(text: '($place)', size: 14.0.sp, color: AppColorManager.neutral700),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const Spacer(),
          MyButton(
            width: double.infinity,
            text: S.of(context).done,
            onTap: () => context.pop(true),
          ),
        ],
      ),
    );
  }
}
