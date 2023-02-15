// import 'package:a3050s/utils/router.gr.dart';
import 'package:a3050s/features/search/screens/search_screen.dart';
// import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AppWrapper extends StatelessWidget {
  AppWrapper({super.key});
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return Scaffold(
      body: RepaintBoundary(
        key: _key,
        child: const SearchScreen(),
      ),
    );
  }
}
