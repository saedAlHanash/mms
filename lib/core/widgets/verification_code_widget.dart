import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinCodeWidget extends StatelessWidget {
  const PinCodeWidget({
    Key? key,
    this.onCompleted,
    this.onChange,
    this.validator,
  }) : super(key: key);
  final Function(String)? onCompleted;
  final Function(String)? onChange;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Pinput(
          length: 6,
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
          onCompleted: onCompleted,
          onChanged: onChange,
          validator: validator,
        ),
      ),
    );
  }
}
