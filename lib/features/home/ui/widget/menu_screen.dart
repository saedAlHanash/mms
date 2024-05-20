import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/util/shared_preferences.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/my_text_form_widget.dart';
import 'package:mms/router/app_router.dart';

import '../../../../../core/helper/launcher_helper.dart';
import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/strings/app_string_manager.dart';
import '../../../../../core/strings/enum_manager.dart';
import '../../../../../core/util/my_style.dart';
import '../../../../../core/util/snack_bar_message.dart';
import '../../../../../core/widgets/my_button.dart';
import '../../../../../core/widgets/switch_widget.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../main.dart';
import '../../../../services/app_info_service.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        // Navigator.pushNamed(
                        //     context, RouteName.changePasswordPage);
                      },
                      name: S.of(context).password,
                      subTitle: S.of(context).subTitlePassword,
                      image: Assets.iconsPassword,
                    ),
                    ItemMenu(
                      onTap: () {},
                      name: S.of(context).support,
                      subTitle: S.of(context).subTitleSupport,
                      image: Assets.iconsSupport,
                    ),
                    ItemMenu(
                      onTap: () {},
                      name: S.of(context).policy,
                      subTitle: S.of(context).subTitlePolicy,
                      image: Assets.iconsPolicy,
                    ),
                    ItemMenu(
                      onTap: () {
                        AppProvider.logout();
                      },
                      name: S.of(context).logout,
                      subTitle: S.of(context).logout,
                      image: Icons.logout,
                    ),
                    ItemMenu(
                      onTap: () {},
                      name: S.of(context).deleteAccount,
                      subTitle: S.of(context).subTitleDeleteAccount,
                      image: Assets.iconsDelete,
                      withD: false,
                    ),
                    30.0.verticalSpace,
                    ItemMenu(
                      onTap: () {},
                      name: S.of(context).buildNumber,
                      subTitle: AppInfoService.fullVersionName,
                    ),
                    ItemMenu(
                      onTap: () {},
                      name: S.of(context).devBy,
                      subTitle: 'Core tech',
                      withD: false,
                    ),
                    200.0.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ],
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
                        height: 45.0.r,
                        width: 45.0.r,
                        url: image,
                      ),
            title: DrawableText(
              text: name,
              size: 16.0.sp,
              fontFamily: FontManager.cairoBold.name,
            ),
            subtitle: DrawableText(
              text: subTitle,
              size: 12.0.sp,
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
