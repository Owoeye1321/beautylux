import 'package:flutter/material.dart';

class LogaInputField extends StatefulWidget {
  final TextEditingController controller;
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
   LogaInputField(
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
      required this.controller,
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
      controller: widget.controller,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
        fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight,
      ),
      showCursor: true,
      maxLines: 1,
      cursorColor: Theme.of(context).colorScheme.onSurface,
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
          color: Theme.of(context).colorScheme.outline,
          fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
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
