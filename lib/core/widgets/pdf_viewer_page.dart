// import 'package:mms/core/app/bloc/loading_cubit.dart';
// import 'package:mms/core/util/snack_bar_message.dart';
// import 'package:flutter/material.dart';
//
//
// class PdfViewerWidget extends StatelessWidget {
//   const PdfViewerWidget({Key? key, required this.url}) : super(key: key);
//
//   final String url;
//
//   @override
//   Widget build(BuildContext context) {
//     return SfPdfViewer.network(
//       url,
//       onDocumentLoadFailed: (details) {
//         endLoading(context);
//         NoteMessage.showErrorDialog(context, text: 'خطأ في تحميل الملف');
//       },
//     );
//   }
// }
