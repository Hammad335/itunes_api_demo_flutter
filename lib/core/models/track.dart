class Track {
  final int trackId;
  final String trackName;
  final String artistName;
  final String collectionName;
  final String artworkUrl100;
  final String previewUrl;

  const Track({
    required this.trackId,
    required this.trackName,
    required this.artistName,
    required this.collectionName,
    required this.artworkUrl100,
    required this.previewUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'trackId': trackId,
      'trackName': trackName,
      'artistName': artistName,
      'collectionName': collectionName,
      'artworkUrl100': artworkUrl100,
      'previewUrl': previewUrl,
    };
  }

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      trackId: json['trackId'] as int,
      trackName: json['trackName'] as String,
      artistName: json['artistName'] as String,
      collectionName: json['collectionName'] as String,
      artworkUrl100: json['artworkUrl100'] as String,
      previewUrl: json['previewUrl'] as String,
    );
  }
}
