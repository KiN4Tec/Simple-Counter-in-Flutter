import 'package:flutter/material.dart';

import 'color_picker_dialog.dart';

class ColorPickerButton extends StatelessWidget {
  final Function(Color) onColorChanged;
  final Color currentColor;

  const ColorPickerButton({
    super.key,
    required this.onColorChanged,
    required this.currentColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: currentColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),

      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return ColorPickerDialog(
            oldColor: currentColor,
            onColorChanged: onColorChanged,
          );
        },
      ),
    );
  }
}
