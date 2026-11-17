import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';

import 'package:mms/features/room/ui/widgets/users/dynamic_user.dart';

import 'package:mms/generated/l10n.dart';
import 'package:mms/features/room/bloc/room_cubit/room_cubit.dart';
import 'package:mms/features/room/ui/widgets/no_video.dart';

class VideoCallWidget extends StatefulWidget {
  const VideoCallWidget({super.key});

  @override
  State<VideoCallWidget> createState() => _VideoCallWidgetState();
}

class _VideoCallWidgetState extends State<VideoCallWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomInitial>(
      builder: (context, state) {
        if (state.result.localParticipant?.isSuspend == true) {
          // Suspended card (warningSoft).
          return Container(
            padding: EdgeInsets.all(16.0.r),
            decoration: BoxDecoration(
              color: AppColorManager.warningSoft,
              borderRadius: BorderRadius.circular(12.0.r),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 28.0.r,
                  height: 28.0.r,
                  child: const CircularProgressIndicator(strokeWidth: 3, color: AppColorManager.warningText),
                ),
                14.0.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    children: [
                      DrawableText(
                        text: S.of(context).connectionSuspendedTitle,
                        size: 15.0.sp,
                        fontWeight: .w700,
                        color: AppColorManager.warningText,
                      ),
                      DrawableText(
                        text: S.of(context).yourConnectionHasBeenSuspendedByTheAdminButYou,
                        size: 13.0.sp,
                        color: AppColorManager.neutral700,
                        matchParent: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        final selected = state.selectedParticipant;

        return ClipRRect(
          borderRadius: BorderRadius.circular(12.0.r),
          child: Container(
            color: AppColorManager.neutral900,
            child: Stack(
              children: [
                const Center(child: VideoRemoteWidget()),
                // Selected participant name + connection quality.
                if (selected != null)
                  PositionedDirectional(
                    start: 0,
                    end: 0,
                    bottom: 0,
                    child: Container(
                      color: AppColorManager.black.withValues(alpha: 0.5),
                      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 6.0.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: DrawableText(
                              text: selected.displayName,
                              size: 13.0.sp,
                              color: AppColorManager.neutral0,
                              maxLines: 1,
                            ),
                          ),
                          selected.connectionQuality.icon,
                        ],
                      ),
                    ),
                  ),
                // Other participants as 48px thumbnails.
                if (state.participantTracksWithoutSelected.isNotEmpty)
                  PositionedDirectional(
                    top: 8.0.r,
                    start: 8.0.r,
                    end: 8.0.r,
                    height: 48.0.r,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.participantTracksWithoutSelected.length,
                      separatorBuilder: (_, __) => 6.0.horizontalSpace,
                      itemBuilder: (context, i) {
                        final participant = state.participantTracksWithoutSelected[i];
                        return InkWell(
                          onTap: () {
                            context.read<RoomCubit>().selectParticipant(participant.identity);
                          },
                          child: Container(
                            width: 48.0.r,
                            height: 48.0.r,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: AppColorManager.neutral700,
                              borderRadius: BorderRadius.circular(8.0.r),
                              border: Border.all(color: AppColorManager.neutral0.withValues(alpha: 0.25)),
                            ),
                            child: DynamicUser(participant: participant),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class VideoRemoteWidget extends StatelessWidget {
  const VideoRemoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomInitial>(
      builder: (context, state) {
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: state.selectedParticipant == null
              ? NoVideoWidget()
              : DynamicUser(participant: state.selectedParticipant!),
        );
      },
    );
  }
}
