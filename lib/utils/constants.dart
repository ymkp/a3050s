import 'package:flutter/material.dart';

final $constants = Constants();

@immutable
class Constants {
  final appTitle = 'a3050s Itunes Preview';

  /// Theme defaults.
  late final theme = _Theme();

  /// Animation durations.
  late final times = _Times();

  /// Rounded edge corner radiuses.
  late final corners = _Corners();

  /// Padding and margin values.
  late final insets = _Insets();

  /// Text shadows.
  late final shadows = _Shadows();

  /// Color $constants.palette.
  late final palette = _Palette();

  /// API configuration.
  late final api = _API();
}

@immutable
class _Times {
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration slow = const Duration(milliseconds: 900);
  final Duration pageTransition = const Duration(milliseconds: 200);
}

@immutable
class _Corners {
  late final double sm = 4;
  late final double md = 8;
  late final double lg = 32;
}

@immutable
class _Insets {
  late final double xxs = 4;
  late final double xs = 8;
  late final double sm = 16;
  late final double md = 24;
  late final double lg = 32;
  late final double xl = 48;
  late final double xxl = 56;
  late final double offset = 80;
}

@immutable
class _Shadows {
  final textSoft = [
    Shadow(
      color: Colors.black.withOpacity(0.25),
      offset: const Offset(0, 2),
      blurRadius: 4,
    ),
  ];
  final text = [
    Shadow(
      color: Colors.black.withOpacity(0.6),
      offset: const Offset(0, 2),
      blurRadius: 2,
    ),
  ];
  final textStrong = [
    Shadow(
      color: Colors.black.withOpacity(0.6),
      offset: const Offset(0, 4),
      blurRadius: 6,
    ),
  ];
}

@immutable
class _Palette {
  final List<Color> themes = [
    const Color(0xFFFF0000),
    const Color(0xFFFF8000),
    const Color(0xFFFCCC1A),
    const Color(0xFF66B032),
    const Color(0xFF00FFFF),
    const Color(0xFF0000FF),
    const Color(0xFF0080FF),
    const Color(0xFFFF00FF),
  ];

  final white = const Color(0xFFFFFFFF);
  final black = const Color(0xFF191414);
  final grey = const Color(0xFF9E9E9E);
  final red = const Color(0xFFFF0000);
  final orange = const Color(0xFFFF8000);
  final yellow = const Color(0xFFFF9D2B);
  final green = const Color(0xFF1DB954);
  final cyan = const Color(0xFF00FFFF);
  final blue = const Color(0xFF173656);
  final purple = const Color(0xFF0080FF);
  final magenta = const Color(0xFFFF00FF);

  final Map<String, Color> genreColor = {
    'sing': const Color(0xfff52f4b),
    'spatial audio': const Color(0xff090800),
    'fitness': const Color(0xfffda92f),
    'wellbeing': const Color(0xff2a91fc),
    'charts': const Color(0xffe78e17),
    'hip-hop': const Color(0xffc9413c),
    'country': const Color(0xfffda33e),
    'hits': const Color(0xffda9531),
    'pop': const Color(0xffe32560),
    'chill': const Color(0xff4bdce5),
    'r&b': const Color(0xff7182f0),
    'latin': const Color(0xff6d0e9f),
    'dance': const Color(0xff6362ff),
    'dj mixes': const Color(0xfffc2839),
    'feel good': const Color(0xff4fc8eb),
    'party': const Color(0xff7500c0),
    'alternative': const Color(0xff68a0f8),
    'rock': const Color(0xfffc4547),
    'classic rock': const Color(0xff9c001b),
    'essentials': const Color(0xffab64d7),
    'christian': const Color(0xff445af5),
    'classical': const Color(0xff3f00e0),
    'música mexicana': const Color(0xff8c133b),
    'pop latino': const Color(0xfffc2983),
    'urbano latino': const Color(0xff5ed344),
    'k-pop': const Color(0xfff5b535),
    'kids': const Color(0xfff44b85),
    'family': const Color(0xff6ad0c4),
    'music videos': const Color(0xfff23c54),
    'up next': const Color(0xff5560fb),
    'decades': const Color(0xffcc8910),
    'hard rock': const Color(0xffe83f07),
    'metal': const Color(0xff92d67f),
    'acoustic': const Color(0xff6a2386),
    'indie': const Color(0xfff6b05b),
    'electronic': const Color(0xff77d8bf),
    'sleep': const Color(0xff2fb4d8),
    'behind the songs': const Color(0xfffdab35),
    'jazz': const Color(0xff1a1bb9),
    'reggae': const Color(0xff8d0002),
    'focus': const Color(0xff229af2),
    'film, tv & stage': const Color(0xffda7041),
    'motivation': const Color(0xffd98807),
    'soul/funk': const Color(0xfff7733b),
    'gospel': const Color(0xffc7229c),
    'oldies': const Color(0xfff46f1d),
    'americana': const Color(0xff5a9bf3),
    'blues': const Color(0xff113496),
    'worldwide': const Color(0xff53a05d),
    'african': const Color(0xfff5bd26),
  };
}

@immutable
class _Theme {
  final tryToGetColorPaletteFromWallpaper = true;
  final defaultThemeColor = const Color(0xFF173656);
  final defaultFontFamily = 'Nunito';
  final double defaultElevation = 0;
  final double defaultBorderRadius = 8;
}

@immutable
class _API {
  final maxItemToBeFetchedAtOneTime = 10;
}
