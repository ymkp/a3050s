import 'package:a3050s/features/search/blocs/media_search_cubit.dart';
import 'package:a3050s/features/search/repositories/media_search_repository.dart';
import 'package:a3050s/utils/methods/aliases.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MediaSearchRepository>(
          create: (context) => MediaSearchRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                MediaSearchCubit(context.read<MediaSearchRepository>()),
          ),
        ],
        child: MaterialApp.router(
          routerDelegate: AutoRouterDelegate(
            appRouter,
          ),
          routeInformationParser: appRouter.defaultRouteParser(),
        ),
      ),
    );
  }
}
