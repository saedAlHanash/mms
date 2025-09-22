import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class CallButtons extends StatefulWidget {
  final RtcEngine engine;

  const CallButtons({super.key, required this.engine});

  @override
  _CallButtonsState createState() => _CallButtonsState();
}

class _CallButtonsState extends State<CallButtons> {
  bool _isInChannel = false;
  bool _isMicrophoneMuted = false;
  bool _isVideoMuted = false;

  void _disconnect() {
    widget.engine.leaveChannel();
    setState(() {
      _isInChannel = false;
    });
    Navigator.pop(context, true);
  }

  void _muteLocalAudioStream() {
    widget.engine.muteLocalAudioStream(!_isMicrophoneMuted);
    setState(() {
      _isMicrophoneMuted = !_isMicrophoneMuted;
    });
  }

  void _muteLocalVideoStream() {
    widget.engine.muteLocalVideoStream(!_isVideoMuted);
    setState(() {
      _isVideoMuted = !_isVideoMuted;
    });
  }

  void _switchCamera() {
    widget.engine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: _muteLocalAudioStream,
              icon: Icon(
                _isMicrophoneMuted ? Icons.mic_off : Icons.mic,
                color: _isMicrophoneMuted ? Colors.red : Colors.black,
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
              onPressed: _disconnect,
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
              onPressed: _switchCamera,
              icon: const Icon(Icons.switch_camera),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white70,
            ),
            child: IconButton(
              onPressed: _muteLocalVideoStream,
              icon: Icon(
                _isVideoMuted ? Icons.videocam_off : Icons.videocam,
                color: _isVideoMuted ? Colors.red : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
