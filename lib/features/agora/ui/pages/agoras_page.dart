import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/agoras_cubit/agoras_cubit.dart';
import '../widget/item_agora.dart';

class AgorasPage extends StatelessWidget {
  const AgorasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: BlocBuilder<AgorasCubit, AgorasInitial>(
        builder: (context, state) {
          return ListView.separated(
            itemCount: state.result.length,
            separatorBuilder: (_, i) => 10.0.verticalSpace,
            itemBuilder: (_, i) {
              final item = state.result[i];
              return ItemAgora(agora: item);
            },
          );
        },
      ),
    );
  }
}
