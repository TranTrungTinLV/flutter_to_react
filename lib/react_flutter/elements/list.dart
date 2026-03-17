import 'package:flutter/material.dart';
import '../style.dart';

/// Equivalent to HTML <ul> — unordered list
class Ul extends StatelessWidget {
  final List<Widget> children;
  final Style? style;
  final double gap;

  const Ul({
    super.key,
    required this.children,
    this.style,
    this.gap = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children
          .expand(
            (child) => [
              child,
              if (child != children.last) SizedBox(height: gap),
            ],
          )
          .toList(),
    );
  }
}

/// Equivalent to HTML <ol> — ordered list (same as Ul but numbered)
class Ol extends StatelessWidget {
  final List<Widget> children;
  final Style? style;
  final double gap;

  const Ol({
    super.key,
    required this.children,
    this.style,
    this.gap = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(children.length, (i) {
        return Padding(
          padding: EdgeInsets.only(bottom: i < children.length - 1 ? gap : 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${i + 1}. ',
                style: Style.parseColor(style?.color) != null
                    ? TextStyle(color: Style.parseColor(style?.color))
                    : null,
              ),
              Expanded(child: children[i]),
            ],
          ),
        );
      }),
    );
  }
}

/// Equivalent to HTML <li> — list item (with bullet point)
class Li extends StatelessWidget {
  final Widget? child;
  final String? text;
  final Style? style;
  final String bulletChar;

  const Li({
    super.key,
    this.child,
    this.text,
    this.style,
    this.bulletChar = '•',
  });

  @override
  Widget build(BuildContext context) {
    final s = style;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$bulletChar  ',
          style: TextStyle(
            color: Style.parseColor(s?.color) ?? Colors.black87,
            fontSize: s?.fontSize ?? 15,
          ),
        ),
        Expanded(
          child: child ??
              Text(
                text ?? '',
                style: s?.textStyle ??
                    const TextStyle(fontSize: 15, color: Colors.black87),
              ),
        ),
      ],
    );
  }
}

/// Equivalent to React's list rendering — renders a scrollable list
class ReactList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(T item, int index) itemBuilder;
  final Style? style;
  final bool scrollable;
  final double gap;

  const ReactList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.style,
    this.scrollable = false,
    this.gap = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (scrollable) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(height: gap),
        itemBuilder: (ctx, i) => itemBuilder(items[i], i),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(items.length, (i) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: i < items.length - 1 ? gap : 0,
          ),
          child: itemBuilder(items[i], i),
        );
      }),
    );
  }
}
