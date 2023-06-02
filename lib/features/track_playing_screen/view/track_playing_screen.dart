import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_audio_player/constants/constants.dart';
import 'package:itunes_audio_player/core/models/models.dart';
import 'package:itunes_audio_player/features/track_playing_screen/controller/track_playing_controller.dart';
import '../../../core/styles/styles.dart';
import '../../../core/widgets/widgets.dart';
import '../../tracks_screen/controller/tracks_screen_controller.dart';

class TrackPlayingScreen extends StatelessWidget {
  static const String name = '/track-playing-screen';
  final TrackPlayingController _controller = Get.find<TrackPlayingController>();
  final TracksScreenController _tracksScreenController =
      Get.find<TracksScreenController>();

  TrackPlayingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Track track = _controller.getSelectedTrack;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              Container(width: double.infinity),
              TrackImageWidget(
                size: 200,
                imageUrl: track.artworkUrl100,
              ),
              const SizedBox(height: 16),
              IconButton(
                onPressed: () => _controller.playPause(),
                icon: Obx(
                  () => Icon(
                    _tracksScreenController.isCurrentPlayingTrackTapped
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline,
                    size: 70,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Divider(thickness: 1.5),
              ),
              Text(
                TRACKS_WITH_SAME_ALBUM,
                style: TextStyles.tracksWithSameAlbumTextStyle,
              ),
              const SizedBox(height: 20),
              if (_controller.getTracksBySameAlbum.isNotEmpty)
                SameAlbumTracks(
                  sameAlbumTracks: _controller.getTracksBySameAlbum,
                ),
              if (_controller.getTracksBySameAlbum.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      NO_SAME_ALBUM_TRACKS,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
