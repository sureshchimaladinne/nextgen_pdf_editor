// import 'package:flutter/material.dart';
// import 'package:nextgen_pdf_editor/components/color_picker.dart';
// import 'package:nextgen_pdf_editor/controllers/text_box_controller.dart'
//     as opdf;

// Future<Map<String, dynamic>?> showTextEditDialog(
//   BuildContext context,
//   opdf.TextBox textBox,
// ) async {
//   return showDialog<Map<String, dynamic>>(
//     context: context,
//     builder: (context) {
//       return TexteditingboxContent(textBox: textBox);
//     },
//   );
// }

// class TexteditingboxContent extends StatefulWidget {
//   const TexteditingboxContent({super.key, required this.textBox});
//   final opdf.TextBox textBox;
//   @override
//   State<TexteditingboxContent> createState() => _TexteditingboxContentState();
// }

// class _TexteditingboxContentState extends State<TexteditingboxContent> {
//   late TextEditingController controller;
//   late double fontSize;
//   late Color selectedColor;
//   @override
//   void initState() {
//     super.initState();
//     controller = TextEditingController(text: widget.textBox.text);
//     fontSize = widget.textBox.fontSize;
//     selectedColor = widget.textBox.color ?? Colors.black;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text("Edit Text"),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: controller,
//             decoration: const InputDecoration(labelText: "Text"),
//           ),
//           Row(
//             children: [
//               const Text("Font Size:"),
//               Slider(
//                 value: fontSize,
//                 min: 8,
//                 max: 32,
//                 divisions: 24,
//                 label: fontSize.toInt().toString(),
//                 onChanged: (newValue) {
//                   fontSize = newValue;
//                   setState(() {});
//                 },
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text("Text Color:"),
//               IconButton(
//                 icon: Icon(Icons.color_lens, color: selectedColor),
//                 onPressed: () async {
//                   Color? pickedColor = await showColorPicker(
//                     context,
//                     selectedColor,
//                   );

//                   selectedColor = pickedColor;
//                   setState(() {});
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context, null),
//           child: const Text("Cancel"),
//         ),
//         TextButton(
//           onPressed:
//               () => Navigator.pop(context, {
//                 "text": controller.text,
//                 "fontSize": fontSize,
//                 "color": selectedColor,
//               }),
//           child: const Text("OK"),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:nextgen_pdf_editor/components/color_picker.dart';
import 'package:nextgen_pdf_editor/controllers/text_box_controller.dart'
    as opdf;

/// Unified dialog for Add OR Edit
Future<Map<String, dynamic>?> showTextEditDialog(
  BuildContext context, {
  opdf.TextBox? textBox, // nullable: for Add new text
}) async {
  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) {
      return TextEditDialogContent(textBox: textBox);
    },
  );
}

class TextEditDialogContent extends StatefulWidget {
  final opdf.TextBox? textBox; // null when adding new

  const TextEditDialogContent({super.key, this.textBox});

  @override
  State<TextEditDialogContent> createState() => _TextEditDialogContentState();
}

class _TextEditDialogContentState extends State<TextEditDialogContent> {
  late TextEditingController controller;
  late double fontSize;
  late Color selectedColor;

  @override
  void initState() {
    super.initState();

    // If textBox == null → we are ADDING NEW text
    controller = TextEditingController(text: widget.textBox?.text ?? "");
    fontSize = widget.textBox?.fontSize ?? 20;
    selectedColor = widget.textBox?.color ?? Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.textBox == null ? "Add Text" : "Edit Text"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "Text"),
          ),
          Row(
            children: [
              const Text("Font Size:"),
              Expanded(
                child: Slider(
                  value: fontSize,
                  min: 8,
                  max: 48,
                  divisions: 40,
                  label: fontSize.toInt().toString(),
                  onChanged: (value) {
                    setState(() => fontSize = value);
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text("Color: "),
              IconButton(
                icon: Icon(Icons.color_lens, color: selectedColor),
                onPressed: () async {
                  Color? picked = await showColorPicker(context, selectedColor);

                  if (picked != null) {
                    setState(() => selectedColor = picked);
                  }
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, {
              "text": controller.text,
              "color": selectedColor,
              "fontSize": fontSize,
            });
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}
