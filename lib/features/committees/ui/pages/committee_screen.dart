import 'package:flutter/material.dart';
import 'package:mms/features/home/ui/widget/hi_widget.dart';

import '../widget/committee_widget.dart';

class CommitteeScreen extends StatelessWidget {
  const CommitteeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HiWidget(),
        SingleChildScrollView(
          child: CommitteesWidget(),
        ),
      ],
    );
  }
}
