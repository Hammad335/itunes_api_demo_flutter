import 'package:get/get.dart';
import 'package:itunes_audio_player/features/track_playing_screen/bindings/track_playing_binding.dart';
import 'package:itunes_audio_player/features/track_playing_screen/view/track_playing_screen.dart';
import 'package:itunes_audio_player/features/tracks_screen/bindings/tracks_screen_binding.dart';
import 'package:itunes_audio_player/features/tracks_screen/view/tracks_screen.dart';

class Navigate {
  static List<GetPage>? routes = [
    GetPage(
      name: TracksScreen.name,
      page: () => TracksScreen(),
      binding: TracksScreenBinding(),
    ),
    GetPage(
      name: TrackPlayingScreen.name,
      page: () => TrackPlayingScreen(),
      binding: TrackPlayingBinding(),
    ),
  ];
}
