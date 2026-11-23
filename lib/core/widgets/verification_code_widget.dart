import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/app_color_manager.dart';

/// Digit code input (OTP, check-in code). Always LTR.
///
/// Built on [EditableText] directly, so it needs no Material ancestor and no
/// third-party package. The cells fit the available width (up to 52 each).
/// [validator] runs when the last digit is typed; its message shows under the
/// cells and clears on the next edit.
class PinCodeWidget extends StatefulWidget {
  const PinCodeWidget({
    super.key,
    this.onCompleted,
    this.onChange,
    this.validator,
    this.controller,
    this.length = 6,
    this.autofocus = false,
    this.enabled = true,
  });

  final Function(String)? onCompleted;
  final Function(String)? onChange;
  final String? Function(String?)? validator;

  /// Lets the page clear the code (after a rejected attempt).
  final TextEditingController? controller;
  final int length;
  final bool autofocus;
  final bool enabled;

  @override
  State<PinCodeWidget> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  final _focus = FocusNode();
  TextEditingController? _ownController;
  String? _error;

  TextEditingController get _controller => widget.controller ?? (_ownController ??= TextEditingController());

  @override
  void initState() {
    super.initState();
    _focus.addListener(_rebuild);
    _controller.addListener(_rebuild);
  }

  @override
  void didUpdateWidget(covariant PinCodeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      (oldWidget.controller ?? _ownController)?.removeListener(_rebuild);
      _controller.addListener(_rebuild);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_rebuild);
    _focus.dispose();
    _ownController?.dispose();
    super.dispose();
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  void _onChanged(String value) {
    _error = null;
    widget.onChange?.call(value);
    if (value.length == widget.length) {
      _error = widget.validator?.call(value);
      if (_error == null) widget.onCompleted?.call(value);
    }
  }

  void _focusField() {
    if (!widget.enabled) return;
    _focus.hasFocus ? SystemChannels.textInput.invokeMethod('TextInput.show') : _focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final code = _controller.text;
    final gap = 8.0.w;

    return Directionality(
      textDirection: .ltr,
      child: Column(
        mainAxisSize: .min,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final cell = ((constraints.maxWidth - gap * (widget.length - 1)) / widget.length).clamp(36.0, 52.0);
              return GestureDetector(
                behavior: .opaque,
                onTap: _focusField,
                child: Stack(
                  alignment: .center,
                  children: [
                    Row(
                      mainAxisSize: .min,
                      children: [
                        for (var i = 0; i < widget.length; i++) ...[
                          if (i > 0) SizedBox(width: gap),
                          _Cell(
                            size: cell,
                            digit: i < code.length ? code[i] : null,
                            active: _focus.hasFocus && (i == code.length || (i == widget.length - 1 && code.length == widget.length)),
                            error: _error != null,
                            enabled: widget.enabled,
                          ),
                        ],
                      ],
                    ),
                    // The real input: invisible, it only feeds the cells.
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0,
                        child: IgnorePointer(
                          child: EditableText(
                            controller: _controller,
                            focusNode: _focus,
                            autofocus: widget.autofocus,
                            readOnly: !widget.enabled,
                            style: const TextStyle(fontSize: 1, color: Colors.transparent),
                            cursorColor: Colors.transparent,
                            backgroundCursorColor: Colors.transparent,
                            showCursor: false,
                            enableInteractiveSelection: false,
                            keyboardType: TextInputType.number,
                            autofillHints: const [AutofillHints.oneTimeCode],
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(widget.length),
                            ],
                            onChanged: _onChanged,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          if (_error case final error?) ...[
            8.0.verticalSpace,
            DrawableText(text: error, size: 13.0.sp, color: AppColorManager.dangerText, textAlign: .center),
          ],
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({
    required this.size,
    required this.digit,
    required this.active,
    required this.error,
    required this.enabled,
  });

  final double size;
  final String? digit;
  final bool active;
  final bool error;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final filled = digit != null;
    final borderColor = error
        ? AppColorManager.danger
        : active
        ? AppColorManager.primary500
        : filled
        ? AppColorManager.neutral300
        : AppColorManager.neutral200;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: size,
      height: size * 1.18,
      alignment: .center,
      decoration: BoxDecoration(
        color: filled || active ? AppColorManager.neutral0 : AppColorManager.neutral25,
        borderRadius: BorderRadius.circular(12.0.r),
        border: Border.all(color: borderColor, width: active || error ? 2 : 1),
        boxShadow: active ? [BoxShadow(color: AppColorManager.primary100, spreadRadius: 3.0.r)] : null,
      ),
      child: filled
          ? DrawableText(
              text: digit!,
              size: 22.0.sp,
              fontWeight: .w700,
              color: enabled ? AppColorManager.neutral900 : AppColorManager.neutral500,
            )
          : active
          ? _Caret(height: size * 0.45)
          : null,
    );
  }
}

/// Blinking caret in the active cell.
class _Caret extends StatefulWidget {
  const _Caret({required this.height});

  final double height;

  @override
  State<_Caret> createState() => _CaretState();
}

class _CaretState extends State<_Caret> with SingleTickerProviderStateMixin {
  late final _blink = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))
    ..repeat(reverse: true);

  @override
  void dispose() {
    _blink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _blink,
      child: Container(width: 2, height: widget.height, color: AppColorManager.primary500),
    );
  }
}
