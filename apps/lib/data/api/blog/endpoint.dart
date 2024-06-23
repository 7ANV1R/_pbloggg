import 'package:pbloggg_app/core/const/env_const.dart';

class BlogAPIEndPoint {
  static const String baseAPIURl = EnvConst.baseAPIUrl;
  static const String allBlog = '$baseAPIURl/blog';
  static const String createBlog = '$baseAPIURl/blog/create-blog';
}
