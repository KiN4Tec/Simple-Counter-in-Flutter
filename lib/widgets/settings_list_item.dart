import 'package:flutter/material.dart';

import '../providers/settings_manager.dart';

import '../widgets/settings_item_actuator.dart';

class SettingsListItem extends StatelessWidget {
  final SettingsItemKey itemKey;

  const SettingsListItem({
    super.key,
    required this.itemKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(23),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(itemKey.data.caption),
          SettingsItemActuator(itemKey: itemKey),
        ],
      ),
    );
  }
}