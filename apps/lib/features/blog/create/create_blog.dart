import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pbloggg_app/core/ui_helper/space_helper.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Blog'),
        actions: [
          IconButton(
            onPressed: () {
              // export
              final json = jsonEncode(controller.document.toDelta().toJson());
              log(json);
              // controller.document.toDelta();
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Column(
        children: [
          // title
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'Enter title',
            ),
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
                  locale: Locale('de'),
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
    );
  }
}

class QuillCustomToolbar extends StatelessWidget {
  const QuillCustomToolbar({super.key, required this.controller});
  final QuillController controller;

  @override
  Widget build(BuildContext context) {
    return QuillToolbar(
      configurations: const QuillToolbarConfigurations(
        buttonOptions: QuillSimpleToolbarButtonOptions(
          base: QuillToolbarBaseButtonOptions(
            iconSize: 20,
            iconButtonFactor: 1.4,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            QuillToolbarHistoryButton(
              isUndo: true,
              controller: controller,
            ),
            QuillToolbarFontSizeButton(controller: controller),
            QuillToolbarHistoryButton(
              isUndo: false,
              controller: controller,
            ),
            QuillToolbarToggleStyleButton(
              options: const QuillToolbarToggleStyleButtonOptions(),
              controller: controller,
              attribute: Attribute.bold,
            ),
            QuillToolbarToggleStyleButton(
              options: const QuillToolbarToggleStyleButtonOptions(),
              controller: controller,
              attribute: Attribute.italic,
            ),
            QuillToolbarToggleStyleButton(
              controller: controller,
              attribute: Attribute.underline,
            ),
            QuillToolbarClearFormatButton(
              controller: controller,
            ),
            const VerticalDivider(),
            QuillToolbarImageButton(
              controller: controller,
            ),

            // QuillToolbarCameraButton(
            //   controller: controller,
            // ),
            // QuillToolbarVideoButton(
            //   controller: controller,
            // ),
            const VerticalDivider(),
            QuillToolbarColorButton(
              controller: controller,
              isBackground: false,
            ),
            QuillToolbarColorButton(
              controller: controller,
              isBackground: true,
            ),
            const VerticalDivider(),
            // QuillToolbarSelectHeaderStyleButton(
            //   controller: controller,
            // ),
            const VerticalDivider(),
            QuillToolbarToggleCheckListButton(
              controller: controller,
            ),
            QuillToolbarToggleStyleButton(
              controller: controller,
              attribute: Attribute.ol,
            ),
            QuillToolbarToggleStyleButton(
              controller: controller,
              attribute: Attribute.ul,
            ),
            QuillToolbarToggleStyleButton(
              controller: controller,
              attribute: Attribute.inlineCode,
            ),
            QuillToolbarToggleStyleButton(
              controller: controller,
              attribute: Attribute.blockQuote,
            ),
            QuillToolbarIndentButton(
              controller: controller,
              isIncrease: true,
            ),
            QuillToolbarIndentButton(
              controller: controller,
              isIncrease: false,
            ),
            const VerticalDivider(),
            QuillToolbarLinkStyleButton(controller: controller),
          ],
        ),
      ),
    );
  }
}
