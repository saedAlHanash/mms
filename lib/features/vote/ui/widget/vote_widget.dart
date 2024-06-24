// import 'package:flutter/material.dart';
// import 'package:mms/core/extensions/extensions.dart';
// import 'package:mms/features/poll/data/response/poll_response.dart';
// import 'package:mms/features/vote/data/response/vote_response.dart';
//
// import '../../../../core/widgets/my_checkbox_widget.dart';
//
// class VoteItem extends StatelessWidget {
//   const VoteItem({super.key, required this.poll});
//
//   final Poll poll;
//
//   @override
//   Widget build(BuildContext context) {
//     return MyCheckboxWidget(
//       items: poll.getSpinnerItems(selectedId: widget.poll.meOptionVote?.id),
//       isRadio: true,
//       onSelected: (value, i, isSelected) {
//         request.pollOptionId = value.item.id;
//       },
//     );
//   }
// }
