import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/features/live_kit/ui/widget/controls.dart';

import '../../../../generated/l10n.dart';
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
      ..setToken(
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJzYWVkIHVzZXIiLCJqdGkiOiJzYWVkIHVzZXIiLCJpc3MiOiJBUEllU0ZpVjd4aUNSelIiLCJuYmYiOjE3NjEyMjQ4ODksImlhdCI6MTc2MTIyNDg4OSwiZXhwIjoxNzYxMjI4NDg5LCJ2aWRlbyI6eyJhZ2VudCI6ZmFsc2UsImNhblB1Ymxpc2giOnRydWUsImNhblB1Ymxpc2hEYXRhIjp0cnVlLCJjYW5QdWJsaXNoU291cmNlcyI6W10sImNhblN1YnNjcmliZSI6dHJ1ZSwiY2FuU3Vic2NyaWJlTWV0cmljcyI6ZmFsc2UsImNhblVwZGF0ZU93bk1ldGFkYXRhIjpmYWxzZSwiZGVzdGluYXRpb25Sb29tIjoiIiwiaGlkZGVuIjpmYWxzZSwiaW5ncmVzc0FkbWluIjpmYWxzZSwicmVjb3JkZXIiOmZhbHNlLCJyb29tIjoiczEiLCJyb29tQWRtaW4iOmZhbHNlLCJyb29tQ3JlYXRlIjp0cnVlLCJyb29tSm9pbiI6dHJ1ZSwicm9vbUxpc3QiOnRydWUsInJvb21SZWNvcmQiOmZhbHNlfSwic2lwIjp7ImFkbWluIjpmYWxzZSwiY2FsbCI6ZmFsc2V9LCJuYW1lIjoic2FlZCBhbCBIYW5hc2giLCJtZXRhZGF0YSI6IiIsInNoYTI1NiI6IiIsImtpbmQiOiIiLCJhdHRyaWJ1dGVzIjp7InR5cGUiOiIyIiwiaW1hZ2VVcmwiOiJodHRwczovL3Njb250ZW50LXNvZjEtMS54eC5mYmNkbi5uZXQvdi90MzkuMzA4MDgtNi8zMDA0OTczNTFfMTY4MTM0MTY1ODkxNDg2MV8zMjczOTAyMzM2OTA2NDQ0NTg2X24uanBnP19uY19jYXQ9MTA0JmNjYj0xLTcmX25jX3NpZD02ZWUxMWEmX25jX29oYz1vRENFRUZ6TlhuUVE3a052d0VzVGc1dCZfbmNfb2M9QWRrZXVibjB5NGhIZURGMUNUTG5uNlE0Q2pfSFhjT0NQTmpiRTZEcVpjS2lnclpLanVIY1RraEtkUXdmZ3NRUEJRdyZfbmNfenQ9MjMmX25jX2h0PXNjb250ZW50LXNvZjEtMS54eCZfbmNfZ2lkPWtHcGY1TEpXb3lheklic0cxdTYtc2cmb2g9MDBfQWZmc3RoVnltanFhNkM1UWJtclUtMGFkRkI5dWpDazk1RkZHdDJESnFzNVM0dyZvZT02OEZFRDQyMCJ9LCJyb29tQ29uZmlnIjp7fX0.KIS_jSVy6_0UxrA2G8YmJi97scqa4i_SnmxTTZv3JBw')
      ..setUrl('wss://coretik.coretech-mena.com')
      ..connect();
    // if (!(await _checkPermissions())) return;
  }

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
                              if (state.result.connectionState.isDisconnected)
                                MyButton(
                                  onTap: _connect,
                                  text: S.of(context).connect,
                                )
                              else
                                Builder(builder: (context) {
                                  final item = state.participantTracks.isNotEmpty
                                      ? state.participantTracks.first
                                      : state.result.localParticipant!;
                                  return AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: DynamicUser(participant: item),
                                  );
                                }),
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

const tTest =
    'eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiU2FlZCBBbCBIYW5hc2giLCJhdHRyaWJ1dGVzIjp7ImxrVXNlclR5cGUiOiIyIn0sInZpZGVvIjp7InJvb21Kb2luIjp0cnVlLCJjYW5QdWJsaXNoIjp0cnVlLCJjYW5TdWJzY3JpYmUiOnRydWUsImNhblB1Ymxpc2hEYXRhIjp0cnVlLCJyb29tIjoibTMifSwiaXNzIjoiQVBJUXhaUGp3cEdvY2NyIiwiZXhwIjoxNzYwNTUzMTAzLCJuYmYiOjAsInN1YiI6InVzZXIxIn0.3Xej7La7wgZMHNTi1Ya-tm4-B2wuCtyJU1WEJa6t8lY';
