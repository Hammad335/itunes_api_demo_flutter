import 'package:get/get.dart';
import 'package:itunes_audio_player/core/models/models.dart';
import 'package:itunes_audio_player/services/audio_player_service.dart';
import 'package:itunes_audio_player/utils/network_connectivity.dart';
import 'package:itunes_audio_player/utils/utils.dart';
import '../../../constants/constants.dart';
import '../../tracks_screen/controller/tracks_screen_controller.dart';

class TrackPlayingController extends GetxController {
  late final TracksScreenController _controller;
  late final AudioPlayerService _audioPlayerService;
  late NetworkConnectivity _networkConnectivity;

  late final Track selectedTrack;
  late final List<Track> _tracksBySameAlbum;
  RxBool isPlaying = false.obs;
  bool shouldPlayOnConnectivityListen = false;

  TrackPlayingController() {
    _controller = Get.find<TracksScreenController>();
    _setSelectedTrack();
    _setTracksBySameAlbum();
    _networkConnectivity = NetworkConnectivity();
  }

  @override
  void onReady() {
    super.onReady();
    _audioPlayerService = _controller.getAudioPlayerServiceInstance;
    _networkConnectivity.initTrackPlayingController();
  }

  void _setSelectedTrack() => selectedTrack = _controller.getSelectedTrack;

  Track get getSelectedTrack => selectedTrack;

  // set all tracks with same album as selected track
  void _setTracksBySameAlbum() => _tracksBySameAlbum = _controller.getAllTracks
      .where((track) =>
          track.collectionName == selectedTrack.collectionName &&
          track.trackId != selectedTrack.trackId)
      .toList();

  // get all tracks with same album as selected track
  List<Track> get getTracksBySameAlbum => [..._tracksBySameAlbum];

  _getPlayingState() => isPlaying.value = _audioPlayerService.isPlaying();

  void playPause() async {
    _getPlayingState();
    try {
      if (isPlaying.value) {
        if (!_controller.isCurrentPlayingTrackTapped) {
          // checking internet connectivity
          if (!(await _controller.hasInternetConnectivity())) {
            showNoInternetSnackBar();
            return;
          }
          shouldPlayOnConnectivityListen = true;
          playAudio();
          return;
        }
        // false: because has paused track himself
        shouldPlayOnConnectivityListen = false;
        pauseAudio();
      } else {
        // checking internet connectivity
        if (!(await _controller.hasInternetConnectivity())) {
          showNoInternetSnackBar();
        }
        shouldPlayOnConnectivityListen = true;
        playAudio();
      }
    } catch (exception) {
      print(exception.toString());
    }
  }

  void pauseAudio() {
    _controller.setPlayingTrackId(-1);
    _audioPlayerService.pause();
    _getPlayingState();
  }

  void playAudio() async {
    _controller.setPlayingTrackId(selectedTrack.trackId);
    await _audioPlayerService.play(selectedTrack.previewUrl);
    _getPlayingState();
  }

  playOnConnectivityListen(bool value) =>
      shouldPlayOnConnectivityListen = value;

  showInternetRestoredSnackBar() =>
      Utils.showSnackBar('Info Message', INTERNET_RESTORED_MESSAGE);

  showNoInternetSnackBar() =>
      Utils.showSnackBar('Info Message', NO_INTERNET_MESSAGE);

  @override
  void onClose() {
    _controller.setAudioPlayerServiceInstance(_audioPlayerService);
    super.onClose();
  }
}
