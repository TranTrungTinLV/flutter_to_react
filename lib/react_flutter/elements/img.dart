import 'package:flutter/material.dart';
import '../style.dart';

/// Equivalent to HTML <img>
class Img extends StatelessWidget {
  final String src;
  final double? width;
  final double? height;
  final String? alt;
  final BoxFit fit;
  final Style? style;

  const Img({
    super.key,
    required this.src,
    this.width,
    this.height,
    this.alt,
    this.fit = BoxFit.cover,
    this.style,
  });

  bool get _isNetwork =>
      src.startsWith('http://') || src.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    final s = style;
    final w = width ?? s?.width;
    final h = height ?? s?.height;
    final br = s?.borderRadiusValue;

    Widget img = _isNetwork
        ? Image.network(
            src,
            width: w,
            height: h,
            fit: fit,
            errorBuilder: (context, error, stack) => _placeholder(w, h),
          )
        : Image.asset(
            src,
            width: w,
            height: h,
            fit: fit,
            errorBuilder: (context, error, stack) => _placeholder(w, h),
          );

    if (br != null) {
      img = ClipRRect(borderRadius: br, child: img);
    }

    return img;
  }

  Widget _placeholder(double? w, double? h) => Container(
        width: w,
        height: h,
        color: const Color(0xFFE0E0E0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.broken_image, color: Colors.grey),
            if (alt != null)
              Text(
                alt!,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      );
}

/// Avatar image — circular img shorthand
class Avatar extends StatelessWidget {
  final String src;
  final double size;
  final String? alt;

  const Avatar({super.key, required this.src, this.size = 40, this.alt});

  @override
  Widget build(BuildContext context) {
    return Img(
      src: src,
      width: size,
      height: size,
      alt: alt,
      style: Style(borderRadius: size / 2),
    );
  }
}
