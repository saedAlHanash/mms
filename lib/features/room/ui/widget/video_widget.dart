import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/api_manager/api_service.dart';

import 'package:mms/features/room/ui/widget/users/dynamic_user.dart';

import '../../../room/bloc/room_cubit/room_cubit.dart';
import 'no_video.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomInitial>(
      builder: (context, state) {
        loggerObject.w(state.participantTracks.length);
        return Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: state.selectedParticipant == null
                  ? NoVideoWidget()
                  : DynamicUser(participant: state.selectedParticipant!),
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
