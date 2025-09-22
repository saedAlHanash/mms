import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';

import '../../bloc/agora_cubit/agora_cubit.dart';

class AgoraPage extends StatelessWidget {
  const AgoraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AgoraCubit, AgoraInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {},
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(),
        body: BlocBuilder<AgoraCubit, AgoraInitial>(
          builder: (context, state) {
            return ListView(
              shrinkWrap: true,
              children: [],
            );
          },
        ),
      ),
    );
  }
}
