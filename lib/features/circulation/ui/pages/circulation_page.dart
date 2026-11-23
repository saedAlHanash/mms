import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/initials_avatar.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/circulation/bloc/circulation_cubit/circulation_cubit.dart';
import 'package:mms/features/circulation/data/response/circulation_response.dart';
import 'package:mms/features/circulation/ui/widgets/circulation_widgets.dart';
import 'package:mms/generated/l10n.dart';

/// One decision by circulation: the text, the attachment, my vote and the tally.
class CirculationPage extends StatelessWidget {
  const CirculationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).circulation),
      body: BlocBuilder<CirculationCubit, CirculationInitial>(
        buildWhen: (p, c) => p.result != c.result || p.statuses != c.statuses,
        builder: (context, state) {
          final item = state.result;
          final cubit = context.read<CirculationCubit>();

          if (item.isEmpty) {
            if (state.statuses == CubitStatuses.error) {
              return ListView(
                padding: EdgeInsets.only(top: 80.0.h),
                children: [
                  EmptyStateWidget.large(
                    icon: Icons.error_outline_rounded,
                    title: S.of(context).circulationNotFound,
                    description: state.error,
                    action: MyButton(variant: .outline, text: S.of(context).retry, onTap: cubit.getData),
                  ),
                ],
              );
            }
            return const _Skeleton();
          }

          return RefreshWidget(
            isLoading: state.loading,
            onRefresh: cubit.getData,
            child: ListView(
              padding: MyStyle.pagePadding.copyWith(top: 16.0.h, bottom: 32.0.h),
              children: [
                _Header(item: item),
                16.0.verticalSpace,
                _Statement(item: item),
                if (item.status == CirculationStatus.open) ...[
                  16.0.verticalSpace,
                  // Keyed so the form resets to the server's vote after a refresh.
                  _VoteCard(key: ValueKey('${item.myChoice}-${item.myReason}'), item: item),
                ],
                if (item.status != CirculationStatus.draft) ...[
                  16.0.verticalSpace,
                  MyCardWidget(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.all(16.0.r),
                    child: Column(
                      crossAxisAlignment: .stretch,
                      children: [
                        _CardTitle(
                          item.status == CirculationStatus.closed
                              ? S.of(context).circulationResult
                              : S.of(context).tallySoFar,
                        ),
                        14.0.verticalSpace,
                        CirculationTally(item: item),
                      ],
                    ),
                  ),
                ],
                if (item.votes.isNotEmpty || item.pendingVoters.isNotEmpty) ...[
                  16.0.verticalSpace,
                  _Voters(item: item),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return DrawableText(text: text, size: 15.0.sp, fontWeight: .w700, color: AppColorManager.neutral900);
  }
}

/// Status, outcome, number, title, dates.
class _Header extends StatelessWidget {
  const _Header({required this.item});

  final Circulation item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Wrap(
          spacing: 6.0.w,
          runSpacing: 6.0.h,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            StatusChip(colors: item.status.colors, label: item.status.label),
            if (item.outcome case final outcome?) StatusChip(colors: outcome.colors, label: outcome.label),
            if (item.numberLabel.isNotEmpty)
              Directionality(
                textDirection: .ltr,
                child: DrawableText(
                  text: '#${item.numberLabel}',
                  size: 13.0.sp,
                  fontWeight: .w700,
                  color: AppColorManager.neutral500,
                ),
              ),
          ],
        ),
        12.0.verticalSpace,
        DrawableText(
          text: item.title,
          size: 20.0.sp,
          fontWeight: .w700,
          color: AppColorManager.neutral900,
          matchParent: true,
        ),
        10.0.verticalSpace,
        if (item.status == CirculationStatus.open)
          DeadlineCountdown(deadline: item.deadline, passed: item.deadlinePassed, size: 14),
        if (item.deadline case final deadline?) ...[
          4.0.verticalSpace,
          _Meta(label: S.of(context).deadline, value: deadline.formatDateTime),
        ],
        if (item.closedAt case final closedAt?) ...[
          4.0.verticalSpace,
          _Meta(label: S.of(context).closedAt, value: closedAt.formatDateTime),
        ],
      ],
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DrawableText(text: '$label: ', size: 13.0.sp, color: AppColorManager.neutral500),
        Directionality(
          textDirection: .ltr,
          child: DrawableText(text: value, size: 13.0.sp, fontWeight: .w600, color: AppColorManager.neutral700),
        ),
      ],
    );
  }
}

/// Decision text + attachment.
class _Statement extends StatelessWidget {
  const _Statement({required this.item});

  final Circulation item;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      tone: .soft,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.all(16.0.r),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          _CardTitle(S.of(context).decisionText),
          10.0.verticalSpace,
          DrawableText(
            text: item.statement.isEmpty ? '—' : item.statement,
            style: TextStyle(fontSize: 15.0.sp, height: 26 / 15, color: AppColorManager.neutral700),
            matchParent: true,
          ),
          if (item.hasAttachment) ...[
            14.0.verticalSpace,
            BlocBuilder<CirculationCubit, CirculationInitial>(
              buildWhen: (p, c) => p.openingFile != c.openingFile,
              builder: (context, state) {
                final radius = BorderRadius.circular(10.0.r);
                return Material(
                  color: AppColorManager.neutral0,
                  borderRadius: radius,
                  child: InkWell(
                    borderRadius: radius,
                    onTap: state.openingFile ? null : context.read<CirculationCubit>().openAttachment,
                    child: Ink(
                      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.0.h),
                      decoration: BoxDecoration(
                        borderRadius: radius,
                        border: Border.all(color: AppColorManager.neutral100),
                      ),
                      child: Row(
                        children: [
                          ImageMultiType(
                            url: Icons.insert_drive_file_outlined,
                            width: 22.0.r,
                            height: 22.0.r,
                            color: AppColorManager.primary500,
                          ),
                          10.0.horizontalSpace,
                          Expanded(
                            child: DrawableText(
                              text: item.mediaName.isEmpty ? S.of(context).attachment : item.mediaName,
                              size: 14.0.sp,
                              fontWeight: .w600,
                              color: AppColorManager.neutral900,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            width: 24.0.r,
                            height: 24.0.r,
                            child: state.openingFile
                                ? const Padding(
                                    padding: EdgeInsets.all(3),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColorManager.primary500,
                                    ),
                                  )
                                : ImageMultiType(
                                    url: Icons.open_in_new_rounded,
                                    width: 20.0.r,
                                    height: 20.0.r,
                                    color: AppColorManager.neutral500,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

/// Approve / Reject / Abstain with an optional reason; can be changed while open.
class _VoteCard extends StatefulWidget {
  const _VoteCard({super.key, required this.item});

  final Circulation item;

  @override
  State<_VoteCard> createState() => _VoteCardState();
}

class _VoteCardState extends State<_VoteCard> {
  static const _maxReason = 500;

  late CirculationChoice? _choice = widget.item.myChoice;
  late final _reason = TextEditingController(text: widget.item.myReason);

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  bool get _changed =>
      _choice != null && (_choice != widget.item.myChoice || _reason.text.trim() != widget.item.myReason.trim());

  Future<void> _submit() async {
    final choice = _choice;
    if (choice == null) return;
    FocusScope.of(context).unfocus();
    final updated = await context.read<CirculationCubit>().vote(choice, reason: _reason.text);
    if (updated != null && mounted) {
      NoteMessage.showSuccessSnackBar(message: S.of(context).circulationVoteSaved, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    if (!item.canVote) {
      return _Notice(icon: Icons.info_outline_rounded, text: S.of(context).notACirculationVoter);
    }
    if (item.deadlinePassed) {
      return _Notice(icon: Icons.timer_off_outlined, text: S.of(context).circulationVotingClosed);
    }

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0.r),
      borderSide: const BorderSide(color: AppColorManager.neutral200),
    );

    return MyCardWidget(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.all(16.0.r),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          _CardTitle(S.of(context).yourVote),
          if (item.myChoice case final mine?) ...[
            6.0.verticalSpace,
            DrawableText(
              text: S.of(context).youVotedCanChange(mine.label),
              size: 13.0.sp,
              color: AppColorManager.neutral500,
            ),
          ],
          14.0.verticalSpace,
          Row(
            children: [
              for (final choice in CirculationChoice.values) ...[
                if (choice != CirculationChoice.values.first) 8.0.horizontalSpace,
                Expanded(
                  child: _ChoiceTile(
                    choice: choice,
                    selected: _choice == choice,
                    onTap: () => setState(() => _choice = choice),
                  ),
                ),
              ],
            ],
          ),
          16.0.verticalSpace,
          DrawableText(
            text: S.of(context).reasonOptional,
            size: 14.0.sp,
            fontWeight: .w600,
            color: AppColorManager.neutral700,
          ),
          6.0.verticalSpace,
          SizedBox(
            height: 88.0.h,
            child: TextField(
              controller: _reason,
              expands: true,
              maxLines: null,
              maxLength: _maxReason,
              buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null,
              textAlignVertical: TextAlignVertical.top,
              onChanged: (_) => setState(() {}),
              style: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral900),
              decoration: InputDecoration(
                hintText: S.of(context).circulationReasonHint,
                hintStyle: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral500),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.0.h),
                border: border,
                enabledBorder: border,
                focusedBorder: border.copyWith(
                  borderSide: const BorderSide(color: AppColorManager.primary500, width: 2),
                ),
              ),
            ),
          ),
          16.0.verticalSpace,
          BlocBuilder<CirculationCubit, CirculationInitial>(
            buildWhen: (p, c) => p.voting != c.voting,
            builder: (context, state) {
              return MyButton(
                width: double.infinity,
                enable: _changed,
                loading: state.voting != null,
                text: item.myChoice == null ? S.of(context).submitVote : S.of(context).changeVote,
                onTap: _submit,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({required this.choice, required this.selected, required this.onTap});

  final CirculationChoice choice;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = choice.colors;
    final radius = BorderRadius.circular(12.0.r);

    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? colors.bg : AppColorManager.neutral0,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            constraints: BoxConstraints(minHeight: 76.0.h),
            padding: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 6.0.w),
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(color: selected ? colors.dot : AppColorManager.neutral200, width: selected ? 2 : 1),
            ),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                ImageMultiType(
                  url: choice.icon,
                  width: 24.0.r,
                  height: 24.0.r,
                  color: selected ? colors.dot : AppColorManager.neutral500,
                ),
                6.0.verticalSpace,
                DrawableText(
                  text: choice.label,
                  size: 14.0.sp,
                  fontWeight: selected ? .w700 : .w600,
                  color: selected ? colors.fg : AppColorManager.neutral700,
                  textAlign: .center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.0.r),
      decoration: BoxDecoration(color: AppColorManager.neutral50, borderRadius: BorderRadius.circular(12.0.r)),
      child: DrawableText(
        text: text,
        size: 14.0.sp,
        color: AppColorManager.neutral700,
        matchParent: true,
        drawablePadding: 8.0.w,
        drawableStart: ImageMultiType(url: icon, width: 20.0.r, height: 20.0.r, color: AppColorManager.neutral500),
      ),
    );
  }
}

/// Who voted what, and who hasn't voted yet.
class _Voters extends StatelessWidget {
  const _Voters({required this.item});

  final Circulation item;

  @override
  Widget build(BuildContext context) {
    final myId = AppProvider.getParty.id;
    String name(String partyId, String name) => partyId == myId ? '$name (${S.of(context).you})' : name;

    return MyCardWidget(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.all(16.0.r),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          _CardTitle(S.of(context).circulationVotes(item.votes.length)),
          for (final vote in item.votes) ...[
            const Divider(height: 20, color: AppColorManager.neutral100),
            Row(
              crossAxisAlignment: .start,
              children: [
                InitialsAvatar(name: vote.name, size: 36),
                10.0.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      DrawableText(
                        text: name(vote.partyId, vote.name),
                        size: 14.0.sp,
                        fontWeight: .w600,
                        color: AppColorManager.neutral900,
                        maxLines: 1,
                      ),
                      if (vote.reason.isNotEmpty) ...[
                        2.0.verticalSpace,
                        DrawableText(text: vote.reason, size: 13.0.sp, color: AppColorManager.neutral500),
                      ],
                    ],
                  ),
                ),
                if (vote.choice case final choice?) ...[
                  8.0.horizontalSpace,
                  StatusChip(colors: choice.colors, label: choice.label),
                ],
              ],
            ),
          ],
          if (item.pendingVoters.isNotEmpty) ...[
            16.0.verticalSpace,
            DrawableText(
              text: S.of(context).notVotedYetCount(item.pendingVoters.length),
              size: 12.0.sp,
              fontWeight: .w600,
              color: AppColorManager.neutral500,
            ),
            8.0.verticalSpace,
            Wrap(
              spacing: 6.0.w,
              runSpacing: 6.0.h,
              children: [
                for (final voter in item.pendingVoters)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 4.0.h),
                    decoration: BoxDecoration(
                      color: AppColorManager.neutral50,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: DrawableText(
                      text: name(voter.partyId, voter.name),
                      size: 13.0.sp,
                      color: AppColorManager.neutral700,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: MyStyle.pagePadding.copyWith(top: 16.0.h),
      children: [
        SkeletonBox(width: 120.0.w, height: 24, radius: 999),
        12.0.verticalSpace,
        const SkeletonBox(height: 28, radius: 6),
        20.0.verticalSpace,
        const SkeletonBox(height: 160, radius: 16),
        16.0.verticalSpace,
        const SkeletonBox(height: 220, radius: 12),
      ],
    );
  }
}
