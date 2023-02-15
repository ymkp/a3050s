import 'package:a3050s/utils/router.gr.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RouterInjection {
  AppRouter router() => AppRouter();
}
