import 'package:flutter/material.dart';

class SimpleTextButton extends StatelessWidget {
  const SimpleTextButton({
    super.key,
    this.onPressed,
    this.foregroundColor,
    required this.child,
  });

  final Color? foregroundColor;
  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
      ),
      child: child,
    );
  }
}
