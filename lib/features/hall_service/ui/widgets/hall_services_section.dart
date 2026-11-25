import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/icon_tile.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/hall_service/bloc/hall_services_cubit/hall_services_cubit.dart';
import 'package:mms/features/hall_service/data/response/hall_service_response.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/generated/l10n.dart';

/// The secretary's hall service requests for this meeting, with "Request a service".
class HallServicesSection extends StatelessWidget {
  const HallServicesSection({super.key, required this.meeting});

  final Meeting meeting;

  /// The secretary, for a meeting held (at least partly) in a hall that isn't over.
  static bool showsFor(Meeting meeting) {
    if (meeting.callerMembershipType != MembershipType.secretary) return false;
    if (meeting.mode == MeetingMode.online) return false;
    return switch (meeting.status) {
      MeetingStatus.canceled || MeetingStatus.completed || MeetingStatus.archived => false,
      _ => true,
    };
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<HallServicesCubit, HallServicesInitial>(
      builder: (context, state) {
        final list = state.result;
        return Padding(
          padding: EdgeInsets.only(top: 16.0.h),
          child: MyCardWidget(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.all(16.0.r),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Row(
                  children: [
                    const IconTile(icon: Icons.room_service_outlined, size: 44),
                    12.0.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          DrawableText(
                            text: s.hallServices,
                            size: 15.0.sp,
                            fontWeight: .w700,
                            color: AppColorManager.neutral900,
                          ),
                          2.0.verticalSpace,
                          DrawableText(text: s.hallServicesHint, size: 13.0.sp, color: AppColorManager.neutral500),
                        ],
                      ),
                    ),
                  ],
                ),
                for (final item in list) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1, color: AppColorManager.neutral100),
                  ),
                  _ServiceItem(item: item, cancelling: state.cancellingId == item.id),
                ],
                14.0.verticalSpace,
                MyButton(
                  variant: .tonal,
                  size: .medium,
                  width: double.infinity,
                  text: s.requestService,
                  startIcon: ImageMultiType(
                    url: Icons.add_rounded,
                    width: 18.0.r,
                    height: 18.0.r,
                    color: AppColorManager.primary700,
                  ),
                  onTap: () => _AddServiceSheet.show(context, cubit: context.read<HallServicesCubit>()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ServiceItem extends StatelessWidget {
  const _ServiceItem({required this.item, required this.cancelling});

  final HallServiceRequest item;
  final bool cancelling;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final title = switch (item.kind) {
      HallServiceKind.equipment => s.equipmentQuantity(
        item.equipmentName.isEmpty ? HallServiceKind.equipment.label : item.equipmentName,
        item.quantity,
      ),
      HallServiceKind.hospitality => item.quantity > 0 ? s.hospitalityFor(item.quantity) : HallServiceKind.hospitality.label,
      HallServiceKind.other => HallServiceKind.other.label,
    };

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Row(
          children: [
            ImageMultiType(url: item.kind.icon, width: 18.0.r, height: 18.0.r, color: AppColorManager.neutral700),
            8.0.horizontalSpace,
            Expanded(
              child: DrawableText(
                text: title,
                size: 14.0.sp,
                fontWeight: .w700,
                color: AppColorManager.neutral900,
                maxLines: 2,
              ),
            ),
            8.0.horizontalSpace,
            StatusChip(colors: item.state.colors, label: item.state.label),
          ],
        ),
        if (item.details.isNotEmpty) ...[
          4.0.verticalSpace,
          DrawableText(text: item.details, size: 13.0.sp, color: AppColorManager.neutral700, maxLines: 4),
        ],
        if (item.requestedAt case final at?) ...[
          4.0.verticalSpace,
          DrawableText(text: at.formatDateTime, size: 12.0.sp, color: AppColorManager.neutral500),
        ],
        if (item.responseNote.isNotEmpty) ...[
          6.0.verticalSpace,
          DrawableText(
            text: item.respondedByName.isEmpty ? item.responseNote : '${item.respondedByName}: ${item.responseNote}',
            size: 13.0.sp,
            color: item.state == HallServiceState.rejected ? AppColorManager.dangerText : AppColorManager.neutral700,
          ),
        ],
        if (item.isOpen) ...[
          8.0.verticalSpace,
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: MyButton(
              variant: .dangerSoft,
              size: .small,
              loading: cancelling,
              text: s.cancelRequest,
              onTap: () => NoteMessage.showCheckDialog(
                context,
                text: s.cancelServiceTitle,
                description: title,
                textButton: s.cancelRequest,
                image: Icons.room_service_outlined,
                destructive: true,
                onConfirm: () => context.read<HallServicesCubit>().cancel(item.id),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Hospitality (number of people) or another service, with details.
/// Equipment needs the hall's equipment ids, which the app has no list for yet.
class _AddServiceSheet extends StatefulWidget {
  const _AddServiceSheet();

  static Future<void> show(BuildContext context, {required HallServicesCubit cubit}) {
    return AppBottomSheet.show(context, child: BlocProvider.value(value: cubit, child: const _AddServiceSheet()));
  }

  @override
  State<_AddServiceSheet> createState() => _AddServiceSheetState();
}

class _AddServiceSheetState extends State<_AddServiceSheet> {
  final _details = TextEditingController();
  HallServiceKind _kind = HallServiceKind.hospitality;
  int _people = 10;

  @override
  void dispose() {
    _details.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final ok = await context.read<HallServicesCubit>().add(
      kind: _kind,
      quantity: _kind == HallServiceKind.hospitality ? _people : 0,
      details: _details.text,
    );
    if (ok && mounted) {
      NoteMessage.showSuccessSnackBar(message: S.of(context).serviceRequested, context: context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0.r),
      borderSide: const BorderSide(color: AppColorManager.neutral200),
    );

    return BlocBuilder<HallServicesCubit, HallServicesInitial>(
      buildWhen: (p, c) => p.sending != c.sending,
      builder: (context, state) {
        return Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            DrawableText(text: s.requestService, size: 18.0.sp, fontWeight: .w700, color: AppColorManager.neutral900),
            4.0.verticalSpace,
            DrawableText(text: s.requestServiceHint, size: 13.0.sp, color: AppColorManager.neutral500),
            16.0.verticalSpace,
            Row(
              children: [
                for (final kind in const [HallServiceKind.hospitality, HallServiceKind.other]) ...[
                  Expanded(
                    child: _KindTile(kind: kind, selected: _kind == kind, onTap: () => setState(() => _kind = kind)),
                  ),
                  if (kind == HallServiceKind.hospitality) 10.0.horizontalSpace,
                ],
              ],
            ),
            if (_kind == HallServiceKind.hospitality) ...[
              16.0.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: DrawableText(
                      text: s.numberOfPeople,
                      size: 14.0.sp,
                      fontWeight: .w600,
                      color: AppColorManager.neutral700,
                    ),
                  ),
                  _Stepper(value: _people, onChanged: (v) => setState(() => _people = v)),
                ],
              ),
            ],
            16.0.verticalSpace,
            SizedBox(
              height: 112.0.h,
              child: TextField(
                controller: _details,
                expands: true,
                maxLines: null,
                maxLength: 1000,
                buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null,
                textAlignVertical: TextAlignVertical.top,
                onChanged: (_) => setState(() {}),
                style: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral900),
                decoration: InputDecoration(
                  hintText: _kind == HallServiceKind.hospitality ? s.hospitalityDetailsHint : s.serviceDetailsHint,
                  hintStyle: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral500),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.0.h),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border.copyWith(
                    borderSide: const BorderSide(color: AppColorManager.primary500, width: 2),
                  ),
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
                    text: s.sendRequest,
                    enable: _details.text.trim().isNotEmpty,
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

class _KindTile extends StatelessWidget {
  const _KindTile({required this.kind, required this.selected, required this.onTap});

  final HallServiceKind kind;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12.0.r);
    final color = selected ? AppColorManager.primary700 : AppColorManager.neutral700;
    return Material(
      color: selected ? AppColorManager.primary50 : AppColorManager.neutral0,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 14.0.h, horizontal: 10.0.w),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: selected ? AppColorManager.primary500 : AppColorManager.neutral100,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            children: [
              ImageMultiType(url: kind.icon, width: 24.0.r, height: 24.0.r, color: color),
              6.0.verticalSpace,
              DrawableText(text: kind.label, size: 13.0.sp, fontWeight: .w700, color: color),
            ],
          ),
        ),
      ),
    );
  }
}

/// − value + (0–999).
class _Stepper extends StatelessWidget {
  const _Stepper({required this.value, required this.onChanged});

  final int value;
  final ValueChanged<int> onChanged;

  Widget _button(IconData icon, VoidCallback? onTap) => Material(
    color: AppColorManager.neutral0,
    shape: const CircleBorder(side: BorderSide(color: AppColorManager.neutral100)),
    child: InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: SizedBox(
        width: 44.0.r,
        height: 44.0.r,
        child: Center(
          child: ImageMultiType(
            url: icon,
            width: 20.0.r,
            height: 20.0.r,
            color: onTap == null ? AppColorManager.neutral300 : AppColorManager.neutral700,
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      children: [
        _button(Icons.remove_rounded, value > 0 ? () => onChanged(value - 1) : null),
        SizedBox(
          width: 48.0.w,
          child: DrawableText(
            text: '$value',
            size: 16.0.sp,
            fontWeight: .w700,
            color: AppColorManager.neutral900,
            textAlign: .center,
          ),
        ),
        _button(Icons.add_rounded, value < 999 ? () => onChanged(value + 1) : null),
      ],
    );
  }
}
