import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_manager.dart';
import 'color_picker_button.dart';

class SettingsItemActuator extends StatelessWidget {
  final SettingsItemKey itemKey;

  const SettingsItemActuator({
    super.key,
    required this.itemKey,
  });

  @override
  Widget build(BuildContext context) {
    switch (itemKey.data.itemType) {
      case SettingsColor():
        return ColorPickerButton(
          currentColor: (Provider.of<SettingsManager>(context)
              .get(context, itemKey) as SettingsColor).color,
          onColorChanged: (newColor) => Provider.of<SettingsManager>(
            context,
            listen: false,
          ).set(context, itemKey, SettingsColor(color: newColor)),
        );
    }
  }
}
