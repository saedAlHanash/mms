import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'agora_manager.dart';

class UiHelper {
  late AgoraManager _agoraManager;
  late VoidCallback _setStateCallback;
  int mainViewUid = -1;
  List<int> scrollViewUids = [];

  void initializeUiHelper(AgoraManager agoraManager, VoidCallback setStateCallback) {
    _agoraManager = agoraManager;
    _setStateCallback = setStateCallback;
  }

  Future<void> leave() async {
    await _agoraManager.leave();
    mainViewUid = -1;
    scrollViewUids.clear();
  }

  Widget mainVideoView() {
    if (_agoraManager.currentProduct == ProductName.voiceCalling) {
      return Container();
    } else if (_agoraManager.isJoined) {
      if (mainViewUid == -1 && _agoraManager.isBroadcaster) {
        mainViewUid = 0;
      } else if (mainViewUid == -1) {
        return textContainer("Waiting for a host to join", 240);
      }
      return Container(
          height: 240,
          decoration: BoxDecoration(border: Border.all()),
          margin: const EdgeInsets.only(bottom: 5),
          child: Center(
              child: mainViewUid == 0 ? _agoraManager.localVideoView() : _agoraManager.remoteVideoView(mainViewUid)));
    } else {
      return textContainer('Join a channel', 240);
    }
  }

  Widget textContainer(String text, double height) {
    return Container(
        height: height,
        decoration: BoxDecoration(border: Border.all()),
        margin: const EdgeInsets.only(bottom: 5),
        child: Center(child: Text(text, textAlign: TextAlign.center)));
  }

  Widget scrollVideoView({double? h, double? w}) {
    if (_agoraManager.currentProduct != ProductName.videoCalling) {
      return Container();
    } else if (_agoraManager.remoteUids.isEmpty) {
      return textContainer(_agoraManager.isJoined ? 'Waiting for a remote user to join' : 'Join a channel', 120);
    } else if (_agoraManager.isBroadcaster &&
        (_agoraManager.currentProduct == ProductName.interactiveLiveStreaming ||
            _agoraManager.currentProduct == ProductName.broadcastStreaming)) {
      return Container();
    }

    if (_agoraManager.agoraEngine == null) return textContainer("", 240);

    scrollViewUids.clear();
    scrollViewUids.addAll(_agoraManager.remoteUids);
    scrollViewUids.remove(mainViewUid);
    if (mainViewUid > 0) {
      scrollViewUids.add(0);
    }

    final uid = scrollViewUids.last;
    if (uid == 0) return 0.0.verticalSpace;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0).r),
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.all(15.0).r,
      child: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(double.infinity),
        minScale: 1,
        maxScale: 4.0,
        panEnabled: true,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: _agoraManager.remoteVideoView(uid),
        ),
      ),
    );
  }

  void handleVideoTap(int remoteUid) {
    mainViewUid = remoteUid;
    _setStateCallback();
  }

  Widget radioButtons() {
    if (_agoraManager.currentProduct == ProductName.interactiveLiveStreaming ||
        _agoraManager.currentProduct == ProductName.broadcastStreaming) {
      return Row(children: <Widget>[
        Radio<bool>(
          value: true,
          groupValue: _agoraManager.isBroadcaster,
          onChanged: (value) => _handleRadioValueChange(value),
        ),
        const Text('Host'),
        Radio<bool>(
          value: false,
          groupValue: _agoraManager.isBroadcaster,
          onChanged: (value) => _handleRadioValueChange(value),
        ),
        const Text('Audience'),
      ]);
    } else {
      return Container();
    }
  }

  void onUserOffline(int remoteUid) {
    if (mainViewUid == remoteUid) {
      mainViewUid = -1;
    }
    _setStateCallback();
  }

  void onUserJoined(int remoteUid) {
    if (!_agoraManager.isBroadcaster) {
      mainViewUid = remoteUid;
    }
    _setStateCallback();
  }

  void _handleRadioValueChange(bool? value) async {
    _agoraManager.isBroadcaster = (value == true);
    _setStateCallback();
    if (_agoraManager.isJoined) leave();
  }
}
