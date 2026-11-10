import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/generated/l10n.dart';

/// Outlined text field with the label **above** the field (redesign).
///
/// The public API is unchanged; only the look changed.
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
  final Function(String s)? onChanged;
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
  State<MyTextFormOutLineWidget> createState() => _MyTextFormOutLineWidgetState();
}

class _MyTextFormOutLineWidgetState extends State<MyTextFormOutLineWidget> {
  final _focusNode = FocusNode();
  late bool _obscure = widget.obscureText;
  bool _hasFocus = false;
  String? _errorText;

  bool get _enabled => widget.enable ?? true;

  @override
  void initState() {
    _focusNode.addListener(_onFocusChanged);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChanged)
      ..dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    widget.onChangedFocus?.call(_focusNode.hasFocus);
    if (mounted) setState(() => _hasFocus = _focusNode.hasFocus);
  }

  /// Runs the original validator and mirrors its message below the field.
  String? _validate(String? value) {
    final error = widget.validator?.call(value);
    if (error != _errorText) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _errorText = error);
      });
    }
    return error;
  }

  OutlineInputBorder _border(Color color, double width) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: width),
        borderRadius: BorderRadius.circular(8.0.r),
      );

  @override
  Widget build(BuildContext context) {
    final hasError = _errorText != null && _errorText!.isNotEmpty;
    final focused = _hasFocus && _enabled;
    final iconColor = focused ? AppColorManager.primary500 : AppColorManager.neutral500;

    Widget? prefix = widget.iconWidget;
    if (prefix == null && widget.icon != null) {
      prefix = Padding(
        padding: EdgeInsetsDirectional.only(start: 14.0.w, end: 10.0.w),
        child: ImageMultiType(
          url: widget.icon,
          width: 20.0.r,
          height: 20.0.r,
          color: iconColor,
        ),
      );
    }

    Widget? suffix = widget.iconWidgetLift;
    if (suffix == null && widget.obscureText) {
      suffix = TextButton(
        onPressed: () => setState(() => _obscure = !_obscure),
        style: TextButton.styleFrom(
          minimumSize: Size(44.0.w, 44.0.h),
          padding: EdgeInsets.symmetric(horizontal: 12.0.w),
        ),
        child: DrawableText(
          text: _obscure ? S.of(context).showPassword : S.of(context).hidePassword,
          size: 13.0.sp,
          fontWeight: .w600,
          color: AppColorManager.primary600,
        ),
      );
    }

    final decoration = InputDecoration(
      isDense: true,
      contentPadding: widget.innerPadding ?? EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 13.0.h),
      filled: true,
      fillColor: _enabled ? AppColorManager.neutral0 : AppColorManager.neutral25,
      hintText: widget.hint,
      hintStyle: TextStyle(color: AppColorManager.neutral500, fontSize: 16.0.sp),
      helperText: (widget.helperText ?? '').isEmpty ? null : widget.helperText,
      helperStyle: TextStyle(color: AppColorManager.neutral500, fontSize: 13.0.sp),
      // The message is drawn below the field (icon + text), so hide the default one.
      errorStyle: const TextStyle(fontSize: 0, height: 0),
      counter: const SizedBox(),
      prefixIcon: prefix,
      prefixIconConstraints: BoxConstraints(minWidth: 44.0.w, minHeight: 44.0.h),
      suffixIcon: suffix,
      suffixIconConstraints: BoxConstraints(minWidth: 44.0.w, minHeight: 44.0.h),
      border: _border(AppColorManager.neutral200, 1),
      enabledBorder: _border(AppColorManager.neutral200, 1),
      focusedBorder: _border(_enabled ? AppColorManager.primary500 : AppColorManager.neutral200, _enabled ? 2 : 1),
      errorBorder: _border(AppColorManager.danger, 1),
      focusedErrorBorder: _border(AppColorManager.danger, 2),
      disabledBorder: _border(AppColorManager.neutral100, 1),
    );

    final field = TextFormField(
      autofillHints: widget.autofillHints,
      onTap: () => widget.onTap?.call(),
      validator: widget.validator == null ? null : _validate,
      decoration: decoration,
      maxLines: widget.maxLines,
      readOnly: !_enabled,
      initialValue: widget.initialValue,
      obscureText: _obscure,
      textAlign: widget.textAlign,
      onChanged: widget.onChanged,
      style: TextStyle(
        fontSize: 16.0.sp,
        height: 26 / 16,
        color: _enabled ? AppColorManager.neutral900 : AppColorManager.neutral700,
      ),
      cursorColor: AppColorManager.primary500,
      focusNode: _focusNode,
      textDirection: widget.textDirection,
      maxLength: widget.maxLength,
      controller: widget.controller,
      keyboardType: widget.keyBordType,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 4.0.h),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          if (widget.label.isNotEmpty) ...[
            DrawableText(
              text: widget.label,
              size: 14.0.sp,
              fontWeight: .w600,
              color: focused ? AppColorManager.primary700 : AppColorManager.neutral700,
            ),
            6.0.verticalSpace,
          ],
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0.r),
              boxShadow: [
                if (focused && !hasError)
                  BoxShadow(color: AppColorManager.primary100, spreadRadius: 4.0.r),
              ],
            ),
            child: field,
          ),
          if (hasError) ...[
            6.0.verticalSpace,
            DrawableText(
              text: _errorText!,
              size: 13.0.sp,
              color: AppColorManager.dangerText,
              matchParent: true,
              drawablePadding: 6.0.w,
              drawableStart: ImageMultiType(
                url: Icons.error_outline,
                width: 16.0.r,
                height: 16.0.r,
                color: AppColorManager.dangerText,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
