import 'package:get/get.dart';
import 'package:itunes_audio_player/features/tracks_screen/controller/tracks_screen_controller.dart';

class TracksScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TracksScreenController());
  }

}