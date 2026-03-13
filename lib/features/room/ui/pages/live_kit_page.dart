import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/util/shared_preferences.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_text_form_widget.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/features/room/bloc/user_control_cubit/user_control_cubit.dart';

import '../../../../generated/l10n.dart';
import '../../../../services/app_info_service.dart';
import '../../../meetings/bloc/meeting_cubit/meeting_cubit.dart';
import '../../../room/bloc/room_cubit/room_cubit.dart';
import '../../bloc/my_status_cubit/my_status_cubit.dart';
import '../widget/controls.dart';
import '../widget/users/dynamic_user.dart';
import '../widget/video_widget.dart';

class LiveKitPage extends StatefulWidget {
  const LiveKitPage({super.key, required this.isOpen, required this.link, required this.token});

  final bool isOpen;
  final String link;
  final String token;

  @override
  State<LiveKitPage> createState() => _LiveKitPageState();
}

class _LiveKitPageState extends State<LiveKitPage> {
  var controller = TextEditingController(text: AppSharedPreference.getTokenVC);

  Future<void> getToken() async {
    final dId = await getDeviceIdAsync();
    final r = await APIService().callApi(
      url: 'GetJoinToken',
      type: ApiType.post,
      hostName: 'coretik-be.coretech-mena.com',
      additional: '/api/v1/Index/',
      body: {
        "identity": "$dId",
        "name": "${dId}user",
        "videoGrants": {
          "canPublish": false,
          "canPublishData": true,
          "canSubscribe": true,
          "room": "s1",
          "roomAdmin": false,
          "roomCreate": true,
          "roomJoin": true,
          "roomList": false
        },
        "attributes": {
          "type": "2",
          // "imageUrl": ""
        }
      },
    );
    final token = r.jsonBodyPure['token'];
    AppSharedPreference.cashTokenVC(token);
    controller.text = token;
    context
        .read<MyStatusCubit>()
        .fetchMyStatus(context.read<RoomCubit>().state.result.localParticipant?.identity ?? '');
  }

  void showFullScreenDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, _, __) {
        return BlocBuilder<RoomCubit, RoomInitial>(
          builder: (context, state) {
            return _Temp(item: state.selectedParticipant!);
          },
        );
      },
    );
  }

  Future<void> _connect(Meeting result) async {
    context.read<RoomCubit>()
      ..setToken(result.attendeeOnlineToken)
      ..setUrl(result.onlineMeetingUrl);

    await context.read<RoomCubit>().connect();
    context
        .read<MyStatusCubit>()
        .fetchMyStatus(context.read<RoomCubit>().state.result.localParticipant?.identity ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingCubit, MeetingInitial>(
      builder: (context, mState) {
        return BlocBuilder<RoomCubit, RoomInitial>(
          builder: (context, state) {
            return BlocListener<MyStatusCubit, MyStatusInitial>(
              listenWhen: (p, c) => c.statuses.done,
              listener: (context, sState) {
                if (sState.result.state.isBlock) {
                  context.read<RoomCubit>().disconnect();
                  return;
                }
                switch ((sState.result.state.canPublish, sState.result.state.canSubscribe)) {
                  //suspended
                  case (false, false):
                    if (state.result.localParticipant?.permissions.isSuspend ?? true) return;
                    context.read<UserControlCubit>().suspend(state.result.localParticipant!.identity);
                    break;
                  //only listen
                  case (false, true):
                    if (state.result.localParticipant?.permissions.isSilence ?? true) return;
                    context.read<UserControlCubit>().revoke(state.result.localParticipant!, PermissionType.speak);
                    break;
                  //only speak
                  case (true, false):
                    break;
                  //normal
                  case (true, true):
                    if (state.result.localParticipant?.permissions.isAll ?? true) return;
                    context.read<UserControlCubit>().grant(state.result.localParticipant!, PermissionType.both);
                    break;
                }
              },
              child: SafeArea(
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: !widget.isOpen
                      ? 0.0.verticalSpace
                      : Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(minHeight: 0.2.sh, maxHeight: 0.4.sh, minWidth: 1.0.sw),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (state.result.connectionState.isDisconnected) ...[
                                // MyTextFormOutLineWidget(
                                //   label: 'Token',
                                //   controller: controller,
                                //   icon: IconButton(
                                //     onPressed: () {
                                //       getToken();
                                //     },
                                //     icon: ImageMultiType(url: Icons.generating_tokens),
                                //   ),
                                // ),
                                10.0.verticalSpace,
                                MyButton(
                                  onTap: () {
                                    _connect(mState.result);
                                  },
                                  loading: state.loading,
                                  text: S.of(context).connect,
                                )
                              ] else
                                Expanded(child: VideoWidget()),
                              if (state.result.localParticipant != null && state.result.connectionState.isConnected)
                                ControlsWidget(
                                  state.result,
                                  state.result.localParticipant!,
                                  onFullScreen: () {
                                    showFullScreenDialog();
                                  },
                                ),
                            ],
                          ),
                        ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _Temp extends StatelessWidget {
  const _Temp({required this.item});

  final Participant item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          height: 1.0.sh,
          width: 1.0.sw,
          child: RotatedBox(
            quarterTurns: 1, // تدوير للشاشة (90 درجة)
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: DynamicUser(participant: item),
            ),
          ),
        ),
      ),
    );
  }
}
