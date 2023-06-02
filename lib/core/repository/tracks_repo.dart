import 'dart:convert';
import 'package:itunes_audio_player/core/models/models.dart';
import 'package:itunes_audio_player/services/audio_service.dart';

class TracksRepo {
  late final AudioService _audioService;

  TracksRepo({required AudioService audioService})
      : _audioService = audioService;

  Future<List<Track>?> fetchTracks(String urlEncodedText) async {
    try {
      final response = await _audioService.fetchTracks(urlEncodedText);
      final jsonResponse = json.decode(response.body);
      final List<dynamic> jsonTracksList = jsonResponse['results'];

      // returning null if response is null due to invalid input
      if (jsonTracksList.isEmpty) {
        return null;
      }

      return jsonTracksList
          .map(
            (track) => Track(
              trackId: track['trackId'],
              trackName: track['trackName'],
              artistName: track['artistName'] ?? 'None',
              collectionName: track['collectionName'] ?? 'None',
              artworkUrl100: track['artworkUrl100'],
              previewUrl: track['previewUrl'],
            ),
          )
          .toList();
    } catch (exception) {
      print('exception: ${exception.toString()}');
      rethrow;
    }
  }
}
