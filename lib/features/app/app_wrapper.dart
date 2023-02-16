// import 'package:a3050s/utils/router.gr.dart';
import 'package:a3050s/features/app/blocs/app_cubit.dart';
import 'package:a3050s/features/bookmark/screens/bookmark_screen.dart';
import 'package:a3050s/features/home/screens/home_screen.dart';
import 'package:a3050s/features/media_player/widgets/media_player_bar.dart';

import 'package:a3050s/features/search/screens/search_screen.dart';

// import 'package:a3050s/modules/dependency_injection/di.dart';
// import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});
  // final GlobalKey _key = GlobalKey();
  List<Widget> get screens => const [
        HomeScreen(),
        SearchScreen(),
        BookmarkScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) => Scaffold(
        body: Stack(
          children: [
            screens.elementAt(state.pageIndex),
            const Positioned(
              bottom: 0,
              child: MediaPlayerBar(),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state.pageIndex,
          onTap: (index) {
            context.read<AppCubit>().changePageIndex(index: index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.saved_search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline),
              activeIcon: Icon(Icons.bookmark),
              label: 'Bookmark',
            ),
          ],
        ),
      ),
    );
  }
}
