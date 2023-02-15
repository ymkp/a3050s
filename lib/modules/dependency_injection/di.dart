import 'package:a3050s/modules/dependency_injection/di.config.dart' as config;
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: false,
)
// Future<GetIt> configureDependencyInjection() async => $initGetIt(getIt);
Future<GetIt> configureDependencyInjection() async => getIt.init();
