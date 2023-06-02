import 'package:get/get.dart';
import 'package:itunes_audio_player/features/track_playing_screen/controller/track_playing_controller.dart';

class TrackPlayingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TrackPlayingController());
  }

}