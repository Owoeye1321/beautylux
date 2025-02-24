import 'package:flutter/material.dart';

class LogaInputField extends StatefulWidget {
  final String hintText;
  final double verticalPadding;
  final double horizontalPadding;
  final bool alterVisibility;
  final bool hideTextInput;
  final IconData? prefixIconData;
  final double? iconSize;
  final bool setIconSize;
  final Color? iconColor;
  final bool setIconColor;
  final bool setIconPadding;
  final double? iconPadding;
  final double buttonBorder;
  final bool prefixIcon;
  final bool prefixImage;
  final Image? imageIcon;
  const LogaInputField(
      {super.key,
      required this.hintText,
      required this.verticalPadding,
      required this.horizontalPadding,
      required this.alterVisibility,
      required this.hideTextInput,
      this.prefixIconData,
      required this.setIconSize,
      this.iconSize,
      this.iconColor,
      required this.setIconColor,
      required this.setIconPadding,
      this.iconPadding,
      required this.buttonBorder,
      required this.prefixIcon,
      required this.prefixImage,
      this.imageIcon});

  @override
  State<LogaInputField> createState() => _LogaInputFieldState();
}

class _LogaInputFieldState extends State<LogaInputField> {
  bool disableState = true;
  void toggleVisibility() {
    setState(() => {disableState = !disableState});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: Theme.of(context).textTheme.titleMedium?.fontSize!,
      ),
      cursorColor: Theme.of(context).colorScheme.onSurfaceVariant,
      obscureText: widget.hideTextInput ? disableState : false,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.onInverseSurface,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: widget.setIconPadding ? widget.iconPadding! : 0),
          child: widget.prefixIcon == true
              ? Icon(
                  widget.prefixIconData,
                  color: widget.setIconColor ? widget.iconColor : Theme.of(context).colorScheme.onSurface,
                  size: widget.setIconSize ? widget.iconSize : 20,
                )
              : widget.imageIcon,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: widget.verticalPadding,
          horizontal: widget.horizontalPadding,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onTertiary,
          fontWeight: Theme.of(context).textTheme.titleSmall?.fontWeight!,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onError),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              100.0,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(widget.buttonBorder),
          ),
        ),
        suffixIcon: widget.alterVisibility
            ? IconButton(
                onPressed: toggleVisibility,
                icon: Icon(
                  disableState ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )
            : null,
      ),
    );
  }
}
