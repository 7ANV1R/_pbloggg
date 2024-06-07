import 'package:http/http.dart' as http;
import 'package:pbloggg_app/core/ui_helper/logger.dart';

enum ReqMethod {
  get,
  post,
  put,
  delete,
  patch,
}

http.Request sendRequest({
  required String url,
  required ReqMethod method,
  bool isRawData = true,
}) {
  Logger.green('[$method] ${Uri.parse(url)}');
  final defaultHeaders = {
    if (isRawData) 'Content-Type': 'application/json',
    // 'ApiAccessToken': EnvConst.baseAPIHeader, // if there is any base header
  };

  // send request
  http.Request request = http.Request(
    method.name.toUpperCase(),
    Uri.parse(url),
  );
  request.headers.addAll(defaultHeaders);

  return request;
}
