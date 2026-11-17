import 'package:go_router/go_router.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/initials_avatar.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/features/auth/bloc/get_me_cubit/get_me_cubit.dart';
import 'package:mms/features/notification/bloc/notifications_cubit/notifications_cubit.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/go_router.dart';

class HiWidget extends StatelessWidget {
  const HiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoggedPartyCubit, LoggedPartyInitial>(
      builder: (context, state) {
        final party = AppProvider.getParty;

        return Padding(
          padding: EdgeInsets.fromLTRB(20.0.w, 24.0.h, 20.0.w, 8.0.h),
          child: Row(
            children: [
              // 48 avatar with a 2px white gap and a 2px primary ring.
              Container(
                padding: EdgeInsets.all(2.0.r),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColorManager.primary500),
                child: Container(
                  padding: EdgeInsets.all(2.0.r),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColorManager.neutral0),
                  child: AppAvatar(url: party.personalPhoto, name: party.name, size: 48),
                ),
              ),
              12.0.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    DrawableText(
                      text: S.of(context).welcomeBack,
                      size: 14.0.sp,
                      color: AppColorManager.neutral500,
                    ),
                    DrawableText(
                      text: party.name,
                      size: 20.0.sp,
                      fontWeight: .w700,
                      color: AppColorManager.neutral900,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              BlocBuilder<NotificationsCubit, NotificationsInitial>(
                builder: (context, state) {
                  final unread = state.unreadCount;
                  return Semantics(
                    button: true,
                    label: S.of(context).notifications,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.0.r),
                      onTap: () => context.pushNamed(RouteName.notifications),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 44.0.r,
                            height: 44.0.r,
                            alignment: .center,
                            decoration: BoxDecoration(
                              color: AppColorManager.neutral50,
                              borderRadius: BorderRadius.circular(12.0.r),
                            ),
                            child: ImageMultiType(
                              url: Icons.notifications_none_rounded,
                              width: 22.0.r,
                              height: 22.0.r,
                              color: AppColorManager.neutral700,
                            ),
                          ),
                          if (unread > 0)
                            PositionedDirectional(
                              top: -5.0.r,
                              end: -6.0.r,
                              child: CountBadge(count: unread),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
