class Song {
  final String id;
  final String title;
  final String artist;
  final String albumArtUrl;
  final bool isFavorite;
  final int duration;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.albumArtUrl,
    required this.isFavorite,
    required this.duration,
  });

  Song copyWith({
    String? id,
    String? title,
    String? artist,
    String? albumArtUrl,
    bool? isFavorite,
    int? duration,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      albumArtUrl: albumArtUrl ?? this.albumArtUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      duration: duration ?? this.duration,
    );
  }
}
