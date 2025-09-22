
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../data/response/agora_response.dart';

class ItemAgora extends StatelessWidget {
  const ItemAgora({super.key, required this.agora});

  final Agora agora;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0.r),
        border: Border.all(),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(20.0).r,
      child: ListTile(
        onTap: () {},
        title: DrawableText(text: ''),
        subtitle: DrawableText(text: ''),
        leading: ImageMultiType(url: ''),
        trailing: ImageMultiType(url: Icons.arrow_forward_ios, height: 20.0.r, color: Colors.grey),
      ),
    );
  }
}


