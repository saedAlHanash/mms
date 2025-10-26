import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_text_form_widget.dart';
import 'package:mms/features/live_kit/ui/widget/controls.dart';
import 'package:mms/features/live_kit/ui/widget/video_widget.dart';

import '../../../../generated/l10n.dart';
import '../../../../services/app_info_service.dart';
import '../../../room/bloc/room_cubit/room_cubit.dart';
import '../widget/users/dynamic_user.dart';

class LiveKitPage extends StatefulWidget {
  const LiveKitPage({super.key, required this.isOpen, required this.link, required this.token});

  final bool isOpen;
  final String link;
  final String token;

  @override
  State<LiveKitPage> createState() => _LiveKitPageState();
}

class _LiveKitPageState extends State<LiveKitPage> {
  void showFullScreenDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, _, __) {
        return BlocBuilder<RoomCubit, RoomInitial>(
          builder: (context, state) {
            final item =
                state.participantTracks.isNotEmpty ? state.participantTracks.first : state.result.localParticipant;
            return _Temp(item: item!);
          },
        );
      },
    );
  }

  Future<void> _connect() async {
    context.read<RoomCubit>()
      ..setToken(controller.text)
      ..setUrl('wss://coretik.coretech-mena.com');
    await context.read<RoomCubit>().initial();
    await context.read<RoomCubit>().connect();
    // if (!(await _checkPermissions())) return;
  }

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
          "canPublish": true,
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

    try {
      setState(() {
        controller.text = r.jsonBodyPure['token'];
      });
    } catch (e) {}
  }

  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: !widget.isOpen
            ? 0.0.verticalSpace
            : BlocBuilder<RoomCubit, RoomInitial>(
                builder: (context, state) {
                  return Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(minHeight: 0.2.sh, maxHeight: 0.4.sh, minWidth: 1.0.sw),
                    child: state.loading
                        ? Center(
                            child: MyStyle.loadingWidget(),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (state.result.connectionState.isDisconnected) ...[
                                MyTextFormOutLineWidget(
                                  label: 'Token',
                                  controller: controller,
                                  icon: IconButton(
                                    onPressed: () {
                                      getToken();
                                    },
                                    icon: ImageMultiType(url: Icons.generating_tokens),
                                  ),
                                ),
                                10.0.verticalSpace,
                                MyButton(
                                  onTap: _connect,
                                  text: S.of(context).connect,
                                )
                              ] else
                                VideoWidget(),
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
                  );
                },
              ),
      ),
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
