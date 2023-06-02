import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:itunes_audio_player/constants/constants.dart';
import '../features/track_playing_screen/controller/track_playing_controller.dart';
import 'utils.dart';
import 'package:http/http.dart' as http;

// singleton class
class NetworkConnectivity {
  // for handling internet connectivity change events
  late InternetConnectionChecker _connectionChecker;
  late StreamSubscription<InternetConnectionStatus> _connectionSubscription;

  TrackPlayingController? _trackPlayingController;

  static final NetworkConnectivity _singleton = NetworkConnectivity._internal();

  factory NetworkConnectivity() {
    return _singleton;
  }

  NetworkConnectivity._internal() {
    _connectionChecker = InternetConnectionChecker();
    _trackPlayingController = null;
  }

  initTrackPlayingController() {
    try {
      _trackPlayingController = Get.find<TrackPlayingController>();
    } catch (_) {
      _trackPlayingController = null;
    }
  }

  initConnectivitySubscription() async {
    _connectionChecker.hasConnection;
    _connectionSubscription =
        _connectionChecker.onStatusChange.listen((status) {
      if (null != _trackPlayingController) {
        switch (status) {
          case InternetConnectionStatus.connected:
            {
              // here internet is connected, but have to check its accessible or not
              checkInternetConnection().then((value) {
                if (value) {
                  // internet is connected and active or accessible
                  Utils.showSnackBar('Info Message', INTERNET_RESTORED_MESSAGE);
                  if (!_trackPlayingController!.isPlaying.value &&
                      _trackPlayingController!.shouldPlayOnConnectivityListen) {
                    // true: when track is paused due to internet disconnect
                    // resuming track, because internet connection is restored
                    _trackPlayingController!.playAudio();
                  }
                }
              });
              break;
            }
          case InternetConnectionStatus.disconnected:
            {
              // no internet connection
              Utils.showSnackBar('Info Message', NO_INTERNET_MESSAGE);
              if (_trackPlayingController!.isPlaying.value) {
                // true: when track is playing
                // pausing track, because internet connection is lost
                _trackPlayingController!.pauseAudio();
              }
              break;
            }
        }
      }
    });
  }

  Future<bool> checkInternetConnection() async {
    try {
      final url = Uri.https('google.com');
      var response = await http.get(url).timeout(const Duration(seconds: 3),
          onTimeout: () {
        return throw Exception();
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  cancelSubscription() => _connectionSubscription.cancel();
}
