import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';

/// Responsive app logo used across splash and auth screens.
class BrandedLogo extends StatelessWidget {
  const BrandedLogo({
    super.key,
    this.sizeFactor = 0.28,
    this.heroTag,
  });

  final double sizeFactor;
  final String? heroTag;

  static const _assetPath = 'assets/images/logo.webp';

  @override
  Widget build(BuildContext context) {
    final size = AppSpacing.logoSize(context, factor: sizeFactor);
    final image = Image.asset(
      _assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      semanticLabel: 'Praktix logo',
    );

    if (heroTag != null) {
      return Hero(tag: heroTag!, child: image);
    }
    return image;
  }
}
