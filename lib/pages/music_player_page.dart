import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sopt_practice/models/song.dart';
import 'package:sopt_practice/providers/music_player_provider.dart';
import 'package:sopt_practice/providers/song_list_provider.dart';

class MusicPlayerPage extends ConsumerStatefulWidget {
  const MusicPlayerPage({super.key, required this.id});

  final String id;

  @override
  ConsumerState<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends ConsumerState<MusicPlayerPage> {
  String _formatTime(double seconds) {
    final min = seconds ~/ 60;
    final sec = (seconds % 60).toInt();
    return '$min:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(musicPlayerProvider);
    final songList = ref.watch(songListProvider);

    final song = songList
        .where((element) => element.id == widget.id)
        .firstOrNull;

    if (song == null) {
      return const Scaffold(body: Center(child: Text('곡을 찾을 수 없습니다.')));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF9E8E55),
      appBar: _buildAppBar(song),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              MusicPlayerAlbumCover(albumArtUrl: song.albumArtUrl),
              const SizedBox(height: 24),
              MusicPlayerSongInfo(
                title: song.title,
                artist: song.artist,
                isFavorite: song.isFavorite,
                onToggleFavorite: () =>
                    ref.read(songListProvider.notifier).toggleFavorite(song.id),
              ),
              const SizedBox(height: 16),
              MusicPlayerProgressBar(
                progress: playerState.currentPosition,
                duration: song.duration,
                onSeek: (value) =>
                    ref.read(musicPlayerProvider.notifier).seekTo(value),
                formatTime: _formatTime,
              ),
              const SizedBox(height: 16),
              MusicPlayerController(
                isPlaying: playerState.isPlaying,
                onTogglePlay: () =>
                    ref.read(musicPlayerProvider.notifier).togglePlay(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(Song song) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      title: Text(
        song.artist,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_horiz, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }
}

class MusicPlayerAlbumCover extends StatelessWidget {
  final String albumArtUrl;

  const MusicPlayerAlbumCover({super.key, required this.albumArtUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: 350,
        color: Colors.black26,
        child: Image.network(
          albumArtUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(Icons.album, size: 120, color: Colors.white54),
          ),
        ),
      ),
    );
  }
}

class MusicPlayerSongInfo extends StatelessWidget {
  final String title;
  final String artist;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const MusicPlayerSongInfo({
    super.key,
    required this.title,
    required this.artist,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                artist,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onToggleFavorite,
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.white,
            size: 32,
          ),
        ),
      ],
    );
  }
}

class MusicPlayerProgressBar extends StatelessWidget {
  final double progress;
  final int duration;
  final ValueChanged<double> onSeek;
  final String Function(double) formatTime;

  const MusicPlayerProgressBar({
    super.key,
    required this.progress,
    required this.duration,
    required this.onSeek,
    required this.formatTime,
  });

  @override
  Widget build(BuildContext context) {
    final double musicCurrentSec = progress * duration;
    final int musicFullSec = duration;

    return Column(
      children: [
        SliderTheme(
          data: const SliderThemeData(
            trackHeight: 5,
            padding: EdgeInsets.only(top: 16),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.white24,
            thumbColor: Colors.white,
          ),
          child: Slider(
            value: musicCurrentSec / musicFullSec,
            onChanged: onSeek,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              formatTime(musicCurrentSec),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "-${formatTime(musicFullSec - musicCurrentSec)}",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MusicPlayerController extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onTogglePlay;

  const MusicPlayerController({
    super.key,
    required this.isPlaying,
    required this.onTogglePlay,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.shuffle, color: Colors.white, size: 24),
        const Icon(Icons.skip_previous, color: Colors.white, size: 36),
        GestureDetector(
          onTap: onTogglePlay,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.black,
              size: 36,
            ),
          ),
        ),
        const Icon(Icons.skip_next, color: Colors.white, size: 36),
        const Icon(Icons.repeat, color: Colors.white, size: 24),
      ],
    );
  }
}
