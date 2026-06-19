import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Consistent network image with placeholder and error handling.
class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderIcon = Icons.image_outlined,
    this.placeholderColor,
    this.semanticLabel,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final IconData placeholderIcon;
  final Color? placeholderColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final color = placeholderColor ?? AppColors.primary;
    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, _) => _Placeholder(
        width: width,
        height: height,
        icon: placeholderIcon,
        color: color,
      ),
      errorWidget: (_, _, _) => _Placeholder(
        width: width,
        height: height,
        icon: placeholderIcon,
        color: color,
      ),
    );

    Widget result = image;
    if (semanticLabel != null) {
      result = Semantics(label: semanticLabel, child: result);
    }
    if (borderRadius != null) {
      result = ClipRRect(borderRadius: borderRadius!, child: result);
    }
    return result;
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({
    required this.width,
    required this.height,
    required this.icon,
    required this.color,
  });

  final double? width;
  final double? height;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color.withValues(alpha: 0.1),
      child: Center(
        child: Icon(icon, color: color.withValues(alpha: 0.5), size: 24),
      ),
    );
  }
}
