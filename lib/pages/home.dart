import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_manager.dart';

import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 1;

  void incrementCounter() {
    setState(() {
      counter < 9 ? counter++ : counter = 1;
    });
  }

  void resetCounter() {
    setState(() {
      counter = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.sizeOf(context).shortestSide;
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    double fontSize;
    if (shortestSide == height) {
      fontSize = height;
    } else {
      fontSize = width * 1.5;
      if (fontSize > height) {
        fontSize = height;
      }
    }

    Color foregroundColor = (Provider.of<SettingsManager>(
      context,
    ).get(context, SettingsItemKey.foregroundColor) as SettingsColor).color;
    Color backgroundColor = (Provider.of<SettingsManager>(
      context,
    ).get(context, SettingsItemKey.backgroundColor) as SettingsColor).color;

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        elevation: 0,
        child: const Icon(Icons.settings),
        onPressed: () => Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const SettingsPage(),
          ),
        ),
      ),

      body: InkWell(
        onTap: incrementCounter,
        onLongPress: resetCounter,
        splashColor: foregroundColor.withAlpha(50),
        child: Center(
          child: Text(
            "$counter",
            style: TextStyle(
              color: foregroundColor,
              fontWeight: FontWeight.w400,
              fontSize: fontSize,
              height: 1.0,
            ),
            textScaler: TextScaler.noScaling,
            maxLines: 1,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
