import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

sealed class SettingsItemType {}

class SettingsColor extends SettingsItemType {
  Color color;
  SettingsColor({required this.color});
}

enum SettingsItemKey { foregroundColor, backgroundColor }

extension SettingsItems on SettingsItemKey {
  SettingsItem get data => switch (this) {
    SettingsItemKey.foregroundColor => SettingsItem(
      itemType: SettingsColor(color: Colors.white),
      caption: "Text Color",
    ),
    SettingsItemKey.backgroundColor => SettingsItem(
      itemType: SettingsColor(color: Colors.black),
      caption: "Background Color",
    ),
  };
}

class SettingsItem {
  final SettingsItemType itemType;
  final String caption;

  const SettingsItem({required this.itemType, required this.caption});
}

class SettingsManager extends ChangeNotifier {
  late final SharedPreferences settingsStorage;
  Map<SettingsItemKey, SettingsItemType> properties = {};

  SettingsManager() {
    SharedPreferences.getInstance().then((instance) {
      settingsStorage = instance;

      for (var key in SettingsItemKey.values) {
        switch (key.data.itemType) {
          case SettingsColor(color: var fallback):
            properties[key] = SettingsColor(
              color: Color(
                settingsStorage.getInt(key.toString()) ?? fallback.toARGB32(),
              ),
            );
            break;
        }
      }

      notifyListeners();
    });
  }

  void _showErrorDialog(
    BuildContext? context,
    String error,
    StackTrace stackTrace,
  ) {
    if (context == null) return;

    showDialog(
      context: context,
      builder: (BuildContext newContext) => AlertDialog(
        title: const Text("Sorry"),
        content: Text(
          "We could not save your preferences due to the following error:"
          "\n$error"
          "\n\n\nStack Trace:"
          "\n$stackTrace",
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.of(newContext).pop(),
          ),
        ],
      ),
    );
  }

  void _debugPrintError(String error, StackTrace stackTrace) {
    debugPrint("Error:\n$error\n\n\n");
    debugPrint("Stack Trace:\n$stackTrace\n\n\n");
  }

  SettingsItemType get(BuildContext? context, SettingsItemKey key) {
    if (!SettingsItemKey.values.contains(key)) {
      _showErrorDialog(context, "Invalid key", StackTrace.current);
      _debugPrintError("Invalid key", StackTrace.current);
      return SettingsColor(color: Colors.pink);
    }

    // The fallback is given when the data is not yet loaded
    return properties[key] ?? key.data.itemType;
  }

  void set(BuildContext? context, SettingsItemKey key, SettingsItemType value) {
    if (!SettingsItemKey.values.contains(key)) {
      _showErrorDialog(context, "Invalid key", StackTrace.current);
      _debugPrintError("Invalid key", StackTrace.current);
      return;
    }

    switch (key.data.itemType) {
      case SettingsColor():
        if (value is! SettingsColor) {
          final error =
              "Invalid value type"
              "\nMust be: `SettingsColor` but found `${value.runtimeType}`";
          _showErrorDialog(context, error, StackTrace.current);
          _debugPrintError("Invalid key", StackTrace.current);
          return;
        }

        settingsStorage.setInt(key.toString(), value.color.toARGB32()).onError((
          error,
          stackTrace,
        ) {
          if (context != null && context.mounted) {
            _showErrorDialog(context, error.toString(), stackTrace);
          }
          _debugPrintError(error.toString(), stackTrace);
          return true;
        });

        break;
    }

    properties[key] = value;
    notifyListeners();
  }
}
