import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/my_style.dart';

import 'package:mms/features/room/ui/widget/users/dynamic_user.dart';

import '../../../../generated/l10n.dart';
import '../../../room/bloc/room_cubit/room_cubit.dart';
import 'no_video.dart';

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
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DrawableText(
                  padding: EdgeInsets.all(20.0),
                  text: S.of(context).yourConnectionHasBeenSuspendedByTheAdminButYou,
                  textAlign: TextAlign.center,
                  matchParent: true,
                ),
                MyStyle.loadingWidget(color: AppColorManager.mainColor)
              ],
            ),
          );
        }
        return Stack(
          children: [
            const VideoRemoteWidget(),
            Align(
              alignment: AlignmentGeometry.bottomLeft,
              child: Chip(label: DrawableText(text: state.result.localParticipant?.statusName ?? '')),
            ),
            if (state.participantTracksWithoutSelected.isNotEmpty)
              Align(
                alignment: AlignmentGeometry.topCenter,
                child: SizedBox(
                  height: 100.0.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.participantTracksWithoutSelected.length,
                    itemBuilder: (context, i) {
                      final participant = state.participantTracksWithoutSelected[i];
                      return InkWell(
                        onTap: () {
                          context.read<RoomCubit>().selectParticipant(participant.identity);
                        },
                        child: SizedBox(
                          height: 200.0.dg,
                          width: 200.0.dg,
                          child: DynamicUser(participant: participant),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
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
