import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle tracksScreenHeading = TextStyle(
    fontSize: 19,
  );
  static const TextStyle trackNameTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
  static TextStyle emptyListBodyTextStyle = trackNameTextStyle.copyWith(
    fontWeight: FontWeight.w500,
  );
  static TextStyle albumTextStyle = const TextStyle(
    color: Colors.black54,
    fontStyle: FontStyle.italic,
  );
  static TextStyle sameAlbumTracksTextStyle = const TextStyle(
    fontSize: 15,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle tracksWithSameAlbumTextStyle =
      trackNameTextStyle.copyWith(fontWeight: FontWeight.w600);
}
