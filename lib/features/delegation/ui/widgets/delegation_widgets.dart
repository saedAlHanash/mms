import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/membership_badge.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/committees/data/response/committees_response.dart';
import 'package:mms/features/delegation/bloc/delegations_cubit/delegations_cubit.dart';
import 'package:mms/features/delegation/data/response/delegation_response.dart';
import 'package:mms/features/delegation/ui/widgets/add_delegation_sheet.dart';
import 'package:mms/generated/l10n.dart';

/// "You are acting as secretary until …" when someone delegated their role to me.
class ActingAsBanner extends StatelessWidget {
  const ActingAsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DelegationsCubit, DelegationsInitial>(
      builder: (context, state) {
        final acting = state.actingAs;
        if (acting == null) return const SizedBox.shrink();

        final until = acting.endsAt;
        return Padding(
          padding: EdgeInsets.only(bottom: 12.0.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 12.0.h),
            decoration: BoxDecoration(
              color: AppColorManager.primary50,
              borderRadius: BorderRadius.circular(12.0.r),
              border: Border.all(color: AppColorManager.primary100),
            ),
            child: Row(
              crossAxisAlignment: .start,
              children: [
                ImageMultiType(
                  url: Icons.badge_outlined,
                  width: 20.0.r,
                  height: 20.0.r,
                  color: AppColorManager.primary700,
                ),
                10.0.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      DrawableText(
                        text: until == null
                            ? S.of(context).actingAs(acting.role.name)
                            : S.of(context).actingAsUntil(acting.role.name, until.formatDate),
                        size: 14.0.sp,
                        fontWeight: .w700,
                        color: AppColorManager.primary700,
                      ),
                      2.0.verticalSpace,
                      DrawableText(
                        text: S.of(context).delegatedBy(acting.fromName),
                        size: 13.0.sp,
                        color: AppColorManager.primary700,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Committee page section: the delegations, and "Add delegation" for the chair / secretary.
class DelegationsSection extends StatelessWidget {
  const DelegationsSection({super.key, required this.committee});

  final Committee committee;

  bool get _canDelegate => !committee.member.membershipType.isMember;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DelegationsCubit, DelegationsInitial>(
      builder: (context, state) {
        final list = state.result;
        if (list.isEmpty && !_canDelegate) return const SizedBox.shrink();

        return Padding(
          padding: EdgeInsets.only(top: 24.0.h),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              SectionHeader(
                title: S.of(context).delegations,
                trailing: list.isEmpty ? null : S.of(context).itemsCount(list.length),
              ),
              10.0.verticalSpace,
              if (list.isEmpty)
                state.loading
                    ? const SkeletonBox(height: 96, radius: 12)
                    : EmptyStateWidget.card(
                        icon: Icons.swap_horiz_rounded,
                        title: S.of(context).noDelegations,
                        description: S.of(context).noDelegationsDescription,
                      )
              else
                for (final item in list) ...[
                  DelegationCard(item: item, revoking: state.revokingId == item.id),
                  10.0.verticalSpace,
                ],
              if (_canDelegate) ...[
                if (list.isEmpty) 12.0.verticalSpace,
                MyButton(
                  variant: .tonal,
                  size: .medium,
                  width: double.infinity,
                  text: S.of(context).addDelegation,
                  startIcon: ImageMultiType(
                    url: Icons.add_rounded,
                    width: 18.0.r,
                    height: 18.0.r,
                    color: AppColorManager.primary700,
                  ),
                  onTap: () => AddDelegationSheet.show(
                    context,
                    cubit: context.read<DelegationsCubit>(),
                    committee: committee,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class DelegationCard extends StatelessWidget {
  const DelegationCard({super.key, required this.item, required this.revoking});

  final Delegation item;
  final bool revoking;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final faded = item.state == DelegationState.ended || item.state == DelegationState.revoked;

    return Container(
      padding: EdgeInsets.all(14.0.r),
      decoration: BoxDecoration(
        color: faded ? AppColorManager.neutral25 : AppColorManager.neutral0,
        borderRadius: BorderRadius.circular(12.0.r),
        border: Border.all(
          color: item.state == DelegationState.active ? AppColorManager.primary300 : AppColorManager.neutral100,
        ),
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            children: [
              StatusChip(colors: item.state.colors, label: item.state.label, glow: item.state == DelegationState.active),
              const Spacer(),
              MembershipBadge(type: item.role),
            ],
          ),
          10.0.verticalSpace,
          DrawableText(
            text: s.delegationFromTo(
              item.isFromMe ? s.you : item.fromName,
              item.isToMe ? s.you : item.toName,
            ),
            size: 15.0.sp,
            fontWeight: .w700,
            color: AppColorManager.neutral900,
            maxLines: 2,
          ),
          6.0.verticalSpace,
          Row(
            children: [
              ImageMultiType(
                url: Icons.calendar_today_outlined,
                width: 14.0.r,
                height: 14.0.r,
                color: AppColorManager.neutral500,
              ),
              6.0.horizontalSpace,
              Directionality(
                textDirection: .ltr,
                child: DrawableText(
                  text: '${item.startsAt?.formatDate ?? ''} – ${item.endsAt?.formatDate ?? ''}',
                  size: 13.0.sp,
                  color: AppColorManager.neutral700,
                ),
              ),
            ],
          ),
          10.0.verticalSpace,
          Wrap(
            spacing: 6.0.w,
            runSpacing: 6.0.h,
            children: [
              if (item.coversAll)
                _ScopeChip(label: s.delegationAllScopes)
              else
                for (final scope in item.scopeList) _ScopeChip(label: scope.label),
            ],
          ),
          if (item.reason.isNotEmpty) ...[
            10.0.verticalSpace,
            DrawableText(text: item.reason, size: 13.0.sp, color: AppColorManager.neutral500, maxLines: 3),
          ],
          if (item.canRevoke) ...[
            12.0.verticalSpace,
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: MyButton(
                variant: .dangerSoft,
                size: .small,
                loading: revoking,
                text: s.revokeDelegation,
                onTap: () => NoteMessage.showCheckDialog(
                  context,
                  text: s.revokeDelegationTitle,
                  description: item.isToMe ? s.revokeDelegationToMe : s.revokeDelegationFromMe(item.toName),
                  textButton: s.revokeDelegation,
                  image: Icons.swap_horiz_rounded,
                  destructive: true,
                  onConfirm: () async {
                    final ok = await context.read<DelegationsCubit>().revoke(item.id);
                    if (ok && context.mounted) {
                      NoteMessage.showSuccessSnackBar(message: s.delegationRevoked, context: context);
                    }
                  },
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ScopeChip extends StatelessWidget {
  const _ScopeChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 4.0.h),
      decoration: BoxDecoration(
        color: AppColorManager.neutral50,
        borderRadius: BorderRadius.circular(999),
      ),
      child: DrawableText(text: label, size: 12.0.sp, fontWeight: .w600, color: AppColorManager.neutral700),
    );
  }
}
