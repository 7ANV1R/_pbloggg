import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

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
