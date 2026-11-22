import 'package:go_router/go_router.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/app/app_widget.dart';
import 'package:mms/core/helper/launcher_helper.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/shared_preferences.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/icon_tile.dart';
import 'package:mms/core/widgets/initials_avatar.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/core/widgets/switch_widget.dart';
import 'package:mms/features/auth/bloc/get_me_cubit/get_me_cubit.dart';
import 'package:mms/features/home/ui/widgets/bottom_nav_widget.dart';
import 'package:mms/features/notice_preferences/bloc/notice_preferences_cubit/notice_preferences_cubit.dart';

import 'package:mms/generated/assets.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/go_router.dart';
import 'package:mms/services/app_info_service.dart';

/// Home "Settings" tab.
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  void _openLanguage() async {
    final value = await AppBottomSheet.show<int>(context, child: const LanWidget());
    if (value == null || !mounted) return;
    Future.delayed(
      const Duration(microseconds: 500),
      () {
        if (mounted) MyApp.setLocale(context, value == 0 ? 'en' : 'ar');
      },
    );
  }

  void _logout() {
    NoteMessage.showCheckDialog(
      context,
      text: S.of(context).logoutQuestion,
      description: S.of(context).logoutDescription,
      textButton: S.of(context).logout,
      image: Icons.logout_rounded,
      destructive: true,
      onConfirm: () => AppProvider.logout(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final party = AppProvider.getParty;
    final isArabic = AppSharedPreference.getLocal == 'ar';

    return BlocListener<LoggedPartyCubit, LoggedPartyInitial>(
      listenWhen: (p, c) => c.done,
      listener: (context, state) => setState(() {}),
      child: Scaffold(
        backgroundColor: AppColorManager.neutral25,
        appBar: const AppBarWidget(zeroHeight: true),
        body: ListView(
          padding: EdgeInsets.fromLTRB(16.0.w, 0, 16.0.w, homeNavBarSpace),
          children: [
            Container(
              height: 64.0.h,
              alignment: AlignmentDirectional.centerStart,
              padding: EdgeInsets.symmetric(horizontal: 4.0.w),
              child: DrawableText(
                text: S.of(context).navSettings,
                size: 22.0.sp,
                fontWeight: .w700,
                color: AppColorManager.neutral900,
              ),
            ),
            // User card → Profile.
            _MenuCard(
              child: InkWell(
                onTap: () => context.pushNamed(RouteName.profile),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 14.0.h),
                  child: Row(
                    children: [
                      AppAvatar(url: party.personalPhoto, name: party.name, size: 60),
                      14.0.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          mainAxisSize: .min,
                          children: [
                            DrawableText(
                              text: party.name,
                              size: 18.0.sp,
                              fontWeight: .w700,
                              color: AppColorManager.neutral900,
                              maxLines: 1,
                            ),
                            DrawableText(
                              text: S.of(context).viewProfile,
                              size: 13.0.sp,
                              fontWeight: .w600,
                              color: AppColorManager.primary600,
                            ),
                          ],
                        ),
                      ),
                      const _Chevron(),
                    ],
                  ),
                ),
              ),
            ),
            16.0.verticalSpace,
            _MenuGroup(
              title: S.of(context).preferences,
              rows: [
                _MenuRow(
                  icon: Icons.notifications_none_rounded,
                  title: S.of(context).notification,
                  // Push on/off for all notice groups, saved on the server.
                  trailing: BlocBuilder<NoticePreferencesCubit, NoticePreferencesInitial>(
                    builder: (context, state) {
                      final value = state.result.groups.isEmpty
                          ? AppSharedPreference.getNotificationState
                          : state.result.allPush;
                      return SwitchWidget(
                        // A failed save rebuilds the switch with the saved value.
                        key: ValueKey('$value-${state.statuses}'),
                        initialVal: value,
                        onChange: (push) => context.read<NoticePreferencesCubit>().setPush(push),
                      );
                    },
                  ),
                ),
                _MenuRow(
                  icon: Icons.language_rounded,
                  title: S.of(context).language,
                  onTap: _openLanguage,
                  trailing: DrawableText(
                    text: isArabic ? 'العربية' : 'English',
                    size: 14.0.sp,
                    color: AppColorManager.neutral500,
                    drawablePadding: 6.0.w,
                    drawableEnd: const _Chevron(),
                  ),
                ),
              ],
            ),
            16.0.verticalSpace,
            _MenuGroup(
              title: S.of(context).help,
              rows: [
                _MenuRow(
                  icon: Icons.headset_mic_outlined,
                  title: S.of(context).support,
                  subtitle: S.of(context).phoneCall,
                  onTap: () => LauncherHelper.callPhone(phone: '+966500641544'),
                  trailing: const _Chevron(),
                ),
                _MenuRow(
                  icon: Icons.privacy_tip_outlined,
                  title: S.of(context).policy,
                  onTap: () => LauncherHelper.openPage('https://dart-quicktype.netlify.app/'),
                  trailing: ImageMultiType(
                    url: Icons.open_in_new_rounded,
                    width: 18.0.r,
                    height: 18.0.r,
                    color: AppColorManager.neutral500,
                  ),
                ),
              ],
            ),
            16.0.verticalSpace,
            _MenuCard(
              child: _MenuRow(
                icon: Icons.logout_rounded,
                iconTone: .danger,
                title: S.of(context).logout,
                titleColor: AppColorManager.dangerText,
                onTap: _logout,
              ),
            ),
            20.0.verticalSpace,
            Column(
              children: [
                ImageMultiType(url: Assets.imagesCoreTechLogo, height: 24.0.h),
                4.0.verticalSpace,
                DrawableText(
                  text: S.of(context).poweredByCoretech,
                  size: 12.0.sp,
                  color: AppColorManager.neutral500,
                ),
                Directionality(
                  textDirection: .ltr,
                  child: DrawableText(
                    text: AppInfoService.fullVersionName,
                    size: 12.0.sp,
                    color: AppColorManager.neutral500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// White card, radius 16, `neutral100` border.
class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColorManager.neutral0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColorManager.neutral100),
        borderRadius: BorderRadius.circular(16.0.r),
      ),
      child: child,
    );
  }
}

/// Group title (13/700 `neutral500`) above a card of rows separated by dividers.
class _MenuGroup extends StatelessWidget {
  const _MenuGroup({required this.title, required this.rows});

  final String title;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < rows.length; i++) {
      if (i > 0) {
        children.add(Padding(
          padding: EdgeInsetsDirectional.only(start: 62.0.w),
          child: const Divider(height: 1, color: AppColorManager.neutral50),
        ));
      }
      children.add(rows[i]);
    }

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: DrawableText(
            text: title,
            size: 13.0.sp,
            fontWeight: .w700,
            color: AppColorManager.neutral500,
          ),
        ),
        6.0.verticalSpace,
        _MenuCard(child: Column(children: children)),
      ],
    );
  }
}

/// 56px row: 36 icon tile + title (+ subtitle) + trailing.
class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconTone = .primary,
    this.titleColor = AppColorManager.neutral900,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final IconTileTone iconTone;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minHeight: 56.0.h),
        padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 6.0.h),
        child: Row(
          children: [
            IconTile(icon: icon, size: 36, iconSize: 20, tone: iconTone),
            12.0.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  DrawableText(
                    text: title,
                    size: 16.0.sp,
                    fontWeight: .w600,
                    color: titleColor,
                  ),
                  if (subtitle != null)
                    DrawableText(
                      text: subtitle!,
                      size: 12.0.sp,
                      color: AppColorManager.neutral500,
                    ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class _Chevron extends StatelessWidget {
  const _Chevron();

  @override
  Widget build(BuildContext context) {
    return ImageMultiType(
      url: Icons.chevron_right_rounded,
      width: 20.0.r,
      height: 20.0.r,
      color: AppColorManager.neutral500,
    );
  }
}

/// Language picker shown in an [AppBottomSheet]. Pops 0 (en) or 1 (ar).
class LanWidget extends StatelessWidget {
  const LanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final current = AppSharedPreference.getLocal != 'ar' ? 0 : 1;

    Widget option({required int value, required String badge, required String name}) {
      final selected = current == value;
      return Material(
        color: selected ? AppColorManager.primary50 : AppColorManager.neutral0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0.r),
          side: BorderSide(
            color: selected ? AppColorManager.primary500 : AppColorManager.neutral200,
            width: selected ? 2 : 1,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0.r),
          onTap: () => Navigator.pop(context, value),
          child: Container(
            constraints: BoxConstraints(minHeight: 64.0.h),
            padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 10.0.h),
            child: Row(
              children: [
                Container(
                  width: 44.0.r,
                  height: 44.0.r,
                  alignment: .center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? AppColorManager.primary500 : AppColorManager.neutral50,
                  ),
                  child: DrawableText(
                    text: badge,
                    size: 16.0.sp,
                    fontWeight: .w700,
                    color: selected ? AppColorManager.neutral0 : AppColorManager.neutral700,
                  ),
                ),
                12.0.horizontalSpace,
                Expanded(
                  child: DrawableText(
                    text: name,
                    size: 16.0.sp,
                    fontWeight: .w700,
                    color: AppColorManager.neutral900,
                  ),
                ),
                if (selected)
                  ImageMultiType(
                    url: Icons.check_circle_rounded,
                    width: 22.0.r,
                    height: 22.0.r,
                    color: AppColorManager.primary500,
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: .stretch,
      mainAxisSize: .min,
      children: [
        DrawableText(
          text: S.of(context).language,
          size: 18.0.sp,
          fontWeight: .w700,
          color: AppColorManager.neutral900,
        ),
        12.0.verticalSpace,
        option(value: 1, badge: 'ع', name: 'العربية'),
        12.0.verticalSpace,
        option(value: 0, badge: 'EN', name: 'English'),
      ],
    );
  }
}
