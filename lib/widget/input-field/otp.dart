import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTP extends StatefulWidget {
  Function onsubmit;
  OTP({
    super.key,
    required this.onsubmit,
  });

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      fieldWidth: 75,
      filled: true,
      fillColor: Theme.of(context).colorScheme.onInverseSurface,
      focusedBorderColor: Theme.of(context).colorScheme.onError,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      margin: EdgeInsets.only(right: 15),
      cursorColor: Theme.of(context).colorScheme.onSurface,
      enabledBorderColor: Theme.of(context).colorScheme.onInverseSurface,
      borderWidth: 1,
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize!,
      ),
      numberOfFields: 4,
      // borderColor: Theme.of(context).colorScheme.onSurfaceVariant,
      //set to true to show as box or false to show as dash
      showFieldAsBox: true,
      //runs when a code is typed in
      onCodeChanged: (String code) {
        //handle validation or checks here
      },
      //runs when every textfield is filledhhhhg4444444
      onSubmit: (String verificationCode) {
        widget.onsubmit(verificationCode);
      }, // end onSubmit
    );
  }
}
