import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../auth/bloc/get_me_cubit/get_me_cubit.dart';
import '../../../notification/bloc/notifications_cubit/notifications_cubit.dart';

class HiWidget extends StatelessWidget {
  const HiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoggedPartyCubit, LoggedPartyInitial>(
      builder: (context, state) {
        return ListTile(
          leading: Container(
            height: 50.0.r,
            width: 50.0.r,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              border: Border.all(color: AppColorManager.red),
              shape: BoxShape.circle,
            ),
            child: CircleImageWidget(
              url: AppProvider.getParty.personalPhoto,
              size: 50.0.r,
            ),
          ),
          title: DrawableText(
            text: S.of(context).welcomeBack,
            fontFamily: FontManager.cairoSemiBold.name,
          ),
          subtitle: DrawableText(
            text: AppProvider.getParty.name,
          ),
          trailing: InkWell(
            onTap: () {
              // Navigator.pushNamed(context, RouteName.notifications);
            },
            child: BlocBuilder<NotificationsCubit, NotificationsInitial>(
              builder: (context, state) {
                return Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteName.notifications);
                      },
                      icon: ImageMultiType(
                        url: Assets.iconsNotifications,
                        height: 45.0.r,
                        width: 45.0.r,
                      ),
                    ),
                    (state.result.length - state.numOfRead) != 0
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 15,
                              minHeight: 15,
                            ),
                            child: Text(
                              (state.result.length - state.numOfRead) > 9
                                  ? "+9"
                                  : (state.result.length - state.numOfRead)
                                      .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : 0.0.verticalSpace,
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
