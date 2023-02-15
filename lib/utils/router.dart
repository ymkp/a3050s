import 'package:a3050s/features/app/app_wrapper.dart';
// import 'package:a3050s/features/bookmark/screens/bookmark_screen.dart';
// import 'package:a3050s/features/home/screens/home_screen.dart';
// import 'package:a3050s/features/search/screens/search_screen.dart';
import 'package:auto_route/auto_route.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // AutoRoute(
    //   path: 'search',
    //   page: SearchScreen,
    //   // initial: true,
    // ),
    AutoRoute(
      path: '/',
      page: AppWrapper,
      initial: true,
      // children: [
      // AutoRoute(
      //   path: 'home',
      //   page: HomeScreen,
      // ),
      // AutoRoute(
      //   path: 'search',
      //   page: SearchScreen,
      // ),
      // AutoRoute(
      //   path: 'bookmark',
      //   page: BookmarkScreen,
      // ),
      // ],
    ),
  ],
)
class $AppRouter {}
