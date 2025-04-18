import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:flutter/material.dart';

class LogaInputField extends ConsumerStatefulWidget {
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
  final String? errorText;
  Function onChange;

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
      this.errorText,
      this.imageIcon,
      required this.onChange});

  @override
  ConsumerState<LogaInputField> createState() => _LogaInputFieldState();
}

class _LogaInputFieldState extends ConsumerState<LogaInputField> {
  bool disableState = true;

  void toggleVisibility() {
    setState(() => disableState = !disableState);
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: SizedBox(
        width: screenWidth * 0.88,
        child: TextField(
          controller: widget.controller,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            widget.onChange(value);
          },
          style: TextStyle(
            color: ref.watch(displayProvider).isLightMode
                ? ref.watch(displayProvider).colorScheme.surface
                : ref.watch(displayProvider).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
            fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight,
          ),
          showCursor: true,
          maxLines: 1,
          cursorColor: ref.watch(displayProvider).isLightMode
              ? ref.watch(displayProvider).colorScheme.surface
              : ref.watch(displayProvider).colorScheme.onSurface,
          obscureText: widget.hideTextInput ? disableState : false,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            filled: true,
            fillColor: ref.watch(displayProvider).colorScheme.onInverseSurface,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: widget.setIconPadding ? widget.iconPadding! : 0),
              child: widget.prefixIcon
                  ? Icon(
                      widget.prefixIconData,
                      color: widget.setIconColor
                          ? widget.iconColor
                          : ref.watch(displayProvider).isLightMode
                              ? ref.watch(displayProvider).colorScheme.surface
                              : ref.watch(displayProvider).colorScheme.onSurface,
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
              color: ref.watch(displayProvider).isLightMode
                  ? ref.watch(displayProvider).colorScheme.surface
                  : ref.watch(displayProvider).colorScheme.onSurface,
              fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ref.watch(displayProvider).colorScheme.onError),
              borderRadius: BorderRadius.all(Radius.circular(widget.buttonBorder)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.all(Radius.circular(widget.buttonBorder)),
            ),
            errorText: hasError ? widget.errorText : null, // Show error message
            errorStyle: const TextStyle(height: 0, color: Colors.red), // Prevents shifting the TextField
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.red), // Maintain same border style
              borderRadius: BorderRadius.all(Radius.circular(widget.buttonBorder)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.red), // Same as focusedBorder
              borderRadius: BorderRadius.all(Radius.circular(widget.buttonBorder)),
            ),
            suffixIcon: widget.alterVisibility
                ? IconButton(
                    onPressed: toggleVisibility,
                    icon: Icon(
                      disableState ? Icons.visibility : Icons.visibility_off,
                      color: ref.watch(displayProvider).colorScheme.onSurface,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
