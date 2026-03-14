import 'package:flutter/material.dart';

import 'debounced_action.dart';

class DebouncedFilledButton extends StatelessWidget {
  const DebouncedFilledButton({
    super.key,
    required this.debounceKey,
    required this.onPressed,
    required this.child,
    this.cooldown = const Duration(milliseconds: 800),
    this.style,
  });

  final String debounceKey;
  final Future<void> Function()? onPressed;
  final Widget child;
  final Duration cooldown;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed == null
          ? null
          : () async {
              if (!DebouncedAction.canRun(debounceKey, cooldown: cooldown)) {
                return;
              }
              await onPressed?.call();
            },
      style: style,
      child: child,
    );
  }
}

class DebouncedTextButton extends StatelessWidget {
  const DebouncedTextButton({
    super.key,
    required this.debounceKey,
    required this.onPressed,
    required this.child,
    this.cooldown = const Duration(milliseconds: 800),
    this.style,
  });

  final String debounceKey;
  final VoidCallback? onPressed;
  final Widget child;
  final Duration cooldown;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed == null
          ? null
          : () {
              if (!DebouncedAction.canRun(debounceKey, cooldown: cooldown)) {
                return;
              }
              onPressed?.call();
            },
      style: style,
      child: child,
    );
  }
}
