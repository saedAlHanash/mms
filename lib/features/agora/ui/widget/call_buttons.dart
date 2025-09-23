import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/features/agora/bloc/agora_cubit/agora_cubit.dart';

import '../../../../services/ui_helper.dart';

class CallButtons extends StatefulWidget {
  const CallButtons({super.key, required this.engine});

  final RtcEngine engine;

  @override
  CallButtonsState createState() => CallButtonsState();
}

class CallButtonsState extends State<CallButtons> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgoraCubit, AgoraInitial>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white70,
                ),
                child: IconButton(
                  onPressed: context.read<AgoraCubit>().muteLocalAudioStream,
                  icon: Icon(
                    state.isMicrophoneMuted ? Icons.mic_off : Icons.mic,
                    color: state.isMicrophoneMuted ? Colors.red : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                padding: const EdgeInsets.all(5.0),
                child: IconButton(
                  onPressed: context.read<AgoraCubit>().disconnect,
                  icon: const Icon(
                    Icons.call_end,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white70,
                ),
                child: IconButton(
                  onPressed: context.read<AgoraCubit>().muteAllRemoteAudioStreams,
                  icon: Icon(
                    state.isAllAudioMuted ? Icons.volume_off : Icons.volume_up,
                    color: state.isAllAudioMuted ? Colors.red : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white70,
                ),
                child: IconButton(
                  onPressed: context.read<AgoraCubit>().muteSharingStream,
                  icon: Icon(
                    state.isSharingMuted ? Icons.stop_screen_share : Icons.screen_share,
                    color: state.isSharingMuted ? Colors.red : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white70,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showFullScreenDialog(context, context.read<AgoraCubit>());
                    // Navigator.pushNamed(context, RouteName.fullScreen, arguments: context.read<AgoraCubit>());
                  },
                  icon: Icon(
                    Icons.fullscreen,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void showFullScreenDialog(
  BuildContext context,
  AgoraCubit cubit,
) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Video',
    pageBuilder: (context, _, __) {
      return BlocProvider.value(
        value: cubit,
        child: _Temp(),
      );
    },
  );
}

class _Temp extends StatelessWidget {
  const _Temp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgoraCubit, AgoraInitial>(
      builder: (context, state) {
        final utl = UiHelper()
          ..initializeUiHelper(
            context.read<AgoraCubit>().state.result,
            () {},
          );
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Container(
              height: 1.0.sh,
              width: 1.0.sw,
              child: RotatedBox(
                quarterTurns: 1, // تدوير للشاشة (90 درجة)
                child: utl.scrollVideoView(),
              ),
            ),
          ),
        );
      },
    );
  }
}
