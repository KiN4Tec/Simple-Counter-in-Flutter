import 'package:flutter/material.dart';

import '../providers/settings_manager.dart';
import '../widgets/settings_list_item.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    List<SettingsListItem> children = SettingsItemKey.values.map((key) {
      return SettingsListItem(itemKey: key);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(children: children),
    );
  }
}
