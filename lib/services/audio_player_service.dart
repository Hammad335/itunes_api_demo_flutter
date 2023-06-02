import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  late AudioPlayer _audioPlayer;
  late String url = '';

  AudioPlayerService() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setLoopMode(LoopMode.one);
  }

  play(String trackUrl) async {
    try {
      if (url != trackUrl) {
        // setting url of new track when first time user plays the track
        url = trackUrl;
        await _audioPlayer.setUrl(trackUrl);
      }

      // just resuming the track if user clicks play/pause button
      _audioPlayer.play();
    } catch (exception) {
      rethrow;
    }
  }

  void pause() => _audioPlayer.pause();

  bool isPlaying() => _audioPlayer.playing;

  void dispose() => _audioPlayer.dispose();
}
