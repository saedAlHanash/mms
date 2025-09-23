import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/features/agora/ui/widget/call_buttons.dart';

import '../../../../core/widgets/my_button.dart';
import '../../../../services/ui_helper.dart';
import '../../bloc/agora_cubit/agora_cubit.dart';
import '../widget/agora_header.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  late final UiHelper utl;

  @override
  void initState() {
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
  Widget build(BuildContext context) {
    return BlocBuilder<AgoraCubit, AgoraInitial>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          color: Theme.of(context).scaffoldBackgroundColor,
          constraints: BoxConstraints(maxHeight: 0.5.sh, minHeight: 0.3.sh),
          child: Column(
            children: [
              HeaderSheet(),
              if (!state.isJoin)
                MyButton(
                  loading: state.loading,
                  text: 'join',
                  onTap: () {
                    context.read<AgoraCubit>().join();
                  },
                )
              else if (state.isSharingMuted)
                MyCardWidget(
                  child: ImageMultiType(
                    url: Icons.stop_screen_share,
                    width: 1.0.sw,
                    height: 0.3.sh,
                  ),
                )
              else
                utl.scrollVideoView(w: 1.0.sw, h: 0.3.sh),
              Spacer(),
              if (state.result.isJoined) CallButtons(engine: state.result.agoraEngine!),
              10.0.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
