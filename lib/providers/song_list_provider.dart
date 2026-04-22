import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sopt_practice/models/song.dart';

class SongListNotifier extends Notifier<List<Song>> {
  @override
  List<Song> build() {
    return [
      const Song(
        id: '1',
        title: 'Kill Bill',
        artist: 'SZA',
        albumArtUrl:
            'https://www.rollingstone.com/wp-content/uploads/2024/06/SZA-SOS.jpg?w=1280',
        isFavorite: false,
        duration: 214,
      ),
      const Song(
        id: '2',
        title: 'bad guy',
        artist: 'Billie Eilish',
        albumArtUrl:
            'https://www.rollingstone.com/wp-content/uploads/2024/06/Billie-Eilish-When-We-All-Fall-Asleep-Where-Do-We-Go.jpg?w=1280',
        isFavorite: false,
        duration: 228,
      ),
      const Song(
        id: '3',
        title: 'EARFQUAKE',
        artist: 'Tyler, the Creator',
        albumArtUrl:
            'https://www.rollingstone.com/wp-content/uploads/2024/06/Tyler-the-Creator-Igor.jpg?w=1280',
        isFavorite: false,
        duration: 165,
      ),
      const Song(
        id: '4',
        title: 'Pink + White',
        artist: 'Frank Ocean',
        albumArtUrl:
            'https://www.rollingstone.com/wp-content/uploads/2024/06/frank-ocean-blonde.jpg?w=1200',
        isFavorite: false,
        duration: 200,
      ),
      const Song(
        id: '5',
        title: 'Smells Like Teen Spirit',
        artist: 'Nirvana',
        albumArtUrl:
            'https://www.rollingstone.com/wp-content/uploads/2024/06/Nirvana-Nevermind.jpg?w=1280',
        isFavorite: false,
        duration: 186,
      ),
    ];
  }

  void toggleFavorite(String id) {
    state = [
      for (final song in state)
        if (song.id == id)
          song.copyWith(isFavorite: !song.isFavorite)
        else
          song,
    ];
  }
}

final songListProvider = NotifierProvider<SongListNotifier, List<Song>>(
  SongListNotifier.new,
);
