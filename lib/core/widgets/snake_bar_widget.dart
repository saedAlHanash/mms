import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnakeBarWidget extends StatelessWidget {
  const SnakeBarWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    Widget icon = IconButton(
      icon: const Icon(
        Icons.cancel,
        color: Colors.white,
      ),
      onPressed: () => ScaffoldMessenger.of(context).clearSnackBars(),
    );

    return Container(
      width: 0.9.sw,
      child: DrawableText(
        padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
        text: text,
        fontFamily: FontManager.cairoBold.name,
        size: 16.0.spMin,
        matchParent: true,
        drawableEnd: icon,
        color: Colors.white,
      ),
    );
  }
}
