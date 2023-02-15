import 'package:a3050s/modules/http/http_service.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HttpClientInjection {
  HTTPService get httpService => HTTPService();
}
