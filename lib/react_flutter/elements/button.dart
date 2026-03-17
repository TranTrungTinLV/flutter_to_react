import 'package:flutter/material.dart';
import '../style.dart';


enum ButtonVariant { elevated, text, outlined, icon }

/// Equivalent to HTML <button>
class Button extends StatelessWidget {
  final Widget? child;
  final String? label;
  final VoidCallback? onClick;
  final Style? style;
  final ButtonVariant variant;
  final bool disabled;
  final bool loading;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  const Button({
    super.key,
    this.child,
    this.label,
    this.onClick,
    this.style,
    this.variant = ButtonVariant.elevated,
    this.disabled = false,
    this.loading = false,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final s = style;
    final handler = disabled || loading ? null : onClick;

    Widget labelWidget = child ??
        Text(
          label ?? '',
          style: s?.color != null ? s!.textStyle : null,
        );

    if (loading) {
      labelWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 8),
          labelWidget,
        ],
      );
    } else if (leadingIcon != null || trailingIcon != null) {
      labelWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[leadingIcon!, const SizedBox(width: 8)],
          labelWidget,
          if (trailingIcon != null) ...[const SizedBox(width: 8), trailingIcon!],
        ],
      );
    }

    final bg = Style.parseColor(s?.backgroundColor);
    final fg = Style.parseColor(s?.color);
    final br = s?.borderRadiusValue ?? BorderRadius.circular(8);
    final pad = s?.edgePadding ??
        const EdgeInsets.symmetric(horizontal: 20, vertical: 12);

    switch (variant) {
      case ButtonVariant.text:
        return TextButton(
          onPressed: handler,
          style: TextButton.styleFrom(
            foregroundColor: fg,
            padding: pad,
            shape: RoundedRectangleBorder(borderRadius: br),
          ),
          child: labelWidget,
        );

      case ButtonVariant.outlined:
        return OutlinedButton(
          onPressed: handler,
          style: OutlinedButton.styleFrom(
            foregroundColor: fg,
            padding: pad,
            shape: RoundedRectangleBorder(borderRadius: br),
            side: BorderSide(
              color: Style.parseColor(s?.borderColor) ??
                  Theme.of(context).colorScheme.primary,
              width: s?.borderWidth ?? 1.5,
            ),
          ),
          child: labelWidget,
        );

      case ButtonVariant.icon:
        return IconButton(
          onPressed: handler,
          icon: child ?? const Icon(Icons.touch_app),
          color: fg,
          tooltip: label,
        );

      case ButtonVariant.elevated:
        return ElevatedButton(
          onPressed: handler,
          style: ElevatedButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: fg,
            padding: pad,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: br),
            minimumSize: Size(s?.width ?? 0, s?.height ?? 40),
          ),
          child: labelWidget,
        );
    }
  }
}

/// Equivalent to React's IconButton or HTML icon-only button
class IconBtn extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onClick;
  final String? tooltip;
  final dynamic color;
  final double size;

  const IconBtn({
    super.key,
    required this.icon,
    this.onClick,
    this.tooltip,
    this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onClick,
      icon: icon,
      color: Style.parseColor(color),
      iconSize: size,
      tooltip: tooltip,
    );
  }
}
