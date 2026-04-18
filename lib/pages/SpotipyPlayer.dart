import 'package:flutter/material.dart';

class SpotifyPlayer extends StatelessWidget {
  const SpotifyPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B6644),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: const [
              SizedBox(height: 12),
              SpotifyHeader(),
              SizedBox(height: 32),
              SpotifyAlbumCover(),
              SizedBox(height: 32),
              SpotifySongInfo(),
              SizedBox(height: 8),
              SpotifyProgressBar(),
              SizedBox(height: 8),
              SpotifyController(),
            ],
          ),
        ),
      ),
    );
  }
}

class SpotifyHeader extends StatelessWidget {
  const SpotifyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 32,
          ),
        ),
        const Text('AKMU', style: TextStyle(color: Colors.white, fontSize: 14)),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_horiz, color: Colors.white, size: 32),
        ),
      ],
    );
  }
}

class SpotifyAlbumCover extends StatelessWidget {
  const SpotifyAlbumCover({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.network(
          'https://image.genie.co.kr/Y/IMAGE/IMG_ALBUM/087/471/134/87471134_1775454694305_1_600x600.JPG',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class SpotifySongInfo extends StatelessWidget {
  const SpotifySongInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_border,
            color: Colors.white,
            size: 32,
          ),
        ),
      ],
    );
  }
}

class SpotifyProgressBar extends StatelessWidget {
  const SpotifyProgressBar({super.key});

  @override
  Widget build(Object context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 3,
            padding: EdgeInsets.only(top: 16),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.white24,
            thumbColor: Colors.white,
          ),
          child: Slider(value: 0.5, onChanged: (value) {}),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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

class SpotifyController extends StatelessWidget {
  const SpotifyController({super.key});

  @override
  Widget build(Object context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shuffle, color: Colors.white70, size: 24),
        ),

        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.skip_previous, color: Colors.white, size: 40),
        ),

        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),

          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.pause, color: Color(0xFF6B6644), size: 32),
          ),
        ),

        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.skip_next, color: Colors.white, size: 40),
        ),

        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.repeat, color: Colors.white70, size: 24),
        ),
      ],
    );
  }
}
