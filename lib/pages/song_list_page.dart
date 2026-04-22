import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sopt_practice/providers/music_player_provider.dart';
import 'package:sopt_practice/providers/song_list_provider.dart';
import 'package:sopt_practice/widgets/song_tile.dart';

class SongListPage extends ConsumerWidget {
  const SongListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songList = ref.watch(songListProvider);
    final playerState = ref.watch(musicPlayerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('플레이리스트'),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/favorites');
            },
            icon: const Icon(Icons.favorite, color: Colors.red),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: songList.length,
          itemBuilder: (context, index) {
            final song = songList[index];
            final isCurrentSong = playerState.currentSongId == song.id;

            return SongTile(
              isCurrentSong: isCurrentSong,
              title: song.title,
              artist: song.artist,
              albumArtUrl: song.albumArtUrl,
              onTap: () {
                ref.read(musicPlayerProvider.notifier).playSong(song.id);
                context.push('/player/${song.id}');
              },
            );
          },
        ),
      ),
    );
  }
}
