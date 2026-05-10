import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SafeImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final Alignment alignment;

  const SafeImage({
    super.key,
    required this.imageUrl,
    this.fit,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(imageUrl, fit: fit, alignment: alignment);
    }

    if (imageUrl.startsWith('http') || imageUrl.startsWith('blob:')) {
      return Image.network(
        imageUrl,
        fit: fit,
        alignment: alignment,
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
      );
    }

    if (!kIsWeb) {
      return Image.file(File(imageUrl), fit: fit, alignment: alignment);
    }

    return const Icon(Icons.image_not_supported);
  }
}
