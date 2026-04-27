import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sopt_practice/providers/music_player_provider.dart';
import 'package:sopt_practice/providers/song_list_provider.dart';
import 'package:sopt_practice/widgets/song_tile.dart';

class FavoriteListPage extends ConsumerWidget {
  const FavoriteListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songList = ref.watch(songListProvider);
    final playerState = ref.watch(musicPlayerProvider);
    final favoriteSongs = songList.where((song) => song.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('좋아요한 곡 목록')),
      body: SafeArea(
        child: favoriteSongs.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      '아직 좋아요를 누른 곡이 없어요.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              )
            // 데이터가 있으면 기존 ListView 렌더링
            : ListView.builder(
                itemCount: favoriteSongs.length,
                itemBuilder: (context, index) {
                  final song = favoriteSongs[index];
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
