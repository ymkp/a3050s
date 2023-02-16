import 'package:a3050s/features/app/app_wrapper.dart';
// import 'package:a3050s/features/bookmark/screens/bookmark_screen.dart';
// import 'package:a3050s/features/home/screens/home_screen.dart';
// import 'package:a3050s/features/search/screens/search_screen.dart';
import 'package:auto_route/auto_route.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: AppWrapper,
      initial: true,
    ),
  ],
)
class $AppRouter {}
