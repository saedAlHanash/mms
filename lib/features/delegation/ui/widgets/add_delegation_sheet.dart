import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/initials_avatar.dart';
import 'package:mms/core/widgets/membership_badge.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/features/committees/data/response/committees_response.dart';
import 'package:mms/features/delegation/bloc/delegations_cubit/delegations_cubit.dart';
import 'package:mms/features/delegation/data/request/delegation_requests.dart';
import 'package:mms/features/members/data/response/member_response.dart';
import 'package:mms/generated/l10n.dart';

/// Hand my role (chair or secretary) to another member: who, which areas, when, why.
class AddDelegationSheet extends StatefulWidget {
  const AddDelegationSheet({super.key, required this.committee});

  final Committee committee;

  static Future<void> show(
    BuildContext context, {
    required DelegationsCubit cubit,
    required Committee committee,
  }) {
    return AppBottomSheet.show(
      context,
      child: BlocProvider.value(value: cubit, child: AddDelegationSheet(committee: committee)),
    );
  }

  @override
  State<AddDelegationSheet> createState() => _AddDelegationSheetState();
}

class _AddDelegationSheetState extends State<AddDelegationSheet> {
  static const _maxDays = 366;

  final _reason = TextEditingController();
  String _toPartyId = '';
  final Set<DelegationScope> _scopes = {...DelegationScope.values};
  late DateTime _start;
  late DateTime _end;

  MembershipType get _role => widget.committee.member.membershipType;

  /// Current members other than me (guests can't be delegates).
  List<Member> get _candidates {
    final myId = AppProvider.getParty.id;
    return widget.committee.members
        .where((e) => e.partyId != myId && e.membershipType != MembershipType.guest)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    final today = DateUtils.dateOnly(DateTime.now());
    _start = today;
    _end = today.add(const Duration(days: 7));
  }

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  bool get _valid => _toPartyId.isNotEmpty && _scopes.isNotEmpty && !_end.isBefore(_start);

  Future<void> _pickDate({required bool start}) async {
    final today = DateUtils.dateOnly(DateTime.now());
    final first = start ? today : _start;
    final last = (start ? today : _start).add(const Duration(days: _maxDays - 1));
    final initial = start ? _start : _end;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial.isBefore(first) ? first : (initial.isAfter(last) ? last : initial),
      firstDate: first,
      lastDate: last,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked == null || !mounted) return;
    setState(() {
      if (start) {
        _start = picked;
        // Keep the end after the start and within the limit.
        if (_end.isBefore(_start)) _end = _start;
        final maxEnd = _start.add(const Duration(days: _maxDays - 1));
        if (_end.isAfter(maxEnd)) _end = maxEnd;
      } else {
        _end = picked;
      }
    });
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final now = DateTime.now();
    // Today starts now; a later day starts at its midnight. Ends at the end of the last day.
    final startsAt = DateUtils.isSameDay(_start, now) ? now : _start;
    final endsAt = DateTime(_end.year, _end.month, _end.day, 23, 59);

    final ok = await context.read<DelegationsCubit>().add(
      AddDelegationRequest(
        committeeId: widget.committee.id,
        toPartyId: _toPartyId,
        role: _role,
        scopes: _scopes.toList(),
        startsAt: startsAt,
        endsAt: endsAt,
        reason: _reason.text,
      ),
    );
    if (ok && mounted) {
      NoteMessage.showSuccessSnackBar(message: S.of(context).delegationAdded, context: context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final candidates = _candidates;
    final allSelected = _scopes.length == DelegationScope.values.length;

    return BlocBuilder<DelegationsCubit, DelegationsInitial>(
      buildWhen: (p, c) => p.sending != c.sending,
      builder: (context, state) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: DrawableText(
                      text: s.addDelegation,
                      size: 18.0.sp,
                      fontWeight: .w700,
                      color: AppColorManager.neutral900,
                    ),
                  ),
                  IconButton(
                    tooltip: s.close,
                    constraints: BoxConstraints(minWidth: 44.0.r, minHeight: 44.0.r),
                    onPressed: () => Navigator.pop(context),
                    icon: ImageMultiType(
                      url: Icons.close_rounded,
                      width: 22.0.r,
                      height: 22.0.r,
                      color: AppColorManager.neutral700,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  DrawableText(text: s.delegationRole, size: 13.0.sp, color: AppColorManager.neutral500),
                  8.0.horizontalSpace,
                  MembershipBadge(type: _role),
                ],
              ),
              4.0.verticalSpace,
              DrawableText(text: s.addDelegationHint, size: 13.0.sp, color: AppColorManager.neutral500),
              16.0.verticalSpace,
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: .stretch,
                    children: [
                      _Label(s.delegateTo),
                      6.0.verticalSpace,
                      if (candidates.isEmpty)
                        DrawableText(text: s.noDelegationCandidates, size: 13.0.sp, color: AppColorManager.neutral500)
                      else
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0.r),
                            border: Border.all(color: AppColorManager.neutral100),
                          ),
                          child: Column(
                            children: [
                              for (var i = 0; i < candidates.length; i++) ...[
                                if (i > 0) const Divider(height: 1, color: AppColorManager.neutral100),
                                _MemberRow(
                                  member: candidates[i],
                                  selected: candidates[i].partyId == _toPartyId,
                                  onTap: () => setState(() => _toPartyId = candidates[i].partyId),
                                ),
                              ],
                            ],
                          ),
                        ),
                      16.0.verticalSpace,
                      Row(
                        children: [
                          Expanded(child: _Label(s.delegationScopes)),
                          MyButton(
                            variant: .text,
                            size: .small,
                            text: allSelected ? s.clearAll : s.selectAll,
                            onTap: () => setState(() {
                              allSelected ? _scopes.clear() : _scopes.addAll(DelegationScope.values);
                            }),
                          ),
                        ],
                      ),
                      6.0.verticalSpace,
                      Wrap(
                        spacing: 8.0.w,
                        runSpacing: 8.0.h,
                        children: [
                          for (final scope in DelegationScope.values)
                            FilterChip(
                              label: DrawableText(
                                text: scope.label,
                                size: 13.0.sp,
                                fontWeight: .w600,
                                color: _scopes.contains(scope) ? AppColorManager.primary700 : AppColorManager.neutral700,
                              ),
                              selected: _scopes.contains(scope),
                              showCheckmark: true,
                              checkmarkColor: AppColorManager.primary700,
                              onSelected: (on) => setState(() => on ? _scopes.add(scope) : _scopes.remove(scope)),
                              selectedColor: AppColorManager.primary50,
                              backgroundColor: AppColorManager.neutral25,
                              side: BorderSide(
                                color: _scopes.contains(scope) ? AppColorManager.primary300 : AppColorManager.neutral100,
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                              materialTapTargetSize: MaterialTapTargetSize.padded,
                            ),
                        ],
                      ),
                      16.0.verticalSpace,
                      _Label(s.delegationPeriod),
                      6.0.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: _DateBox(
                              label: s.delegationStarts,
                              date: _start,
                              onTap: () => _pickDate(start: true),
                            ),
                          ),
                          10.0.horizontalSpace,
                          Expanded(
                            child: _DateBox(
                              label: s.delegationEnds,
                              date: _end,
                              onTap: () => _pickDate(start: false),
                            ),
                          ),
                        ],
                      ),
                      4.0.verticalSpace,
                      DrawableText(text: s.delegationPeriodHint, size: 12.0.sp, color: AppColorManager.neutral500),
                      16.0.verticalSpace,
                      _Label(s.delegationReasonOptional),
                      6.0.verticalSpace,
                      _ReasonField(controller: _reason),
                    ],
                  ),
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
                      text: s.delegateAction,
                      enable: _valid,
                      loading: state.sending,
                      onTap: _submit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return DrawableText(text: text, size: 14.0.sp, fontWeight: .w600, color: AppColorManager.neutral700);
  }
}

class _MemberRow extends StatelessWidget {
  const _MemberRow({required this.member, required this.selected, required this.onTap});

  final Member member;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 52.0.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.0.h),
          child: Row(
            children: [
              InitialsAvatar(name: member.party.name, size: 36),
              10.0.horizontalSpace,
              Expanded(
                child: DrawableText(
                  text: member.party.name,
                  size: 14.0.sp,
                  fontWeight: selected ? .w700 : .w500,
                  color: AppColorManager.neutral900,
                  maxLines: 1,
                ),
              ),
              MembershipBadge(type: member.membershipType),
              10.0.horizontalSpace,
              ImageMultiType(
                url: selected ? Icons.radio_button_checked_rounded : Icons.radio_button_unchecked_rounded,
                width: 22.0.r,
                height: 22.0.r,
                color: selected ? AppColorManager.primary500 : AppColorManager.neutral300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateBox extends StatelessWidget {
  const _DateBox({required this.label, required this.date, required this.onTap});

  final String label;
  final DateTime date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(10.0.r);
    return Material(
      color: AppColorManager.neutral0,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.0.h),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: AppColorManager.neutral200),
          ),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              DrawableText(text: label, size: 12.0.sp, color: AppColorManager.neutral500),
              2.0.verticalSpace,
              DrawableText(
                text: date.formatDate,
                size: 14.0.sp,
                fontWeight: .w700,
                color: AppColorManager.neutral900,
                drawablePadding: 6.0.w,
                drawableStart: ImageMultiType(
                  url: Icons.calendar_today_outlined,
                  width: 15.0.r,
                  height: 15.0.r,
                  color: AppColorManager.primary500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReasonField extends StatelessWidget {
  const _ReasonField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0.r),
      borderSide: const BorderSide(color: AppColorManager.neutral200),
    );
    return SizedBox(
      height: 88.0.h,
      child: TextField(
        controller: controller,
        expands: true,
        maxLines: null,
        maxLength: 500,
        buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null,
        textAlignVertical: TextAlignVertical.top,
        style: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral900),
        decoration: InputDecoration(
          hintText: S.of(context).delegationReasonHint,
          hintStyle: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral500),
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.0.h),
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(borderSide: const BorderSide(color: AppColorManager.primary500, width: 2)),
        ),
      ),
    );
  }
}
