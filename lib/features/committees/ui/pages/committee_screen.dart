import 'package:flutter/material.dart';

import '../widget/committee_widget.dart';

class CommitteeScreen extends StatelessWidget {
  const CommitteeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CommitteesWidget(),
    );
  }
}
