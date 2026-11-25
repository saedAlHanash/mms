import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/icon_tile.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/reason_sheet.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/sub_committee/bloc/recommendations_cubit/recommendations_cubit.dart';
import 'package:mms/features/sub_committee/data/response/sub_committee_response.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/go_router.dart';

/// The committee's parent and sub-committees, and recommendations: raised to the
/// parent, and received from sub-committees. [isLead] shows raise / answer / withdraw.
class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({super.key, required this.isLead});

  final bool isLead;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RecommendationsCubit>();
    final s = S.of(context);

    return Scaffold(
      appBar: AppBarWidget(titleText: s.recommendations),
      body: BlocBuilder<RecommendationsCubit, RecommendationsInitial>(
        builder: (context, state) {
          final tree = state.tree;
          final canRaise = isLead && tree.hasParent;
          final Widget body;

          if (state.loading && state.result.isEmpty && tree.committeeId.isEmpty) {
            body = ListView(
              padding: EdgeInsets.all(20.0.r),
              children: [
                const SkeletonBox(height: 96, radius: 14),
                16.0.verticalSpace,
                for (var i = 0; i < 3; i++) ...[const SkeletonBox(height: 120, radius: 14), 12.0.verticalSpace],
              ],
            );
          } else {
            final sent = state.sent;
            final received = state.received;
            body = ListView(
              padding: EdgeInsets.fromLTRB(20.0.w, 16.0.h, 20.0.w, 32.0.h),
              children: [
                if (tree.hasParent || tree.children.isNotEmpty) ...[_TreeCard(tree: tree), 20.0.verticalSpace],
                if (canRaise) ...[
                  MyButton(
                    size: .medium,
                    width: double.infinity,
                    text: s.raiseRecommendation,
                    startIcon: ImageMultiType(
                      url: Icons.north_rounded,
                      width: 18.0.r,
                      height: 18.0.r,
                      color: AppColorManager.neutral0,
                    ),
                    onTap: () => _RaiseSheet.show(context, cubit: cubit, parentName: tree.parent?.name ?? ''),
                  ),
                  20.0.verticalSpace,
                ],
                if (sent.isEmpty && received.isEmpty)
                  EmptyStateWidget.card(
                    icon: Icons.recommend_outlined,
                    title: s.noRecommendations,
                    description: tree.hasParent || tree.children.isNotEmpty
                        ? s.noRecommendationsDescription
                        : s.noSubCommittees,
                  ),
                if (received.isNotEmpty) ...[
                  SectionHeader(title: s.recommendationsReceived, trailing: s.itemsCount(received.length)),
                  10.0.verticalSpace,
                  for (final item in received) ...[
                    _RecommendationCard(item: item, received: true, isLead: isLead, busy: state.busyId == item.id),
                    12.0.verticalSpace,
                  ],
                  12.0.verticalSpace,
                ],
                if (sent.isNotEmpty) ...[
                  SectionHeader(title: s.recommendationsSent, trailing: s.itemsCount(sent.length)),
                  10.0.verticalSpace,
                  for (final item in sent) ...[
                    _RecommendationCard(item: item, received: false, isLead: isLead, busy: state.busyId == item.id),
                    12.0.verticalSpace,
                  ],
                ],
              ],
            );
          }

          return RefreshWidget(isLoading: state.loading, onRefresh: cubit.getData, child: body);
        },
      ),
    );
  }
}

/// Parent committee and direct sub-committees; tapping opens that committee.
class _TreeCard extends StatelessWidget {
  const _TreeCard({required this.tree});

  final CommitteeTree tree;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final parent = tree.parent;

    return Container(
      padding: EdgeInsets.all(14.0.r),
      decoration: BoxDecoration(
        color: AppColorManager.neutral0,
        borderRadius: BorderRadius.circular(14.0.r),
        border: Border.all(color: AppColorManager.neutral100),
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          if (parent != null) ...[
            _Label(s.parentCommittee),
            6.0.verticalSpace,
            _NodeRow(node: parent, icon: Icons.account_tree_outlined),
          ],
          if (parent != null && tree.children.isNotEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(height: 1, color: AppColorManager.neutral100),
            ),
          if (tree.children.isNotEmpty) ...[
            _Label(s.subCommitteesCount(tree.children.length)),
            6.0.verticalSpace,
            for (final child in tree.children) _NodeRow(node: child, icon: Icons.subdirectory_arrow_left_rounded),
          ],
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return DrawableText(text: text, size: 12.0.sp, fontWeight: .w600, color: AppColorManager.neutral500);
  }
}

class _NodeRow extends StatelessWidget {
  const _NodeRow({required this.node, required this.icon});

  final CommitteeNode node;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0.r),
      onTap: () => context.pushNamed(RouteName.committeePage, queryParameters: {RouteParam.id: node.id}),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 48.0.h),
        child: Row(
          children: [
            IconTile(icon: icon, size: 36, tone: node.isActive ? .primary : .neutral),
            10.0.horizontalSpace,
            Expanded(
              child: DrawableText(
                text: node.name,
                size: 14.0.sp,
                fontWeight: .w600,
                color: node.isActive ? AppColorManager.neutral900 : AppColorManager.neutral500,
                maxLines: 2,
              ),
            ),
            ImageMultiType(
              url: Directionality.of(context) == .rtl ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
              width: 20.0.r,
              height: 20.0.r,
              color: AppColorManager.neutral500,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({required this.item, required this.received, required this.isLead, required this.busy});

  final Recommendation item;

  /// From a sub-committee (answerable here), or raised by this committee.
  final bool received;
  final bool isLead;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final cubit = context.read<RecommendationsCubit>();

    return Container(
      padding: EdgeInsets.all(14.0.r),
      decoration: BoxDecoration(
        color: AppColorManager.neutral0,
        borderRadius: BorderRadius.circular(14.0.r),
        border: Border.all(color: item.isPending && received ? AppColorManager.primary300 : AppColorManager.neutral100),
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            children: [
              StatusChip(colors: item.state.colors, label: item.state.label),
              8.0.horizontalSpace,
              Expanded(
                child: DrawableText(
                  text: received ? s.fromCommittee(item.committeeName) : s.toCommittee(item.parentCommitteeName),
                  size: 12.0.sp,
                  color: AppColorManager.neutral500,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          10.0.verticalSpace,
          DrawableText(
            text: item.title,
            size: 15.0.sp,
            fontWeight: .w700,
            color: AppColorManager.neutral900,
            maxLines: 3,
          ),
          if (item.body.isNotEmpty) ...[
            6.0.verticalSpace,
            DrawableText(text: item.body, size: 13.0.sp, color: AppColorManager.neutral700, maxLines: 8),
          ],
          8.0.verticalSpace,
          DrawableText(
            text: item.raisedAt == null
                ? s.raisedBy(item.raisedByName)
                : '${s.raisedBy(item.raisedByName)} · ${item.raisedAt!.formatDate}',
            size: 12.0.sp,
            color: AppColorManager.neutral500,
          ),
          if (!item.isPending && (item.responseNote.isNotEmpty || item.respondedByName.isNotEmpty)) ...[
            10.0.verticalSpace,
            Container(
              padding: EdgeInsets.all(10.0.r),
              decoration: BoxDecoration(
                color: AppColorManager.neutral25,
                borderRadius: BorderRadius.circular(10.0.r),
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  if (item.respondedByName.isNotEmpty)
                    DrawableText(
                      text: s.respondedBy(item.respondedByName),
                      size: 12.0.sp,
                      fontWeight: .w600,
                      color: AppColorManager.neutral700,
                    ),
                  if (item.responseNote.isNotEmpty)
                    DrawableText(text: item.responseNote, size: 13.0.sp, color: AppColorManager.neutral700),
                ],
              ),
            ),
          ],
          if (isLead && item.isPending) ...[
            12.0.verticalSpace,
            if (received)
              Row(
                children: [
                  Expanded(
                    child: MyButton(
                      variant: .dangerSoft,
                      size: .medium,
                      enable: !busy,
                      text: s.reject,
                      onTap: () => _respond(context, cubit, approve: false),
                    ),
                  ),
                  8.0.horizontalSpace,
                  Expanded(
                    child: MyButton(
                      size: .medium,
                      loading: busy,
                      text: s.approve,
                      onTap: () => _respond(context, cubit, approve: true),
                    ),
                  ),
                ],
              )
            else
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: MyButton(
                  variant: .dangerSoft,
                  size: .small,
                  loading: busy,
                  text: s.withdraw,
                  onTap: () => NoteMessage.showCheckDialog(
                    context,
                    text: s.withdrawRecommendationTitle,
                    description: item.title,
                    textButton: s.withdraw,
                    image: Icons.undo_rounded,
                    destructive: true,
                    onConfirm: () => cubit.withdraw(item.id),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Future<void> _respond(BuildContext context, RecommendationsCubit cubit, {required bool approve}) async {
    final s = S.of(context);
    final note = await ReasonSheet.show(
      context,
      title: approve ? s.approveRecommendationTitle : s.rejectRecommendationTitle,
      description: item.title,
      hint: s.responseNoteHint,
      confirmText: approve ? s.approve : s.reject,
      required: false,
      destructive: !approve,
    );
    if (note == null) return;
    final ok = await cubit.respond(item.id, approve: approve, note: note);
    if (ok && context.mounted) NoteMessage.showSuccessSnackBar(message: s.responseSent, context: context);
  }
}

/// Title (required) and body.
class _RaiseSheet extends StatefulWidget {
  const _RaiseSheet({required this.parentName});

  final String parentName;

  static Future<void> show(BuildContext context, {required RecommendationsCubit cubit, required String parentName}) {
    return AppBottomSheet.show(
      context,
      child: BlocProvider.value(value: cubit, child: _RaiseSheet(parentName: parentName)),
    );
  }

  @override
  State<_RaiseSheet> createState() => _RaiseSheetState();
}

class _RaiseSheetState extends State<_RaiseSheet> {
  final _title = TextEditingController();
  final _body = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final ok = await context.read<RecommendationsCubit>().raise(title: _title.text, body: _body.text);
    if (ok && mounted) {
      NoteMessage.showSuccessSnackBar(message: S.of(context).recommendationRaised, context: context);
      Navigator.pop(context);
    }
  }

  InputDecoration _decoration(String hint) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0.r),
      borderSide: const BorderSide(color: AppColorManager.neutral200),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral500),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.0.h),
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(borderSide: const BorderSide(color: AppColorManager.primary500, width: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    Widget noCounter(_, {required currentLength, required isFocused, required maxLength}) => const SizedBox.shrink();

    return BlocBuilder<RecommendationsCubit, RecommendationsInitial>(
      buildWhen: (p, c) => p.sending != c.sending,
      builder: (context, state) {
        return Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            DrawableText(
              text: s.raiseRecommendation,
              size: 18.0.sp,
              fontWeight: .w700,
              color: AppColorManager.neutral900,
            ),
            if (widget.parentName.isNotEmpty) ...[
              4.0.verticalSpace,
              DrawableText(text: s.toCommittee(widget.parentName), size: 13.0.sp, color: AppColorManager.neutral500),
            ],
            16.0.verticalSpace,
            TextField(
              controller: _title,
              autofocus: true,
              maxLength: 300,
              buildCounter: noCounter,
              onChanged: (_) => setState(() {}),
              style: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral900),
              decoration: _decoration(s.recommendationTitleHint),
            ),
            12.0.verticalSpace,
            SizedBox(
              height: 140.0.h,
              child: TextField(
                controller: _body,
                expands: true,
                maxLines: null,
                maxLength: 4000,
                buildCounter: noCounter,
                textAlignVertical: TextAlignVertical.top,
                style: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral900),
                decoration: _decoration(s.recommendationBodyHint),
              ),
            ),
            20.0.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: MyButton(
                    width: double.infinity,
                    variant: .outline,
                    text: s.cancel,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                8.0.horizontalSpace,
                Expanded(
                  flex: 2,
                  child: MyButton(
                    width: double.infinity,
                    text: s.raise,
                    enable: _title.text.trim().isNotEmpty,
                    loading: state.sending,
                    onTap: _submit,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
