import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';

import '../../../../generated/l10n.dart';
import '../../bloc/votes_cubit/votes_cubit.dart';
import '../widget/vote_widget.dart';

class VotesPage extends StatelessWidget {
  const VotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).vote),
      body: BlocBuilder<VotesCubit, VotesInitial>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.result.length,
            itemBuilder: (_, i) {
              return VoteItem(item: state.result[i]);
            },
          );
        },
      ),
    );
  }
}
