import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../strings/app_color_manager.dart';

class MyTextFormOutLineWidget extends StatefulWidget {
  const MyTextFormOutLineWidget({
    super.key,
    this.label = '',
    this.hint = '',
    this.helperText = '',
    this.maxLines = 1,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.maxLength = 1000,
    this.onChanged,
    this.controller,
    this.keyBordType,
    this.innerPadding,
    this.enable,
    this.icon,
    this.color = Colors.black,
    this.initialValue,
    this.textDirection,
    this.validator,
    this.iconWidget,
    this.iconWidgetLift,
    this.onChangedFocus,
    this.onTap,
    this.autofillHints,
  });

  final bool? enable;
  final String label;
  final String hint;
  final String? helperText;
  final dynamic icon;
  final Widget? iconWidget;
  final Widget? iconWidgetLift;
  final Color color;
  final int maxLines;
  final int maxLength;
  final bool obscureText;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final Function(bool)? onChangedFocus;
  final Function()? onTap;

  final List<String>? autofillHints;

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyBordType;
  final EdgeInsets? innerPadding;
  final String? initialValue;
  final TextDirection? textDirection;

  @override
  State<MyTextFormOutLineWidget> createState() =>
      _MyTextFormOutLineWidgetState();
}

class _MyTextFormOutLineWidgetState extends State<MyTextFormOutLineWidget> {
  FocusNode? focusNode;

  @override
  void initState() {
    if (widget.onChangedFocus != null) {
      focusNode = FocusNode()
        ..addListener(() {
          widget.onChangedFocus!.call(focusNode!.hasFocus);
        });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final padding =
        widget.innerPadding ?? const EdgeInsets.symmetric(horizontal: 20.0).w;

    bool obscureText = widget.obscureText;
    Widget? suffixIcon;
    Widget? eye;
    VoidCallback? onChangeObscure;

    if (widget.iconWidget != null) {
      suffixIcon = widget.iconWidget!;
    } else if (widget.icon != null) {
      suffixIcon = Padding(
        padding: const EdgeInsets.all(15.0).r,
        child: ImageMultiType(url: widget.icon!),
      );
    }

    if (obscureText) {
      eye = StatefulBuilder(builder: (context, state) {
        return IconButton(
            splashRadius: 0.01,
            onPressed: () {
              state(() => obscureText = !obscureText);
              if (onChangeObscure != null) onChangeObscure!();
            },
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off));
      });
    }

    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColorManager.f9),
      borderRadius: BorderRadius.circular(10.0.r),
    );

    final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColorManager.red,
        width: 1.0.spMin,
      ),
      borderRadius: BorderRadius.circular(10.0.r),
    );

    final inputDecoration = InputDecoration(
      contentPadding: padding,
      errorBorder: errorBorder,
      border: border,
      focusedBorder: border,
      enabledBorder: border,
      helperText: widget.helperText,
      helperStyle: const TextStyle(color: Colors.grey),
      fillColor: AppColorManager.f9,
      label: DrawableText(
        text: widget.label,
        color: AppColorManager.gray,
        size: 16.0.spMin,
      ),
      counter: const SizedBox(),
      hintText: widget.hint,
      hintStyle: TextStyle(
        color: AppColorManager.gray,
        fontSize: 14.0.sp,
        fontFamily: FontManager.cairoSemiBold.name,
      ),
      filled: true,
      labelStyle: TextStyle(color: widget.color),
      prefixIcon: widget.iconWidget ?? suffixIcon,
      suffixIcon: widget.iconWidgetLift ?? eye,
    );

    final textStyle = TextStyle(
      fontFamily: FontManager.cairoSemiBold.name,
      fontSize: 16.0.spMin,
      color: AppColorManager.black,
    );

    return StatefulBuilder(builder: (context, state) {
      onChangeObscure = () => state(() {});
      return TextFormField(
        autofillHints: widget.autofillHints,
        onTap: () => widget.onTap?.call(),
        validator: widget.validator,
        decoration: inputDecoration,
        maxLines: widget.maxLines,
        readOnly: !(widget.enable ?? true),
        initialValue: widget.initialValue,
        obscureText: obscureText,
        textAlign: widget.textAlign,
        onChanged: widget.onChanged,
        style: textStyle,
        focusNode: focusNode,
        textDirection: widget.textDirection,
        maxLength: widget.maxLength,
        controller: widget.controller,
        keyboardType: widget.keyBordType,
      );
    });
  }
}
