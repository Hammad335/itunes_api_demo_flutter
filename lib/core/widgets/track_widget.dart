import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_audio_player/core/models/models.dart';
import 'package:itunes_audio_player/core/theme/colors.dart';
import 'package:itunes_audio_player/core/widgets/widgets.dart';
import 'package:itunes_audio_player/features/tracks_screen/controller/tracks_screen_controller.dart';
import '../styles/styles.dart';

class TrackWidget extends StatelessWidget {
  final TracksScreenController _controller;
  final int index;

  const TrackWidget({
    super.key,
    required this.index,
    required TracksScreenController controller,
  }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    Track track = _controller.getAllTracks[index];
    return Obx(
      () => Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: _controller.playingTrackId.value == track.trackId
              ? trackWidgetPlayingColor
              : trackWidgetColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            TrackImageWidget(size: 60, imageUrl: track.artworkUrl100),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    track.trackName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.trackNameTextStyle,
                  ),
                  Text(
                    track.artistName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    track.collectionName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.albumTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
