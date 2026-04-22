import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sopt_practice/providers/music_player_provider.dart';
import 'package:sopt_practice/providers/song_list_provider.dart';

class SongListPage extends ConsumerWidget {
  const SongListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songList = ref.watch(songListProvider);
    final playerState = ref.watch(musicPlayerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('플레이리스트')),
      body: SafeArea(
        child: ListView.builder(
          itemCount: songList.length,
          itemBuilder: (context, index) {
            final song = songList[index];
            final isCurrentSong = playerState.currentSongId == song.id;

            return _buildSongTile(
              isCurrentSong: isCurrentSong,
              title: song.title,
              artist: song.artist,
              albumArtUrl: song.albumArtUrl,
              onTilePressed: () {
                ref.read(musicPlayerProvider.notifier).playSong(song.id);
                context.push('/player/${song.id}');
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSongTile({
    required bool isCurrentSong,
    required String title,
    required String artist,
    required String albumArtUrl,
    required VoidCallback onTilePressed,
  }) {
    final tile = Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        children: [
          // 앨범 아트
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 52,
              height: 52,
              color: Colors.black26,
              child: Image.network(
                albumArtUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.album, size: 52, color: Colors.white54),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isCurrentSong ? Icons.equalizer : Icons.graphic_eq,
                      size: 16,
                      color: isCurrentSong ? Colors.green : null,
                    ),
                    SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          color: isCurrentSong ? Colors.green : null,
                          fontWeight: isCurrentSong ? FontWeight.w600 : null,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  artist,
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return InkWell(onTap: onTilePressed, child: tile);
  }
}
