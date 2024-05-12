import 'dart:convert';
import 'dart:io' as io show File;
import 'package:path/path.dart' as path;
import 'dart:developer';
import 'package:flutter_quill/extensions.dart' show isAndroid, isIOS, isWeb;
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

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
  //     {"insert": "Simple "},
  //     {
  //       "insert": "Italic ",
  //       "attributes": {"italic": true}
  //     },
  //     {
  //       "insert": "Underline ",
  //       "attributes": {"italic": true, "underline": true}
  //     },
  //     {"insert": "\n"}
  //   ];

  //   controller.document = Document.fromJson(jsonData);
  // }

  Future<void> onImageInsertWithCropping(
    String image,
    QuillController controller,
    BuildContext context,
  ) async {
    log('onImageInsertWithCropping');
    if (isWeb()) {
      controller.insertImageBlock(imageSource: image);
      return;
    }
    final newSavedImage = await saveImage(io.File(image));
    controller.insertImageBlock(imageSource: newSavedImage);
  }

  Future<String> saveImage(io.File file) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final fileExt = path.extension(file.path);
    final newFileName = '${DateTime.now().toIso8601String()}$fileExt';
    final newPath = path.join(
      appDocDir.path,
      newFileName,
    );
    final copiedFile = await file.copy(newPath);
    return copiedFile.path;
  }

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
          QuillToolbar.simple(
            configurations: QuillSimpleToolbarConfigurations(
              controller: controller,
              embedButtons: FlutterQuillEmbeds.toolbarButtons(
                imageButtonOptions: QuillToolbarImageButtonOptions(
                  imageButtonConfigurations: QuillToolbarImageConfigurations(
                    onImageInsertCallback: isAndroid(supportWeb: false) || isIOS(supportWeb: false) || isWeb()
                        ? (image, controller) => onImageInsertWithCropping(image, controller, context)
                        : null,
                  ),
                ),
              ),
              multiRowsDisplay: false,
              sharedConfigurations: const QuillSharedConfigurations(
                locale: Locale('en'),
              ),
            ),
          ),
          // QuillCustomToolbar(
          //   controller: controller,
          // ),
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
          )
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
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.width_normal,
              ),
            ),
            QuillToolbarHistoryButton(
              isUndo: true,
              controller: controller,
            ),
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
