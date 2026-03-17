import 'package:flutter/material.dart';

/// CSS-like Style class for React-style Flutter development.
/// Web developers can use familiar CSS property names.
class Style {
  // Spacing
  final double? padding;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final double? paddingTop;
  final double? paddingBottom;
  final double? paddingLeft;
  final double? paddingRight;
  final double? margin;
  final double? marginHorizontal;
  final double? marginVertical;
  final double? marginTop;
  final double? marginBottom;
  final double? marginLeft;
  final double? marginRight;

  // Size
  final double? width;
  final double? height;
  final double? minWidth;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;

  // Colors (accepts '#RRGGBB', 'rgba(r,g,b,a)', or Color)
  final dynamic backgroundColor;
  final dynamic color;
  final dynamic borderColor;

  // Typography
  final double? fontSize;
  final String? fontWeight; // 'bold', 'normal', '100'-'900'
  final String? fontStyle;  // 'italic', 'normal'
  final double? lineHeight;
  final String? textAlign;  // 'left', 'center', 'right'
  final String? fontFamily;
  final dynamic textDecoration; // 'underline', 'line-through'
  final double? letterSpacing;

  // Layout (Flexbox-like)
  final String? display;        // 'flex', 'block', 'none'
  final String? flexDirection;  // 'row', 'column'
  final String? alignItems;     // 'center', 'flex-start', 'flex-end', 'stretch'
  final String? justifyContent; // 'center', 'flex-start', 'flex-end', 'space-between', 'space-around'
  final String? flexWrap;       // 'wrap', 'nowrap'
  final int? flex;
  final double? gap;

  // Border
  final double? borderRadius;
  final double? borderTopLeftRadius;
  final double? borderTopRightRadius;
  final double? borderBottomLeftRadius;
  final double? borderBottomRightRadius;
  final double? borderWidth;
  final String? borderStyle; // 'solid', 'dashed', 'none'

  // Effects
  final double? opacity;
  final List<BoxShadow>? boxShadow;

  // Position
  final String? position; // 'relative', 'absolute'
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  // Overflow
  final String? overflow; // 'hidden', 'visible', 'scroll'

  const Style({
    this.padding,
    this.paddingHorizontal,
    this.paddingVertical,
    this.paddingTop,
    this.paddingBottom,
    this.paddingLeft,
    this.paddingRight,
    this.margin,
    this.marginHorizontal,
    this.marginVertical,
    this.marginTop,
    this.marginBottom,
    this.marginLeft,
    this.marginRight,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.backgroundColor,
    this.color,
    this.borderColor,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.lineHeight,
    this.textAlign,
    this.fontFamily,
    this.textDecoration,
    this.letterSpacing,
    this.display,
    this.flexDirection,
    this.alignItems,
    this.justifyContent,
    this.flexWrap,
    this.flex,
    this.gap,
    this.borderRadius,
    this.borderTopLeftRadius,
    this.borderTopRightRadius,
    this.borderBottomLeftRadius,
    this.borderBottomRightRadius,
    this.borderWidth,
    this.borderStyle,
    this.opacity,
    this.boxShadow,
    this.position,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.overflow,
  });

  // ─── Color Parsing ───────────────────────────────────────────────────────────

  static Color? parseColor(dynamic value) {
    if (value == null) return null;
    if (value is Color) return value;
    if (value is String) {
      final s = value.trim();
      // #RGB or #RRGGBB or #RRGGBBAA
      if (s.startsWith('#')) {
        final hex = s.substring(1);
        if (hex.length == 3) {
          final r = hex[0] * 2;
          final g = hex[1] * 2;
          final b = hex[2] * 2;
          return Color(int.parse('FF$r$g$b', radix: 16));
        } else if (hex.length == 6) {
          return Color(int.parse('FF$hex', radix: 16));
        } else if (hex.length == 8) {
          return Color(int.parse(hex, radix: 16));
        }
      }
      // rgba(r, g, b, a)
      final rgbaMatch = RegExp(
        r'rgba?\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*(?:,\s*([\d.]+)\s*)?\)',
      ).firstMatch(s);
      if (rgbaMatch != null) {
        final r = int.parse(rgbaMatch.group(1)!);
        final g = int.parse(rgbaMatch.group(2)!);
        final b = int.parse(rgbaMatch.group(3)!);
        final a = rgbaMatch.group(4) != null
            ? (double.parse(rgbaMatch.group(4)!) * 255).round()
            : 255;
        return Color.fromARGB(a, r, g, b);
      }
      // Named colors
      return _namedColors[s.toLowerCase()];
    }
    return null;
  }

  static const Map<String, Color> _namedColors = {
    'white': Color(0xFFFFFFFF),
    'black': Color(0xFF000000),
    'red': Color(0xFFF44336),
    'green': Color(0xFF4CAF50),
    'blue': Color(0xFF2196F3),
    'yellow': Color(0xFFFFEB3B),
    'orange': Color(0xFFFF9800),
    'purple': Color(0xFF9C27B0),
    'pink': Color(0xFFE91E63),
    'grey': Color(0xFF9E9E9E),
    'gray': Color(0xFF9E9E9E),
    'transparent': Color(0x00000000),
    'indigo': Color(0xFF3F51B5),
    'teal': Color(0xFF009688),
    'cyan': Color(0xFF00BCD4),
    'amber': Color(0xFFFFC107),
    'lime': Color(0xFFCDDC39),
  };

  // ─── EdgeInsets ───────────────────────────────────────────────────────────────

  EdgeInsets? get edgePadding {
    if (padding != null &&
        paddingTop == null &&
        paddingBottom == null &&
        paddingLeft == null &&
        paddingRight == null &&
        paddingHorizontal == null &&
        paddingVertical == null) {
      return EdgeInsets.all(padding!);
    }
    final t = paddingTop ?? paddingVertical ?? padding ?? 0;
    final b = paddingBottom ?? paddingVertical ?? padding ?? 0;
    final l = paddingLeft ?? paddingHorizontal ?? padding ?? 0;
    final r = paddingRight ?? paddingHorizontal ?? padding ?? 0;
    if (t == 0 && b == 0 && l == 0 && r == 0) return null;
    return EdgeInsets.fromLTRB(l, t, r, b);
  }

  EdgeInsets? get edgeMargin {
    if (margin != null &&
        marginTop == null &&
        marginBottom == null &&
        marginLeft == null &&
        marginRight == null &&
        marginHorizontal == null &&
        marginVertical == null) {
      return EdgeInsets.all(margin!);
    }
    final t = marginTop ?? marginVertical ?? margin ?? 0;
    final b = marginBottom ?? marginVertical ?? margin ?? 0;
    final l = marginLeft ?? marginHorizontal ?? margin ?? 0;
    final r = marginRight ?? marginHorizontal ?? margin ?? 0;
    if (t == 0 && b == 0 && l == 0 && r == 0) return null;
    return EdgeInsets.fromLTRB(l, t, r, b);
  }

  // ─── BorderRadius ─────────────────────────────────────────────────────────────

  BorderRadius? get borderRadiusValue {
    if (borderRadius != null &&
        borderTopLeftRadius == null &&
        borderTopRightRadius == null &&
        borderBottomLeftRadius == null &&
        borderBottomRightRadius == null) {
      return BorderRadius.circular(borderRadius!);
    }
    if (borderTopLeftRadius != null ||
        borderTopRightRadius != null ||
        borderBottomLeftRadius != null ||
        borderBottomRightRadius != null) {
      return BorderRadius.only(
        topLeft: Radius.circular(borderTopLeftRadius ?? 0),
        topRight: Radius.circular(borderTopRightRadius ?? 0),
        bottomLeft: Radius.circular(borderBottomLeftRadius ?? 0),
        bottomRight: Radius.circular(borderBottomRightRadius ?? 0),
      );
    }
    return null;
  }

  // ─── BoxDecoration ────────────────────────────────────────────────────────────

  BoxDecoration? get boxDecoration {
    final bg = parseColor(backgroundColor);
    final br = parseColor(borderColor);
    final radius = borderRadiusValue;
    final hasBorder = (br != null || borderWidth != null) &&
        borderStyle != 'none';
    final hasShadow = boxShadow != null && boxShadow!.isNotEmpty;

    if (bg == null && radius == null && !hasBorder && !hasShadow) return null;

    return BoxDecoration(
      color: bg,
      borderRadius: radius,
      border: hasBorder
          ? Border.all(
              color: br ?? const Color(0xFF000000),
              width: borderWidth ?? 1.0,
            )
          : null,
      boxShadow: hasShadow ? boxShadow : null,
    );
  }

  // ─── TextStyle ────────────────────────────────────────────────────────────────

  TextStyle get textStyle {
    return TextStyle(
      color: parseColor(color),
      fontSize: fontSize,
      fontWeight: _parseFontWeight(fontWeight),
      fontStyle:
          fontStyle == 'italic' ? FontStyle.italic : FontStyle.normal,
      fontFamily: fontFamily,
      height: lineHeight != null && fontSize != null
          ? lineHeight! / fontSize!
          : null,
      letterSpacing: letterSpacing,
      decoration: _parseTextDecoration(textDecoration),
    );
  }

  static FontWeight? _parseFontWeight(String? fw) {
    if (fw == null) return null;
    switch (fw) {
      case 'bold':
        return FontWeight.bold;
      case 'normal':
        return FontWeight.normal;
      case '100':
        return FontWeight.w100;
      case '200':
        return FontWeight.w200;
      case '300':
        return FontWeight.w300;
      case '400':
        return FontWeight.w400;
      case '500':
        return FontWeight.w500;
      case '600':
        return FontWeight.w600;
      case '700':
        return FontWeight.w700;
      case '800':
        return FontWeight.w800;
      case '900':
        return FontWeight.w900;
      default:
        return null;
    }
  }

  static TextDecoration? _parseTextDecoration(dynamic val) {
    if (val == null) return null;
    if (val is TextDecoration) return val;
    switch (val.toString()) {
      case 'underline':
        return TextDecoration.underline;
      case 'line-through':
        return TextDecoration.lineThrough;
      case 'overline':
        return TextDecoration.overline;
      case 'none':
        return TextDecoration.none;
      default:
        return null;
    }
  }

  // ─── Flex alignment ───────────────────────────────────────────────────────────

  MainAxisAlignment get mainAxisAlignment {
    switch (justifyContent) {
      case 'center':
        return MainAxisAlignment.center;
      case 'flex-end':
        return MainAxisAlignment.end;
      case 'space-between':
        return MainAxisAlignment.spaceBetween;
      case 'space-around':
        return MainAxisAlignment.spaceAround;
      case 'space-evenly':
        return MainAxisAlignment.spaceEvenly;
      default:
        return MainAxisAlignment.start;
    }
  }

  CrossAxisAlignment get crossAxisAlignment {
    switch (alignItems) {
      case 'center':
        return CrossAxisAlignment.center;
      case 'flex-end':
        return CrossAxisAlignment.end;
      case 'stretch':
        return CrossAxisAlignment.stretch;
      case 'baseline':
        return CrossAxisAlignment.baseline;
      default:
        return CrossAxisAlignment.start;
    }
  }

  TextAlign get textAlignValue {
    switch (textAlign) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      case 'justify':
        return TextAlign.justify;
      default:
        return TextAlign.left;
    }
  }

  // ─── Display check ────────────────────────────────────────────────────────────

  bool get isRow =>
      flexDirection == 'row' ||
      (display == 'flex' && flexDirection == 'row');

  bool get isHidden => display == 'none';
}
