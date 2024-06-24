import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbloggg_app/core/ui_helper/logger.dart';
import 'package:pbloggg_app/core/ui_helper/ui_helper.dart';
import 'package:pbloggg_app/data/api/blog/storage_api.dart';

class TempUpload extends StatefulHookConsumerWidget {
  const TempUpload({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TempUploadState();
}

class _TempUploadState extends ConsumerState<TempUpload> {
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final webRes = useState('');
    final errText = useState('');
    final pickedFile = useState<File?>(null);
    final isLoading = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temp Upload'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // upload image
          if (pickedFile.value != null)
            Image.file(
              pickedFile.value!,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          if (webRes.value.isNotEmpty) Text('Web Res: ${webRes.value}'),
          if (errText.value.isNotEmpty) Text('Err Res: ${errText.value}'),
          // Btn
          FilledButton(
            onPressed: () async {
              isLoading.value = true;
              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                pickedFile.value = File(image.path);
                final res = await ref.read(storageAPIProvider).uploadCoverImage(pickedFile.value!);
                res.fold(
                  (l) {
                    errText.value = l.message;
                    isLoading.value = false;
                    Logger.red('Error: ${l.message}');
                    showErrorSnackbar(context: context, message: l.message);
                  },
                  (r) {
                    webRes.value = r;
                    isLoading.value = false;
                    showSuccessSnackbar(context: context, message: 'Image uploaded');
                  },
                );
              }
            },
            child: const Text('Upload Image'),
          ),
        ],
      ),
    );
  }
}
