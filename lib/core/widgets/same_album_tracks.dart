import 'package:flutter/material.dart';
import '../models/models.dart';
import '../styles/styles.dart';

class SameAlbumTracks extends StatelessWidget {
  final List<Track> sameAlbumTracks;

  const SameAlbumTracks({super.key, required this.sameAlbumTracks});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: sameAlbumTracks
            .map((track) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        track.trackName,
                        maxLines: 2,
                        style: TextStyles.sameAlbumTracksTextStyle,
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider()),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
