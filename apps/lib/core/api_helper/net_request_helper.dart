import 'dart:convert';

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
  Map<String, String>? reqHeaders,
  Map<String, dynamic>? requestBody,
  bool needAuthToken = false,
  bool isRawData = true,
}) {
  Logger.green('[$method] ${Uri.parse(url)}');
  // TODO: get the token from the storage
  const authToken = "xxxxxxxxxxxxxxxxx";
  final defaultHeaders = {
    if (isRawData) 'Content-Type': 'application/json',
    if (needAuthToken) 'Authorization': 'Bearer $authToken',
    if (reqHeaders != null) ...reqHeaders,
    // 'ApiAccessToken': EnvConst.baseAPIHeader, // if there is any base header
  };

  // send request
  http.Request request = http.Request(
    method.name.toUpperCase(),
    Uri.parse(url),
  );
  request.headers.addAll(
    defaultHeaders,
  );
  // add body
  if (requestBody != null) {
    request.body = jsonEncode(requestBody);
  }

  return request;
}
