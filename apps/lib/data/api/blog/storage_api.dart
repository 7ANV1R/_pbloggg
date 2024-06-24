import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pbloggg_app/core/api_helper/future_either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final storageAPIProvider = Provider<StorageAPI>((ref) {
  return StorageAPI();
});

class StorageAPI {
  FutureEitherString uploadCoverImage(File file) async {
    try {
      final res =
          await Supabase.instance.client.storage.from('blog_cover').upload(file.path.split('/').last, file);

      return right(res);
    } catch (e, st) {
      return returnFailure('[StorageAPI][uploadCoverImage]', e, st);
    }
  }

  FutureEitherBool deleteCoverImage(List<String> fileList) async {
    try {
      final res = await Supabase.instance.client.storage.from('blog_cover').remove(fileList);

      if (res.length == fileList.length) {
        return right(true);
      } else {
        return right(false);
      }
    } catch (e, st) {
      return returnFailure('[StorageAPI][deleteCoverImage]', e, st);
    }
  }

  FutureEither<List<String>> uploadBlogContentImage(List<File> files) async {
    try {
      final List<String> res = [];
      for (final file in files) {
        final uploadRes = await Supabase.instance.client.storage.from('blog_content').upload(
              file.path.split('/').last,
              file,
            );
        res.add(uploadRes);
      }
      return right(res);
    } catch (e, st) {
      return returnFailure('[StorageAPI][uploadBlogContentImage]', e, st);
    }
  }
}
