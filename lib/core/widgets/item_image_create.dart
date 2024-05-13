import 'dart:typed_data';

import 'package:mms/core/widgets/my_text_form_widget.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';

import '../../../../core/util/pick_image_helper.dart';
import '../../generated/l10n.dart';

class ItemImageCreate extends StatelessWidget {
  const ItemImageCreate({
    super.key,
    required this.image,
    required this.onLoad,
    this.name = '',
    this.height,
  });

  final String name;
  final double? height;
  final dynamic image;
  final Function(Uint8List bytes) onLoad;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final image = await PickImageHelper().pickImageBytes();
        if (image == null) return;
        onLoad.call(image);
      },
      child: SizedBox(
        height: height ?? 140.0.h,
        width: 1.0.sw,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0.r),
                ),
                clipBehavior: Clip.hardEdge,
                width: 1.0.sw,
                child: ImageMultiType(
                  height: double.infinity,
                  width: double.infinity,
                  url: image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            if (name.isNotEmpty)
              DrawableText(
                text: name,
                fontWeight: FontWeight.bold,
              ),
          ],
        ),
      ),
    );
  }
}

class ItemFiledCreate extends StatelessWidget {
  const ItemFiledCreate({
    super.key,
    required this.image,
    required this.onLoad,
    this.name = '',
    this.height,
  });

  final String name;
  final double? height;
  final dynamic image;
  final Function(Uint8List bytes) onLoad;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final image = await PickImageHelper().pickImageBytes();
        if (image == null) return;
        onLoad.call(image);
      },
      child: IgnorePointer(
        child: MyTextFormOutLineWidget(
          enable: false,
          label: name,
          controller: TextEditingController(
            text: (image is Uint8List)
                ? '${S.of(context).donePick} ${S.of(context).clickToUpdate}'
                : '',
          ),
          iconWidgetLift: ImageMultiType(
              url: image is Uint8List ? Icons.done : Icons.image),
        ),
      ),
    );
  }
}
