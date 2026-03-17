import 'package:flutter/material.dart';
import '../style.dart';

/// Equivalent to HTML <div> — the most flexible layout element.
/// Automatically becomes Column, Row, or Container based on style.
class Div extends StatelessWidget {
  final Style? style;
  final List<Widget>? children;
  final Widget? child;
  final VoidCallback? onClick;
  final String? id;
  final String? className;

  const Div({
    super.key,
    this.style,
    this.children,
    this.child,
    this.onClick,
    this.id,
    this.className,
  });

  @override
  Widget build(BuildContext context) {
    final s = style;

    if (s?.isHidden == true) return const SizedBox.shrink();

    Widget content = _buildContent(s);

    // Apply opacity
    if (s?.opacity != null) {
      content = Opacity(opacity: s!.opacity!, child: content);
    }

    // Apply margin
    if (s?.edgeMargin != null) {
      content = Padding(padding: s!.edgeMargin!, child: content);
    }

    // Apply position absolute
    if (s?.position == 'absolute') {
      content = Positioned(
        top: s?.top,
        bottom: s?.bottom,
        left: s?.left,
        right: s?.right,
        child: content,
      );
    }

    // Wrap in flex if needed
    if (s?.flex != null) {
      content = Expanded(flex: s!.flex!, child: content);
    }

    // onClick
    if (onClick != null) {
      content = GestureDetector(onTap: onClick, child: content);
    }

    return content;
  }

  Widget _buildContent(Style? s) {
    final hasChildren = (children != null && children!.isNotEmpty);
    final hasSingleChild = child != null;

    // If no children, treat as a styled container
    if (!hasChildren && hasSingleChild) {
      return _buildContainer(s, child: child);
    }

    if (!hasChildren && !hasSingleChild) {
      return _buildContainer(s);
    }

    // Determine if row or column layout
    final isRow = s?.isRow ?? false;

    final double? gap = s?.gap;
    final List<Widget> processedChildren = _injectGap(children!, gap, isRow);

    Widget flex;
    if (isRow) {
      flex = Row(
        mainAxisAlignment: s?.mainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment: s?.crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: processedChildren,
      );
    } else {
      flex = Column(
        mainAxisAlignment: s?.mainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment: s?.crossAxisAlignment ?? CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: processedChildren,
      );
    }

    return _buildContainer(s, child: flex);
  }

  Widget _buildContainer(Style? s, {Widget? child}) {
    final decoration = s?.boxDecoration;
    final padding = s?.edgePadding;
    final w = s?.width;
    final h = s?.height;

    final hasDecoration = decoration != null;
    final hasPadding = padding != null;
    final hasSize = w != null || h != null;
    final hasMinMax = s?.minWidth != null ||
        s?.minHeight != null ||
        s?.maxWidth != null ||
        s?.maxHeight != null;

    if (!hasDecoration && !hasPadding && !hasSize && !hasMinMax && child == null) {
      return const SizedBox.shrink();
    }

    Widget result = Container(
      width: w,
      height: h,
      padding: padding,
      decoration: decoration,
      constraints: hasMinMax
          ? BoxConstraints(
              minWidth: s?.minWidth ?? 0,
              minHeight: s?.minHeight ?? 0,
              maxWidth: s?.maxWidth ?? double.infinity,
              maxHeight: s?.maxHeight ?? double.infinity,
            )
          : null,
      child: child,
    );

    // Overflow hidden
    if (s?.overflow == 'hidden' && s?.borderRadiusValue != null) {
      result = ClipRRect(
        borderRadius: s!.borderRadiusValue!,
        child: result,
      );
    }

    return result;
  }

  List<Widget> _injectGap(List<Widget> kids, double? gap, bool isRow) {
    if (gap == null || gap == 0 || kids.isEmpty) return kids;
    final result = <Widget>[];
    for (int i = 0; i < kids.length; i++) {
      result.add(kids[i]);
      if (i < kids.length - 1) {
        result.add(
          isRow
              ? SizedBox(width: gap)
              : SizedBox(height: gap),
        );
      }
    }
    return result;
  }
}

/// Equivalent to HTML <section> — same as Div with semantic meaning.
typedef Section = Div;

/// Equivalent to HTML <article>.
typedef Article = Div;

/// Equivalent to HTML <main>.
typedef Main = Div;

/// Equivalent to HTML <header>.
class Header extends StatelessWidget {
  final Style? style;
  final List<Widget>? children;
  final Widget? child;

  const Header({super.key, this.style, this.children, this.child});

  @override
  Widget build(BuildContext context) {
    final s = Style(
      display: 'flex',
      flexDirection: style?.flexDirection ?? 'row',
      alignItems: style?.alignItems ?? 'center',
      padding: style?.padding ?? 16,
      backgroundColor:
          style?.backgroundColor ?? Theme.of(context).colorScheme.primary,
    );
    return Div(style: s, children: children, child: child);
  }
}

/// Equivalent to HTML <footer>.
typedef Footer = Div;

/// Equivalent to HTML <nav>.
typedef Nav = Div;
