import 'package:http/http.dart' as http;

class AudioService {
  late final http.Client _httpClient;
  static const _baseUrl = 'itunes.apple.com';

  AudioService() {
    _httpClient = http.Client();
  }

  Future<http.Response> fetchTracks(String urlEncodedText) async {
    try {
      Uri requestUri = Uri.https(
        _baseUrl,
        'search',
        <String, String>{
          'term': urlEncodedText,
          'media': 'music',
          'limit': '50',
        },
      );
      return await _httpClient.get(requestUri);
    } catch (_) {
      rethrow;
    }
  }
}
