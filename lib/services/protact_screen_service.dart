// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:screen_protector/screen_protector.dart';
//
// class ProtectScreenService {
//   BuildContext? context;
//
//   static final ProtectScreenService _instance =
//       ProtectScreenService._internal();
//
//   factory ProtectScreenService() {
//     return _instance;
//   }
//
//   ProtectScreenService._internal();
//
//   void startProtect(BuildContext? context) {
//     this.context = context;
//     try {
//       // For iOS only.
//       addListenerPreventScreenshot();
//
//       // For iOS and Android
//       preventScreenshotOn();
//
//       checkScreenRecording().then((value) {
//         if (value) showFullScreenDialog(context);
//       });
//     } on Exception {}
//   }
//
//   void stopProtect() {
//     context = null;
//     try {
//       // For iOS only.
//       removeListenerPreventScreenshot();
//
//       // For iOS and Android
//       preventScreenshotOff();
//     } on Exception {}
//   }
//
//   Future<bool> checkScreenRecording() async {
//     final isRecording = await ScreenProtector.isRecording();
//
//     return isRecording;
//
//     // if (isRecording && context.mounted) {
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     const SnackBar(
//     //       content: Text('Screen Recording...'),
//     //     ),
//     //   );
//     // }
//   }
//
//   void preventScreenshotOn() async {
//     await ScreenProtector.preventScreenshotOn();
//   }
//
//   void preventScreenshotOff() async =>
//       await ScreenProtector.preventScreenshotOff();
//
//   void addListenerPreventScreenshot() async {
//     if (!Platform.isIOS) return;
//     ScreenProtector.addListener(
//       () {
//         /// Screenshot
//         showFullScreenDialog(context);
//         // debugPrint('Screenshot:');
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   const SnackBar(
//         //     content: Text('Screenshot!'),
//         //   ),
//         // );
//       },
//
//       /// Screen Record
//       (isCaptured) {
//         showFullScreenDialog(context);
//         // debugPrint('Screen Record:');
//         // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         //   content: Text('Screen Record!'),
//         // ));
//       },
//     );
//   }
//
//   void removeListenerPreventScreenshot() async {
//     if (!Platform.isIOS) return;
//     ScreenProtector.removeListener();
//   }
// }
//
// class FullScreenDialog extends StatelessWidget {
//   final VoidCallback onCancel;
//
//   const FullScreenDialog({super.key, required this.onCancel});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: EdgeInsets.zero,
//       child: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: Colors.white,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.videocam_off, // Replace with your image path
//               size: 200,
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               "You can't record the screen",
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: onCancel,
//               child: const Text('Close'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// void showFullScreenDialog(BuildContext? context) {
//   if (context == null) return;
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return WillPopScope(
//         onWillPop: () async => false,
//         child: FullScreenDialog(
//           onCancel: () async {
//             final isRecording =
//                 await ProtectScreenService().checkScreenRecording();
//             if (isRecording) return;
//
//             if (context.mounted) {
//               Navigator.pop(context);
//             }
//           },
//         ),
//       );
//     },
//   );
// }
