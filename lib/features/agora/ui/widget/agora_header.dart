import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../bloc/agora_cubit/agora_cubit.dart';

class HeaderSheet extends StatefulWidget {
  const HeaderSheet({super.key, this.onTap});

  final Function()? onTap;

  @override
  State<HeaderSheet> createState() => HeaderSheetState();
}

class HeaderSheetState extends State<HeaderSheet> {
  var pop = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgoraCubit, AgoraInitial>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0, -2.0),
              ),
            ],
            color: state.isJoin ? Colors.green.withValues(alpha: 0.3) : Colors.white,
          ),
          child: ListTile(
            leading: ImageMultiType(url: Icons.keyboard_voice_rounded, color: state.color),
            title: DrawableText(text: "الاجتماع الصوتي"),
            onTap: widget.onTap ??
                () {
                  setState(() {
                    pop = true;
                    Navigator.pop(context);
                  });
                },
            trailing: ImageMultiType(
              url: (widget.onTap != null || pop) ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
            ),
          ),
        );
      },
    );
  }
}
