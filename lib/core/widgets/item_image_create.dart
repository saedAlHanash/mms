import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/widgets/my_text_form_widget.dart';

import '../../../../core/util/pick_image_helper.dart';
import '../../generated/l10n.dart';
import '../strings/app_color_manager.dart';

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
    return Center(
      child: InkWell(
        onTap: () async {
          final image = await PickImageHelper().pickImageBytes();
          if (image == null) return;
          onLoad.call(image);
        },
        child: SizedBox(
          height: height ?? 120.0.r,
          width: height ?? 120.0.r,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleImageWidget(
                size: height ?? 100.0.r,
                url: image,
              ),
              const ImageMultiType(
                url: Icons.edit,
                color: AppColorManager.whit,
              ),
            ],
          ),
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
