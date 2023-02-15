import 'dart:convert';
import 'package:a3050s/utils/helpers/toast_helper.dart';
import 'package:a3050s/utils/methods/aliases.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

const int timeoutSeconds = 30;

class HTTPService {
  HTTPService() {
    url = dotenv.env['URL'] ?? '';
    logIt.info('http service initiated : $url');
  }

  late final String url;

  Future<dynamic> get({
    required String route,
    Map<String, String>? header,
    Map<String, dynamic>? query,
  }) async {
    final h = {
      'Content-Type': 'application/json',
    };
    if (header != null && header.isNotEmpty) {
      h.addAll(header);
    }
    final q = query ?? {};
    final res = await http
        .get(
          Uri.parse('$url$route${_getQueryStringFromMap(q)}'),
          headers: h,
        )
        .timeout(const Duration(seconds: timeoutSeconds));
    return _processResponse(res);
  }

  Future<dynamic> post({
    required String route,
    Map<String, String>? header,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) async {
    final h = {
      'Content-Type': 'application/json',
    };
    if (header != null && header.isNotEmpty) {
      h.addAll(header);
    }
    final q = query ?? {};
    final res = await http
        .post(
          Uri.parse('$url$route${_getQueryStringFromMap(q)}'),
          headers: h,
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: timeoutSeconds));
    return _processResponse(res);
  }

  Future<dynamic> patch({
    required String route,
    Map<String, String>? header,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) async {
    final h = {
      'Content-Type': 'application/json',
    };
    if (header != null && header.isNotEmpty) {
      h.addAll(header);
    }
    final q = query ?? {};
    logIt.info(body.toString());
    final res = await http
        .patch(
          Uri.parse('$url$route${_getQueryStringFromMap(q)}'),
          headers: h,
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: timeoutSeconds));
    return _processResponse(res);
  }

  /// process resopnse, try to catch known errors
  dynamic _processResponse(http.Response response) {
    final res = jsonDecode(response.body);
    if ([200, 201].contains(response.statusCode)) {
      return res;
    } else {
      var errMsg = '';
      var thrownMsg = '';
      try {
        final eh = res as Map;
        final err = eh['error'] as Map<String, dynamic>;
        errMsg = err['message'].toString();
      } catch (e) {
        logIt.info('failed to catch error msg', error: e);
      }
      switch (errMsg) {
        case 'Not Found':
          thrownMsg = 'Tidak ditemukan';
          ToastHelper.error(thrownMsg);
          break;
        default:
          thrownMsg = errMsg;
          ToastHelper.error(thrownMsg);
          break;
      }
      throw thrownMsg;
    }
  }

  /// format map to query string
  String _getQueryStringFromMap(Map<String, dynamic> map) {
    var a = '';
    var i = 0;
    map.forEach((key, value) {
      if ((value is int && value != 0) ||
          (value is String && value.isNotEmpty) ||
          (value is List && value.isNotEmpty)) {
        if (i == 0) {
          a += '?$key=$value';
        } else {
          a += '&$key=$value';
        }
        i++;
      }
    });
    return a;
  }
}
