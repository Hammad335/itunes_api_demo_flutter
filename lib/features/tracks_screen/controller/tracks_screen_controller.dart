import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_audio_player/core/repository/tracks_repo.dart';
import 'package:itunes_audio_player/features/track_playing_screen/view/track_playing_screen.dart';
import 'package:itunes_audio_player/services/audio_player_service.dart';
import 'package:itunes_audio_player/services/audio_service.dart';
import 'package:itunes_audio_player/utils/network_connectivity.dart';
import '../../../constants/constants.dart';
import '../../../core/models/models.dart';
import '../../../utils/utils.dart';

class TracksScreenController extends GetxController {
  // checking internet connection
  late final NetworkConnectivity _networkConnectivity;

  // repo that make service call and returns list of tracks
  late final TracksRepo _tracksRepo;

  // text editing controller for search box
  late TextEditingController searchTextController;

  late RxList<Track> allMusicTracks;
  RxInt selectedTrackIndex = (-1).obs;
  RxBool isLoading = false.obs;

  // to change track widget color based on playing state
  RxInt playingTrackId = (-1).obs;

  // AudioPlayerService instance for handling audio events
  late AudioPlayerService _audioPlayerService;

  TracksScreenController() {
    _networkConnectivity = NetworkConnectivity();
    _tracksRepo = TracksRepo(audioService: AudioService());
    searchTextController = TextEditingController();
    initTracksList();
    _audioPlayerService = AudioPlayerService();
  }

  @override
  void onReady() {
    super.onReady();
    _networkConnectivity.initConnectivitySubscription();
  }

  void initTracksList() => allMusicTracks = <Track>[].obs;

  List<Track> get getAllTracks => [...allMusicTracks];

  Track get getSelectedTrack => getAllTracks[selectedTrackIndex.value];

  _setSelectedTrackIndex(int index) => selectedTrackIndex.value = index;

  void setCurrentIndexAndNavigate(int index) {
    _setSelectedTrackIndex(index);

    // navigating to track playing screen
    Get.toNamed(TrackPlayingScreen.name);
  }

  Future<bool> hasInternetConnectivity() async =>
      await _networkConnectivity.checkInternetConnection();

  void fetchTracks() async {
    if (searchTextController.text.isEmpty) return;

    showLoadingIndicator();
    try {
      // checking internet connectivity
      if (!(await hasInternetConnectivity())) {
        Utils.showSnackBar('Info Message', NO_INTERNET_MESSAGE);
        hideLoadingIndicator();
        return;
      }

      // clearing previous search data
      allMusicTracks.clear();
      selectedTrackIndex.value = (-1);

      // Encode the search text to be used in the API request
      // Replacing white spaces with '+' sign
      String urlEncodedText =
          Uri.encodeQueryComponent(searchTextController.text);

      final tracksList = await _tracksRepo.fetchTracks(urlEncodedText);

      hideLoadingIndicator();

      if (null == tracksList) {
        // it means response tracks list is empty
        // handling no/empty responses
        Utils.showSnackBar('Info Message', 'No tracks found');
      } else {
        allMusicTracks.value = tracksList;
      }
    } catch (exception) {
      isLoading.value = false;
    }
  }

  void showLoadingIndicator() => isLoading.value = true;

  void hideLoadingIndicator() => isLoading.value = false;

  AudioPlayerService get getAudioPlayerServiceInstance => _audioPlayerService;

  void setAudioPlayerServiceInstance(AudioPlayerService audioPlayerService) =>
      _audioPlayerService = audioPlayerService;

  void setPlayingTrackId(int id) => playingTrackId.value = id;

  bool get isCurrentPlayingTrackTapped =>
      getSelectedTrack.trackId == playingTrackId.value;

  @override
  void onClose() {
    _networkConnectivity.cancelSubscription();
    _audioPlayerService.dispose();
    super.onClose();
  }
}
