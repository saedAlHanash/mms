import 'dart:async';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/features/check_in/bloc/check_in_code_cubit/check_in_code_cubit.dart';
import 'package:mms/generated/l10n.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Full-screen hall QR for the secretary's tablet. Attendees scan it to check in.
class CheckInCodePage extends StatelessWidget {
  const CheckInCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.neutral0,
      appBar: AppBarWidget(titleText: S.of(context).checkInCodeTitle),
      body: BlocBuilder<CheckInCodeCubit, CheckInCodeInitial>(
        builder: (context, state) {
          final code = state.result;

          if (code.isEmpty) {
            if (state.statuses == CubitStatuses.error) {
              return Center(
                child: EmptyStateWidget.large(
                  icon: Icons.qr_code_2_rounded,
                  title: S.of(context).checkInCodeUnavailable,
                  description: state.error,
                  action: MyButton(
                    variant: .tonal,
                    size: .medium,
                    width: 160.0.w,
                    text: S.of(context).retry,
                    onTap: context.read<CheckInCodeCubit>().getData,
                  ),
                ),
              );
            }
            return Center(child: SkeletonBox(width: 260.0.r, height: 260.0.r, radius: 24));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              // As large as fits, leaving room for the digits and the timer.
              final side = (constraints.maxWidth < constraints.maxHeight - 220.0.h
                      ? constraints.maxWidth
                      : constraints.maxHeight - 220.0.h)
                  .clamp(180.0, 640.0) *
                  0.8;

              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 24.0.h),
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      DrawableText(
                        text: S.of(context).checkInCodeHint,
                        size: 15.0.sp,
                        color: AppColorManager.neutral500,
                        textAlign: .center,
                      ),
                      20.0.verticalSpace,
                      Container(
                        padding: EdgeInsets.all(16.0.r),
                        decoration: BoxDecoration(
                          color: AppColorManager.neutral0,
                          borderRadius: BorderRadius.circular(24.0.r),
                          border: Border.all(color: AppColorManager.neutral100),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: QrImageView(
                            key: ValueKey(code.code),
                            data: code.qrData,
                            size: side,
                            padding: EdgeInsets.zero,
                            backgroundColor: AppColorManager.neutral0,
                            eyeStyle: const QrEyeStyle(eyeShape: .square, color: AppColorManager.neutral900),
                            dataModuleStyle: const QrDataModuleStyle(
                              dataModuleShape: .square,
                              color: AppColorManager.neutral900,
                            ),
                          ),
                        ),
                      ),
                      20.0.verticalSpace,
                      Directionality(
                        textDirection: .ltr,
                        child: DrawableText(
                          text: code.code.length == 6
                              ? '${code.code.substring(0, 3)} ${code.code.substring(3)}'
                              : code.code,
                          size: 40.0.sp,
                          fontWeight: .w700,
                          color: AppColorManager.neutral900,
                        ),
                      ),
                      12.0.verticalSpace,
                      SizedBox(
                        width: side,
                        child: _Countdown(
                          key: ValueKey(state.fetchedAt),
                          secondsLeft: code.secondsLeft,
                          period: code.periodSeconds,
                          since: state.fetchedAt,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// Bar and "New code in 12 s", ticking locally until the next fetch.
class _Countdown extends StatefulWidget {
  const _Countdown({super.key, required this.secondsLeft, required this.period, required this.since});

  final int secondsLeft;
  final int period;
  final DateTime since;

  @override
  State<_Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<_Countdown> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 250), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passed = DateTime.now().difference(widget.since).inMilliseconds / 1000;
    final left = (widget.secondsLeft - passed).clamp(0.0, widget.period.toDouble());
    final period = widget.period <= 0 ? 20 : widget.period;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: left / period,
            minHeight: 6.0.h,
            backgroundColor: AppColorManager.neutral100,
            color: AppColorManager.primary500,
          ),
        ),
        8.0.verticalSpace,
        DrawableText(
          text: S.of(context).checkInCodeNext(left.ceil()),
          size: 13.0.sp,
          color: AppColorManager.neutral500,
        ),
      ],
    );
  }
}
