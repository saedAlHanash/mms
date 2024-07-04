import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/helper/launcher_helper.dart';
import 'package:mms/core/util/shared_preferences.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/router/app_router.dart';

import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/widgets/switch_widget.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../services/app_info_service.dart';
import '../../../auth/bloc/get_me_cubit/get_me_cubit.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {

    return BlocListener<LoggedPartyCubit, LoggedPartyInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppBarWidget(zeroHeight: true),
        body: Column(
          children: [
            20.0.verticalSpace,
            CircleImageWidget(
              url: AppProvider.getParty.personalPhoto,
              size: 100.0.r,
            ),
            5.0.verticalSpace,
            DrawableText(text: AppProvider.getParty.name),
            40.0.verticalSpace,
            Expanded(
              child: Container(
                height: 1.0.sh,
                width: 1.0.sw,
                margin: const EdgeInsets.symmetric(horizontal: 20.0).r,
                decoration: BoxDecoration(
                  color: AppColorManager.f9,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.0.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      10.0.verticalSpace,
                      const ImageMultiType(url: Assets.iconsNotch),
                      30.0.verticalSpace,
                      ItemMenu(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.profile);
                        },
                        name: S.of(context).profile,
                        subTitle: S.of(context).profile,
                        image: Assets.iconsProfile,
                      ),
                      ItemMenu(
                        onTap: () {},
                        name: S.of(context).notification,
                        subTitle: S.of(context).subTitleNotification,
                        image: Assets.iconsNotifications,
                        trailing: SwitchWidget(
                          initialVal: AppSharedPreference.getNotificationState,
                          onChange: (p0) {
                            AppSharedPreference.cashNotificationState(p0);
                          },
                        ),
                        withD: false,
                      ),
                      30.0.verticalSpace,
                      ItemMenu(
                        onTap: () {
                          LauncherHelper.callPhone(phone: '+966500641544');
                        },
                        name: S.of(context).support,
                        subTitle: S.of(context).subTitleSupport,
                        image: Assets.iconsSupport,
                      ),
                      ItemMenu(
                        onTap: () {
                          LauncherHelper.openPage(
                              'https://dart-quicktype.netlify.app/');
                        },
                        name: S.of(context).policy,
                        subTitle: S.of(context).subTitlePolicy,
                        image: Assets.iconsPolicy,
                      ),
                      ItemMenu(
                        onTap: () {
                          NoteMessage.showCheckDialog(
                            context,
                            text: S.of(context).logout,
                            textButton: S.of(context).logout,
                            image: Assets.iconsLogout,
                            onConfirm: () {
                              AppProvider.logout();
                            },
                          );
                        },
                        name: S.of(context).logout,
                        subTitle: S.of(context).logout,
                        image: Assets.iconsLogout,
                      ),
                      ItemMenu(
                        onTap: () {
                          NoteMessage.showMyDialog(
                            context,
                            child: const LanWidget(),
                            onCancel: (v) {
                              if (v == null) return;
                              Future.delayed(
                                const Duration(microseconds: 500),
                                () => MyApp.setLocale(
                                    context, v == 0 ? 'en' : 'ar'),
                              );
                            },
                          );
                        },
                        name: S.of(context).changeLanguage,
                        subTitle: S.of(context).subTitleDeleteAccount,
                        image: Assets.iconsLanguge,
                        withD: false,
                      ),
                      ItemMenu(
                        onTap: () {},
                        name: S.of(context).poweredByCoretech,
                        image:  Assets.imagesCoreTechLogo,
                        subTitle: AppInfoService.fullVersionName,
                        withD: false,
                      ),
                      20.0.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    super.key,
    required this.name,
    required this.subTitle,
    this.image,
    this.trailing,
    this.withD = true,
    this.onTap,
  });

  final String name;

  final String subTitle;

  final dynamic image;
  final Function()? onTap;
  final Widget? trailing;
  final bool withD;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0).w,
      padding: const EdgeInsets.symmetric(vertical: 5.0).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0.r),
        color: Colors.white,
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () => onTap?.call(),
            leading: image == null
                ? null
                : image is Widget
                    ? image
                    : ImageMultiType(
                        height: 55.0.r,
                        width: 55.0.r,
                        url: image,
                      ),
            title: DrawableText(
              text: name,
              size: 18.0.sp,
              fontFamily: FontManager.cairoBold.name,
            ),
            subtitle: DrawableText(
              text: subTitle,
              color: Colors.grey,
            ),
            trailing: trailing,
          ),
          if (withD)
            Divider(
              height: 0,
              color: AppColorManager.cardColor,
              endIndent: 20.0.w,
              indent: 20.0.w,
            ),
        ],
      ),
    );
  }
}

class LanWidget extends StatefulWidget {
  const LanWidget({super.key});

  @override
  State<LanWidget> createState() => _LanWidgetState();
}

class _LanWidgetState extends State<LanWidget> {
  var select = 0;

  @override
  void initState() {
    select = AppSharedPreference.getLocal != 'ar' ? 0 : 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0.r),
        ),
        color: Colors.white,
      ),
      width: 300.0.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DrawableText(
            color: const Color(0xFF333333),
            size: 18.0.sp,
            padding: const EdgeInsets.symmetric(vertical: 30.0).h,
            fontFamily: FontManager.cairoBold.name,
            text: S.of(context).language,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() => select = 0);
                  Navigator.pop(context, select);
                },
                child: Container(
                  height: 130.0.r,
                  width: 120.0.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0.r),
                    border: select == 0
                        ? null
                        : Border.all(color: const Color(0xFFE8F3F1)),
                    color: select == 0
                        ? AppColorManager.mainColorDark
                        : Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 70.0.r,
                        width: 70.0.r,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: DrawableText(
                          text: 'EN',
                          size: 20.0.sp,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                      6.0.verticalSpace,
                      DrawableText(
                        text: 'English',
                        color: select == 0
                            ? AppColorManager.whit
                            : const Color(0xFF333333),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => select = 1);
                  Navigator.pop(context, select);
                },
                child: Container(
                  height: 130.0.r,
                  width: 120.0.r,
                  decoration: BoxDecoration(
                    border: select == 1
                        ? null
                        : Border.all(color: const Color(0xFFE8F3F1)),
                    borderRadius: BorderRadius.circular(20.0.r),
                    color: select != 0
                        ? AppColorManager.mainColorDark
                        : Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 70.0.r,
                        width: 70.0.r,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColorManager.lightGray,
                        ),
                        child: DrawableText(
                          text: 'ع',
                          size: 20.0.sp,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                      DrawableText(
                        text: 'العربية',
                        color: select == 1
                            ? AppColorManager.whit
                            : const Color(0xFF333333),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          32.0.verticalSpace,
        ],
      ),
    );
  }
}
