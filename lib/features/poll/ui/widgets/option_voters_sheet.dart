import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/injection/injection_container.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/initials_avatar.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/features/poll/bloc/option_voters_cubit/option_voters_cubit.dart';
import 'package:mms/generated/l10n.dart';

/// "Who voted": each option of a poll with the people who chose it.
class OptionVotersSheet extends StatelessWidget {
  const OptionVotersSheet({super.key, required this.topic, required this.options});

  final String topic;

  /// Option id → its label, in the poll's order.
  final List<(String id, String label)> options;

  static Future<void> show(BuildContext context, {required String topic, required List<(String, String)> options}) {
    return AppBottomSheet.show(
      context,
      child: BlocProvider(
        create: (_) => sl<OptionVotersCubit>()..getData([for (final o in options) o.$1]),
        child: OptionVotersSheet(topic: topic, options: options),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          DrawableText(text: s.whoVoted, size: 17.0.sp, fontWeight: .w700, color: AppColorManager.neutral900),
          4.0.verticalSpace,
          DrawableText(text: topic, size: 13.0.sp, color: AppColorManager.neutral500, maxLines: 2),
          12.0.verticalSpace,
          Flexible(
            child: BlocBuilder<OptionVotersCubit, OptionVotersInitial>(
              builder: (context, state) {
                if (state.statuses == CubitStatuses.loading || state.statuses == CubitStatuses.init) {
                  return Column(
                    mainAxisSize: .min,
                    children: [
                      for (var i = 0; i < 3; i++) ...[SkeletonBox(height: 44.0.h), 8.0.verticalSpace],
                    ],
                  );
                }
                if (state.statuses == CubitStatuses.error) {
                  return Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .stretch,
                    children: [
                      EmptyStateWidget.inline(icon: Icons.error_outline_rounded, title: state.error),
                      12.0.verticalSpace,
                      MyButton(
                        variant: .tonal,
                        size: .medium,
                        text: s.retry,
                        onTap: () => context.read<OptionVotersCubit>().getData([for (final o in options) o.$1]),
                      ),
                    ],
                  );
                }
                return ListView(
                  shrinkWrap: true,
                  children: [
                    for (final (id, label) in options) ...[
                      _OptionHeader(label: label, count: state.result[id]?.length ?? 0),
                      if (state.result[id]?.isEmpty ?? true)
                        Padding(
                          padding: EdgeInsets.only(bottom: 12.0.h),
                          child: DrawableText(text: s.noVoters, size: 13.0.sp, color: AppColorManager.neutral500),
                        )
                      else
                        for (final voter in state.result[id]!)
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 44.0.h),
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8.0.h),
                              child: Row(
                                crossAxisAlignment: .start,
                                children: [
                                  InitialsAvatar(name: voter.name, size: 32),
                                  10.0.horizontalSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: .start,
                                      children: [
                                        DrawableText(
                                          text: voter.name,
                                          size: 14.0.sp,
                                          fontWeight: .w600,
                                          color: AppColorManager.neutral900,
                                        ),
                                        if (voter.reason.isNotEmpty)
                                          DrawableText(
                                            text: voter.reason,
                                            size: 12.0.sp,
                                            color: AppColorManager.neutral500,
                                            maxLines: 4,
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      4.0.verticalSpace,
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionHeader extends StatelessWidget {
  const _OptionHeader({required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.h),
      child: Row(
        children: [
          Expanded(
            child: DrawableText(text: label, size: 14.0.sp, fontWeight: .w700, color: AppColorManager.neutral700),
          ),
          DrawableText(text: '$count', size: 14.0.sp, fontWeight: .w700, color: AppColorManager.neutral500),
        ],
      ),
    );
  }
}
