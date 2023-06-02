import 'package:flutter/material.dart';

class TrackImageWidget extends StatelessWidget {
  final double size;
  final String imageUrl;

  const TrackImageWidget({
    super.key,
    required this.size,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: FadeInImage.assetNetwork(
        width: size,
        height: size,
        placeholder: "assets/images/default_track_image.png",
        image: imageUrl,
        fit: BoxFit.contain,
        imageErrorBuilder: (context, exception, stackTrace) {
          // Handling image loading error if no internet connection
          return Image.asset(
            "assets/images/default_track_image.png",
            width: size,
            height: size,
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }
}
