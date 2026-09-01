import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog extends StatelessWidget {
  final Color oldColor;
  final Function(Color) onColorChanged;

  const ColorPickerDialog({
    super.key,
    required this.oldColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    Color newColor = oldColor;

    return AlertDialog(
      title: const Text('Pick a color!'),

      content: MaterialPicker(
        pickerColor: oldColor,
        onColorChanged: (Color color) {
          newColor = color;
        },
      ),

      actions: <Widget>[
        ElevatedButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text('Confirm'),
          onPressed: () {
            onColorChanged(newColor);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
