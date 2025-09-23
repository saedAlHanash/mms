import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

import '../generated/assets.dart';

enum ProductName { videoCalling, voiceCalling, interactiveLiveStreaming, broadcastStreaming }

class AgoraManager {
  late Map<String, dynamic> config; // Configuration parameters

  ProductName currentProduct = ProductName.videoCalling;

  int localUid = 0;

  String appId = "";

  String channelName = "";

  List<int> remoteUids = []; // Uids of remote users in the channel

  bool isJoined = false; // Indicates if the local user has joined the channel

  bool isBroadcaster = true; // Client role

  RtcEngine? agoraEngine; // Agora engine instance

  Function(String message)? messageCallback;

  Function(String eventName, Map<String, dynamic> eventArgs)? eventCallback;

  AgoraManager.protectedConstructor({
    this.currentProduct = ProductName.videoCalling,
    this.messageCallback,
    this.eventCallback,
  });

  static Future<AgoraManager> create({
    required ProductName currentProduct,
    required Function(String message) messageCallback,
    required Function(String eventName, Map<String, dynamic> eventArgs) eventCallback,
  }) async {
    final manager = AgoraManager.protectedConstructor(
      currentProduct: currentProduct,
      messageCallback: messageCallback,
      eventCallback: eventCallback,
    );

    await manager.initialize();
    return manager;
  }

  Future<void> initialize() async {
    try {
      final configString = await rootBundle.loadString(Assets.assetsConfig);
      config = jsonDecode(configString);
      appId = config["appId"];
      channelName = config["channelName"];
      localUid = config["uid"];
    } catch (e) {
      messageCallback?.call(e.toString());
    }
  }

  AgoraVideoView remoteVideoView(int remoteUid) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: agoraEngine!,
        canvas: VideoCanvas(uid: remoteUid),
        connection: RtcConnection(channelId: channelName),
      ),
    );
  }

  AgoraVideoView localVideoView() {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: agoraEngine!,
        canvas: const VideoCanvas(uid: 0, renderMode: RenderModeType.renderModeHidden), // Use uid = 0 for local view
      ),
    );
  }

  RtcEngineEventHandler getEventHandler() {
    return RtcEngineEventHandler(
      onConnectionStateChanged: (connection, state, reason) {
        if (reason == ConnectionChangedReasonType.connectionChangedLeaveChannel) {
          remoteUids.clear();
          isJoined = false;
        }
        // Notify the UI
        Map<String, dynamic> eventArgs = {};
        eventArgs["connection"] = connection;
        eventArgs["state"] = state;
        eventArgs["reason"] = reason;
        eventCallback?.call("onConnectionStateChanged", eventArgs);
      },
      onJoinChannelSuccess: (connection, elapsed) {
        isJoined = true;
        messageCallback?.call("Local user uid:${connection.localUid} joined the channel");
        Map<String, dynamic> eventArgs = {};
        eventArgs["connection"] = connection;
        eventArgs["elapsed"] = elapsed;
        eventCallback?.call("onJoinChannelSuccess", eventArgs);
      },
      onUserJoined: (connection, remoteUid, int elapsed) {
        remoteUids.add(remoteUid);
        messageCallback?.call("Remote user uid:$remoteUid joined the channel");
        // Notify the UI
        Map<String, dynamic> eventArgs = {};
        eventArgs["connection"] = connection;
        eventArgs["remoteUid"] = remoteUid;
        eventArgs["elapsed"] = elapsed;
        eventCallback?.call("onUserJoined", eventArgs);
      },
      onUserOffline: (connection, remoteUid, UserOfflineReasonType reason) {
        remoteUids.remove(remoteUid);
        messageCallback?.call("Remote user uid:$remoteUid left the channel");
        // Notify the UI
        Map<String, dynamic> eventArgs = {};
        eventArgs["connection"] = connection;
        eventArgs["remoteUid"] = remoteUid;
        eventArgs["reason"] = reason;
        eventCallback?.call("onUserOffline", eventArgs);
      },
    );
  }

  Future<void> setupAgoraEngine() async {
    // Retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    // Create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();

    await agoraEngine!.initialize(RtcEngineContext(appId: appId));

    if (currentProduct != ProductName.voiceCalling) {
      await agoraEngine!.enableVideo();
      agoraEngine!.muteLocalVideoStream(true);
    }

    // Register the event handler
    agoraEngine!.registerEventHandler(getEventHandler());
  }

  Future<void> join({
    String channelName = '',
    String token = '',
    int uid = -1,
    ClientRoleType clientRole = ClientRoleType.clientRoleBroadcaster,
  }) async {
    channelName = (channelName.isEmpty) ? this.channelName : channelName;
    token = (token.isEmpty) ? config['rtcToken'] : token;
    uid = (uid == -1) ? localUid : uid;

    // Set up Agora engine
    if (agoraEngine == null) await setupAgoraEngine();

    // Enable the local video preview
    await agoraEngine!.startPreview();

    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = ChannelMediaOptions(
      clientRoleType: clientRole,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    // Join a channel
    await agoraEngine!.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }

  Future<void> leave() async {
    // Clear saved remote Uids
    remoteUids.clear();

    // Leave the channel
    if (agoraEngine != null) {
      await agoraEngine!.leaveChannel();
    }
    isJoined = false;

    // Destroy the Agora engine instance
    destroyAgoraEngine();
  }

  void destroyAgoraEngine() {
    // Release the RtcEngine instance to free up resources
    if (agoraEngine != null) {
      agoraEngine!.release();
      agoraEngine = null;
    }
  }

  Future<void> dispose() async {
    if (isJoined) {
      await leave();
    }
    destroyAgoraEngine();
  }
}
