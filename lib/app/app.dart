import 'package:flutter/material.dart';
import 'package:pomodoro_timer/screen/home_pages/home.dart';
import 'package:pomodoro_timer/screen/loading_pages/loading.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
