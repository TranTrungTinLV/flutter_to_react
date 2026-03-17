import 'package:flutter/material.dart';
import '../style.dart';

/// Helper to build a Text widget with a given style and optional override.
Widget _buildText(
  String text,
  Style? baseStyle,
  Style? overrideStyle,
  TextAlign? textAlign,
) {
  final merged = _mergeTextStyle(baseStyle, overrideStyle);
  return Text(
    text,
    textAlign: overrideStyle?.textAlignValue ?? textAlign,
    style: merged,
  );
}

TextStyle _mergeTextStyle(Style? base, Style? override) {
  return base!.textStyle.merge(override?.textStyle);
}

// ─── Heading Elements ─────────────────────────────────────────────────────────

/// Equivalent to HTML <h1> — largest heading
class H1 extends StatelessWidget {
  final String text;
  final Style? style;

  const H1(this.text, {super.key, this.style});

  static final _base = Style(
    fontSize: 32,
    fontWeight: 'bold',
    color: '#1a1a2e',
  );

  @override
  Widget build(BuildContext context) => _buildText(text, _base, style, null);
}

/// Equivalent to HTML <h2>
class H2 extends StatelessWidget {
  final String text;
  final Style? style;

  const H2(this.text, {super.key, this.style});

  static final _base = Style(fontSize: 26, fontWeight: 'bold', color: '#1a1a2e');

  @override
  Widget build(BuildContext context) => _buildText(text, _base, style, null);
}

/// Equivalent to HTML <h3>
class H3 extends StatelessWidget {
  final String text;
  final Style? style;

  const H3(this.text, {super.key, this.style});

  static final _base = Style(fontSize: 22, fontWeight: 'bold', color: '#1a1a2e');

  @override
  Widget build(BuildContext context) => _buildText(text, _base, style, null);
}

/// Equivalent to HTML <h4>
class H4 extends StatelessWidget {
  final String text;
  final Style? style;

  const H4(this.text, {super.key, this.style});

  static final _base = Style(fontSize: 18, fontWeight: '600', color: '#1a1a2e');

  @override
  Widget build(BuildContext context) => _buildText(text, _base, style, null);
}

/// Equivalent to HTML <h5>
class H5 extends StatelessWidget {
  final String text;
  final Style? style;

  const H5(this.text, {super.key, this.style});

  static final _base = Style(fontSize: 16, fontWeight: '600', color: '#333');

  @override
  Widget build(BuildContext context) => _buildText(text, _base, style, null);
}

/// Equivalent to HTML <h6>
class H6 extends StatelessWidget {
  final String text;
  final Style? style;

  const H6(this.text, {super.key, this.style});

  static final _base = Style(fontSize: 14, fontWeight: '600', color: '#555');

  @override
  Widget build(BuildContext context) => _buildText(text, _base, style, null);
}

// ─── Text Elements ────────────────────────────────────────────────────────────

/// Equivalent to HTML <p> — paragraph text
class P extends StatelessWidget {
  final String text;
  final Style? style;

  const P(this.text, {super.key, this.style});

  static final _base = Style(fontSize: 16, color: '#444', lineHeight: 24);

  @override
  Widget build(BuildContext context) => _buildText(text, _base, style, null);
}

/// Equivalent to HTML <span> — inline text
class Span extends StatelessWidget {
  final String text;
  final Style? style;

  const Span(this.text, {super.key, this.style});

  static final _base = Style(fontSize: 14, color: '#333');

  @override
  Widget build(BuildContext context) => _buildText(text, _base, style, null);
}

/// Equivalent to HTML <label>
class Label extends StatelessWidget {
  final String text;
  final Style? style;

  const Label(this.text, {super.key, this.style});

  static final _base =
      Style(fontSize: 13, fontWeight: '500', color: '#555');

  @override
  Widget build(BuildContext context) => _buildText(text, _base, style, null);
}

/// Equivalent to HTML <strong> — bold text
class Strong extends StatelessWidget {
  final String text;
  final Style? style;

  const Strong(this.text, {super.key, this.style});

  static final _base = Style(fontWeight: 'bold', color: '#222');

  @override
  Widget build(BuildContext context) => _buildText(text, _base, style, null);
}

/// Equivalent to HTML <em> — italic text
class Em extends StatelessWidget {
  final String text;
  final Style? style;

  const Em(this.text, {super.key, this.style});

  static final _base = Style(fontStyle: 'italic', color: '#444');

  @override
  Widget build(BuildContext context) => _buildText(text, _base, style, null);
}

/// Equivalent to HTML <small> — small text
class Small extends StatelessWidget {
  final String text;
  final Style? style;

  const Small(this.text, {super.key, this.style});

  static final _base = Style(fontSize: 12, color: '#888');

  @override
  Widget build(BuildContext context) => _buildText(text, _base, style, null);
}

/// Equivalent to HTML <code> — monospace code text
class Code extends StatelessWidget {
  final String text;
  final Style? style;

  const Code(this.text, {super.key, this.style});

  static final _base = Style(
    fontFamily: 'monospace',
    fontSize: 13,
    color: '#e83e8c',
    backgroundColor: '#f8f9fa',
    padding: 4,
    borderRadius: 3,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _base.edgePadding,
      decoration: _base.boxDecoration,
      child: _buildText(text, _base, style, null),
    );
  }
}

/// Equivalent to HTML <hr> — horizontal rule/divider
class Hr extends StatelessWidget {
  final Style? style;
  final double thickness;
  final dynamic color;

  const Hr({super.key, this.style, this.thickness = 1.0, this.color});

  @override
  Widget build(BuildContext context) {
    final c = Style.parseColor(color ?? style?.borderColor ?? '#e0e0e0');
    return Divider(
      thickness: thickness,
      color: c,
    );
  }
}

/// Equivalent to HTML <br> — line break (vertical space)
class Br extends StatelessWidget {
  final double height;
  const Br({super.key, this.height = 16});

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}
