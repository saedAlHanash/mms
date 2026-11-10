import 'dart:typed_data';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/util/pick_image_helper.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/initials_avatar.dart';
import 'package:mms/features/auth/bloc/get_me_cubit/get_me_cubit.dart';
import 'package:mms/features/files/bloc/upload_file_cubit/upload_file_cubit.dart';
import 'package:mms/features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import 'package:mms/generated/l10n.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UpdateProfileCubit get updateCubit => context.read<UpdateProfileCubit>();

  UpdateProfileInitial get updateState => context.read<UpdateProfileCubit>().state;

  /// Same picking flow as the previous `ItemImageCreate`.
  Future<void> _pickImage() async {
    final bytes = await PickImageHelper().pickImageBytes();
    if (bytes == null) return;
    setState(() => updateState.request.profileImageUrl.fileBytes = bytes);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateProfileCubit, UpdateProfileInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            context.read<LoggedPartyCubit>().getData(newData: true);
            Navigator.pop(context);
          },
        ),
        BlocListener<LoggedPartyCubit, LoggedPartyInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) => updateCubit.setParty(),
        ),
        BlocListener<FileCubit, FileInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            updateState.request.personalPhoto = state.result.fileName;
            updateCubit.updateProfile();
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(titleText: S.of(context).profile),
        body: BlocBuilder<UpdateProfileCubit, UpdateProfileInitial>(
          builder: (context, state) {
            final request = updateState.request;
            final fullName = '${request.firstName ?? ''} ${request.lastName ?? ''}'.trim();

            return ListView(
              padding: EdgeInsets.fromLTRB(20.0.w, 20.0.h, 20.0.w, 24.0.h),
              children: [
                // Photo + name.
                Center(
                  child: SizedBox(
                    width: 108.0.r,
                    height: 102.0.r,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        PositionedDirectional(
                          top: 0,
                          start: 6.0.r,
                          child: BlocBuilder<FileCubit, FileInitial>(
                            builder: (context, fState) {
                              return Stack(
                                alignment: .center,
                                children: [
                                  _ProfilePhoto(image: request.profileImageUrl.getImage, name: fullName),
                                  if (fState.statuses.loading)
                                    SizedBox(
                                      width: 32.0.r,
                                      height: 32.0.r,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: AppColorManager.neutral0,
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                        PositionedDirectional(
                          bottom: 0,
                          end: 0,
                          child: Semantics(
                            button: true,
                            label: S.of(context).changePhoto,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: _pickImage,
                              child: Container(
                                width: 44.0.r,
                                height: 44.0.r,
                                alignment: .center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColorManager.primary500,
                                  border: Border.all(color: AppColorManager.neutral0, width: 3),
                                ),
                                child: ImageMultiType(
                                  url: Icons.photo_camera_outlined,
                                  width: 20.0.r,
                                  height: 20.0.r,
                                  color: AppColorManager.neutral0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                8.0.verticalSpace,
                DrawableText(
                  text: fullName,
                  size: 20.0.sp,
                  fontWeight: .w700,
                  color: AppColorManager.neutral900,
                  textAlign: .center,
                ),
                20.0.verticalSpace,
                // Gender (segmented).
                DrawableText(
                  text: S.of(context).gender,
                  size: 14.0.sp,
                  fontWeight: .w600,
                  color: AppColorManager.neutral700,
                ),
                8.0.verticalSpace,
                _GenderSegment(
                  value: request.gender,
                  onChanged: (g) => setState(() => updateCubit.setGender = g),
                ),
                20.0.verticalSpace,
                // Read-only basic info.
                Row(
                  children: [
                    Expanded(
                      child: DrawableText(
                        text: S.of(context).basicInfo,
                        size: 14.0.sp,
                        fontWeight: .w600,
                        color: AppColorManager.neutral700,
                      ),
                    ),
                    DrawableText(
                      text: S.of(context).readOnly,
                      size: 12.0.sp,
                      color: AppColorManager.neutral500,
                      drawablePadding: 5.0.w,
                      drawableStart: ImageMultiType(
                        url: Icons.lock_outline_rounded,
                        width: 14.0.r,
                        height: 14.0.r,
                        color: AppColorManager.neutral500,
                      ),
                    ),
                  ],
                ),
                8.0.verticalSpace,
                _InfoCard(
                  rows: [
                    (S.of(context).firstName, request.firstName, false),
                    (S.of(context).middleName, request.middleName, false),
                    (S.of(context).lastName, request.lastName, false),
                    (S.of(context).email, request.email, true),
                    (S.of(context).birthday, request.dob?.formatDate, true),
                    (S.of(context).location, request.address, false),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// 96 circle: picked bytes, the saved photo, or the initial.
class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto({required this.image, required this.name});

  final dynamic image;
  final String name;

  @override
  Widget build(BuildContext context) {
    if (image is Uint8List) return CircleImageWidget(url: image, size: 96.0.r);
    return AppAvatar(url: image is String ? image as String : '', name: name, size: 96);
  }
}

class _GenderSegment extends StatelessWidget {
  const _GenderSegment({required this.value, required this.onChanged});

  final GenderEnum? value;
  final ValueChanged<GenderEnum> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0.r),
      decoration: BoxDecoration(
        color: AppColorManager.neutral50,
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      child: Row(
        children: [
          for (final g in GenderEnum.values) ...[
            if (g.index > 0) 4.0.horizontalSpace,
            Expanded(
              child: Semantics(
                button: true,
                selected: value == g,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0.r),
                  onTap: () => onChanged(g),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: 44.0.h,
                    alignment: .center,
                    decoration: BoxDecoration(
                      color: value == g ? AppColorManager.neutral0 : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0.r),
                      boxShadow: value == g ? MyStyle.elevation1 : null,
                    ),
                    child: DrawableText(
                      text: g.name,
                      size: 15.0.sp,
                      fontWeight: value == g ? .w700 : .w600,
                      color: value == g ? AppColorManager.primary700 : AppColorManager.neutral700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Label/value rows (48px) separated by dividers. Empty values show "—".
class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.rows});

  /// (label, value, ltr)
  final List<(String, String?, bool)> rows;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < rows.length; i++) {
      final (label, value, ltr) = rows[i];
      final text = (value ?? '').trim().isEmpty ? '—' : value!.trim();

      if (i > 0) {
        children.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0.w),
          child: const Divider(height: 1, color: AppColorManager.neutral50),
        ));
      }

      final valueText = DrawableText(
        text: text,
        size: 15.0.sp,
        fontWeight: .w600,
        color: AppColorManager.neutral900,
        maxLines: 2,
        textAlign: .end,
      );

      children.add(Container(
        constraints: BoxConstraints(minHeight: 48.0.h),
        padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 8.0.h),
        child: Row(
          children: [
            DrawableText(text: label, size: 13.0.sp, color: AppColorManager.neutral500),
            12.0.horizontalSpace,
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: ltr ? Directionality(textDirection: .ltr, child: valueText) : valueText,
              ),
            ),
          ],
        ),
      ));
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColorManager.neutral25,
        border: Border.all(color: AppColorManager.neutral100),
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      child: Column(children: children),
    );
  }
}
