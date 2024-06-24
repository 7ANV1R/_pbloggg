import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pbloggg_app/core/ui_helper/space_helper.dart';
import 'package:pbloggg_app/core/ui_helper/ui_helper.dart';
import 'package:pbloggg_app/routes/router.dart';

import '../../../data/api/blog/blog_api.dart';
import '../../../data/model/payload/create_blog_payload.dart';
import 'widgets/quill_toolbar.dart';

class CreateBlogPage extends StatefulHookConsumerWidget {
  const CreateBlogPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends ConsumerState<CreateBlogPage> {
  QuillController controller = QuillController.basic();

  // @override
  // void initState() {
  //   super.initState();
  //   final jsonData = [
  //     {"insert": "Test\n"},
  //     {
  //       "insert": {
  //         "image":
  //             "https://jekxsuqvkrbuwalwaijt.supabase.co/storage/v1/object/public/user_image/testagain.jpg"
  //       },
  //       "attributes": {"style": "width: 141.53142857142856; height: 308.0388571428571; "}
  //     },
  //     {"insert": "\nTesttt\n"}
  //   ];

  //   controller.document = Document.fromJson(jsonData);
  // }

  // Future<void> onImageInsert(
  //   String image,
  //   QuillController controller,
  //   BuildContext context,
  // ) async {
  //   log('onImageInsertWithCropping');
  //   if (isWeb()) {
  //     controller.insertImageBlock(imageSource: image);
  //     return;
  //   }

  //   controller.insertImageBlock(imageSource: image);
  // }

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final titleController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Blog'),
        actions: [
          isLoading.value
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                )
              : IconButton(
                  onPressed: () async {
                    // export
                    // final json = jsonEncode(controller.document.toDelta().toJson());
                    // log(json);
                    // controller.document.toDelta();

                    isLoading.value = true;
                    final payload = CreateBlogPayload(
                      title: titleController.text,
                      content: jsonEncode(controller.document.toDelta().toJson()),
                    );
                    // send request
                    final result = await ref.read(blogAPIProvider).createBlogPost(payload: payload);
                    result.fold(
                      (l) {
                        isLoading.value = false;
                        showErrorSnackbar(context: context, message: l.message);
                      },
                      (r) {
                        isLoading.value = false;

                        context.pop();
                      },
                    );
                  },
                  icon: const Icon(Icons.save),
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // title
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                isDense: true,
                labelText: 'Title',
                hintText: 'Enter title',
              ),
            ),
            FilledButton(
              onPressed: () {},
              child: const Text('Add Cover Image'),
            ),
            // QuillToolbar.simple(
            //   configurations: QuillSimpleToolbarConfigurations(
            //     controller: controller,
            //     embedButtons: FlutterQuillEmbeds.toolbarButtons(
            //       imageButtonOptions: QuillToolbarImageButtonOptions(
            //         imageButtonConfigurations: QuillToolbarImageConfigurations(
            //           onImageInsertCallback: isAndroid(supportWeb: false) || isIOS(supportWeb: false) || isWeb()
            //               ? (image, controller) => onImageInsert(image, controller, context)
            //               : null,
            //         ),
            //       ),
            //     ),
            //     multiRowsDisplay: false,
            //     showFontFamily: false,
            //     showHeaderStyle: false,
            //     showInlineCode: false,
            //   ),
            // ),
            QuillCustomToolbar(controller: controller),
            Expanded(
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
                  controller: controller,
                  embedBuilders: FlutterQuillEmbeds.defaultEditorBuilders(),
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('en'),
                    extraConfigurations: {
                      QuillSharedExtensionsConfigurations.key: QuillSharedExtensionsConfigurations(
                        assetsPrefix: 'assets', // Defaults to assets
                      ),
                    },
                  ),
                ),
              ),
            ),
            kGapSpaceM,
          ],
        ),
      ),
    );
  }
}
