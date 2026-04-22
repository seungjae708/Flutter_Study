import 'package:flutter/material.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B6644),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: const [
              SizedBox(height: 32),
              MusicPlayerAlbumCover(),
              SizedBox(height: 32),
              MusicPlayerSongInfo(),
              SizedBox(height: 8),
              MusicPlayerProgressBar(),
              SizedBox(height: 8),
              MusicPlayerController(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white,
          size: 32,
        ),
      ),
      title: const Text(
        'AKMU',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_horiz, color: Colors.white, size: 32),
          ),
        ),
      ],
    );
  }
}

class MusicPlayerAlbumCover extends StatelessWidget {
  const MusicPlayerAlbumCover({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: 350,
        color: Colors.black26,
        child: Image.network(
          'https://image.genie.co.kr/Y/IMAGE/IMG_ALBUM/087/471/134/87471134_1775454694305_1_600x600.JPG',
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
  const MusicPlayerSongInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '소문의 낙원',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text('AKMU', style: TextStyle(color: Colors.white70, fontSize: 16)),
          ],
        ),
        GestureDetector(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.favorite_border, color: Colors.white, size: 32),
          ),
        ),
      ],
    );
  }
}

class MusicPlayerProgressBar extends StatelessWidget {
  const MusicPlayerProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: const SliderThemeData(
            trackHeight: 3,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.white24,
            thumbColor: Colors.white,
          ),
          child: Slider(value: 0.5, onChanged: (value) {}),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('1:52', style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text(
              '-1:56',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}

class MusicPlayerController extends StatelessWidget {
  const MusicPlayerController({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: const Icon(Icons.shuffle, color: Colors.white70, size: 24),
        ),
        GestureDetector(
          onTap: () {},
          child: const Icon(Icons.skip_previous, color: Colors.white, size: 40),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.pause, color: Color(0xFF6B6644), size: 32),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Icon(Icons.skip_next, color: Colors.white, size: 40),
        ),
        GestureDetector(
          onTap: () {},
          child: const Icon(Icons.repeat, color: Colors.white70, size: 24),
        ),
      ],
    );
  }
}
