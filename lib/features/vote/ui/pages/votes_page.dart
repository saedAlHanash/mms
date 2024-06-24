import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/features/poll/ui/widget/pool_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../meetings/bloc/meeting_cubit/meeting_cubit.dart';
import '../../bloc/create_vote_cubit/create_vote_cubit.dart';
import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VotesPage extends StatelessWidget {
  const VotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).vote),
      body: BlocListener<CreateVoteCubit, CreateVoteInitial>(
        listenWhen: (p, c) => c.statuses.done,
        listener: (context, state) {
          context.read<MeetingCubit>().getMeeting(newData: true);
        },
        child: BlocBuilder<MeetingCubit, MeetingInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            return ListView.builder(
              itemCount: state.result.polls.length,
              itemBuilder: (_, i) {
                return PollWidget(poll: state.result.polls[i]);
              },
            );
          },
        ),
      ),
    );
  }
}
