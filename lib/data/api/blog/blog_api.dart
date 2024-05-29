import 'dart:convert' show jsonDecode;

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/api_helper/future_either.dart';
import '../../../core/api_helper/net_request_helper.dart';
import '../../model/blog_preview_model.dart';
import 'endpoint.dart';

final blogAPIProvider = Provider<BlogAPI>((ref) {
  return BlogAPI();
});

class BlogAPI {
  FutureEither<({List<BlogPreviewModel> data, int? nextPage})> fetchBlogPosts({
    required int pageKey,
  }) async {
    try {
      final request = sendRequest(
        url: '${BlogAPIEndPoint.allBlog}?page=$pageKey',
        method: ReqMethod.get,
      );

      final response = await request.send();

      final decodedResponse = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        // decode the response body and return the data
        final List<BlogPreviewModel> data = List<BlogPreviewModel>.from(
          decodedResponse['data'].map((x) => BlogPreviewModel.fromJson(x)),
        );
        final int? nextPage = decodedResponse['pagination']['nextPage'] as int?;
        return right((
          data: data,
          nextPage: nextPage,
        ));
      } else {
        // decode the response body and return the message
        return returnFailure('fetchBlogPosts', decodedResponse['error'], StackTrace.current);
      }
    } catch (e) {
      return returnFailure('[BlogAPI][fetchBlogPosts]', e, StackTrace.current);
    }
  }
}
