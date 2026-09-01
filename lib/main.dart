import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/settings_manager.dart';

import 'pages/home.dart';

void main() {
  runApp(const SimpleCounterApp());
}

class SimpleCounterApp extends StatelessWidget {
  const SimpleCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsManager>(
      create: (context) => SettingsManager(),
      child: MaterialApp(
        title: 'Simple Counter',
        themeMode: ThemeMode.system,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        home: const HomePage(),
      ),
    );
  }
}
