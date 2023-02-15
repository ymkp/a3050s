import 'package:a3050s/modules/dependency_injection/di.dart';
import 'package:a3050s/modules/http/http_service.dart';
import 'package:a3050s/utils/helpers/logging_helper.dart';
import 'package:a3050s/utils/router.gr.dart';

final LoggingHelper logIt = getIt<LoggingHelper>();
final AppRouter appRouter = getIt<AppRouter>();
final HTTPService httpClient = getIt<HTTPService>();
