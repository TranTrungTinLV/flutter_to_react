import 'package:flutter/material.dart';
import '../style.dart';

/// Equivalent to HTML <a> — link / anchor
class A extends StatelessWidget {
  final Widget? child;
  final String? label;
  final VoidCallback? onTap;
  final String? href; // reserved for future URL launching
  final Style? style;

  const A({
    super.key,
    this.child,
    this.label,
    this.onTap,
    this.href,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final s = style;
    final textColor = Style.parseColor(s?.color) ??
        Theme.of(context).colorScheme.primary;

    Widget content = child ??
        Text(
          label ?? href ?? '',
          style: TextStyle(
            color: textColor,
            fontSize: s?.fontSize ?? 14,
            decoration: TextDecoration.underline,
            decorationColor: textColor,
          ),
        );

    if (onTap != null) {
      content = GestureDetector(onTap: onTap, child: content);
    }

    return content;
  }
}
