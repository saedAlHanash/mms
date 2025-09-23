import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/features/agora/ui/widget/call_buttons.dart';

import '../../../../core/widgets/my_button.dart';
import '../../../../services/ui_helper.dart';
import '../../bloc/agora_cubit/agora_cubit.dart';
import '../widget/agora_header.dart';

class FullScreenCall extends StatefulWidget {
  const FullScreenCall({super.key});

  @override
  State<FullScreenCall> createState() => _FullScreenCallState();
}

class _FullScreenCallState extends State<FullScreenCall> {
  late final UiHelper utl;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    utl = UiHelper()
      ..initializeUiHelper(
        context.read<AgoraCubit>().state.result,
        () {
          setState(() {});
        },
      );
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AgoraCubit, AgoraInitial>(
        builder: (context, state) {
          return Container(
            child: utl.scrollVideoView(),
          );
        },
      ),
    );
  }
}
