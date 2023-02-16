import 'dart:async';

import 'package:a3050s/features/app/app.dart';
// import 'package:a3050s/i18n/strings.g.dart';
import 'package:a3050s/modules/bloc_observer/observer.dart';
import 'package:a3050s/modules/dependency_injection/di.dart';
import 'package:a3050s/utils/methods/aliases.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      await dotenv.load();

      // Preserve splash screen until authentication complete.
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // Use device locale.
      // LocaleSettings.useDeviceLocale();

      // Removes leading # from the url running on web.
      setPathUrlStrategy();

      // Configures dependency injection to init modules and singletons.
      await configureDependencyInjection();

      if (UniversalPlatform.isAndroid) {}

      if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
        // Sets up allowed device orientations and other settings for the app.
        await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
        );
      }

      // Sets system overylay style.
      await SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [
          SystemUiOverlay.top,
          SystemUiOverlay.bottom,
        ],
      );

      // This setting smoothes transition color for LinearGradient.
      Paint.enableDithering = true;

      // Set bloc observer and hydrated bloc storage.
      Bloc.observer = Observer();
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: kIsWeb
            ? HydratedStorage.webStorageDirectory
            : await getApplicationDocumentsDirectory(),
      );

      return runApp(
        const App(),
        // TranslationProvider(
        //   child: const App(),
        // ),
      );
    },
    (exception, stackTrace) {
      print(exception);
      print(stackTrace);
      // logIt.error(
      //   'err',
      //   error: exception,
      //   stackTrace: stackTrace,
      // );
      // TODO : create exception captures
    },
  );
}
