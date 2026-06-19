import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

bool isAssetPath(String path) => !path.startsWith('http');

ImageProvider imageProviderFor(String path) {
  if (isAssetPath(path)) return AssetImage(path);
  return CachedNetworkImageProvider(path);
}

/// Loads images from local assets or remote URLs with consistent placeholders.
class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderIcon = Icons.image_outlined,
    this.placeholderColor,
    this.semanticLabel,
  });

  final String imagePath;
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

    Widget image;
    if (isAssetPath(imagePath)) {
      image = Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => _Placeholder(
          width: width,
          height: height,
          icon: placeholderIcon,
          color: color,
        ),
      );
    } else {
      image = CachedNetworkImage(
        imageUrl: imagePath,
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
    }

    if (semanticLabel != null) {
      image = Semantics(label: semanticLabel, child: image);
    }
    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return image;
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Center(
        child: Icon(icon, color: color.withValues(alpha: 0.45), size: 28),
      ),
    );
  }
}
