import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home.dart';
import 'pages/loading.dart';
import 'pages/location.dart';

bool isNight = false;
int index=0;
Future<void> main() async {
  isNight = (DateTime.now().hour >= 21 || DateTime.now().hour < 5);

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  return runApp(
    MaterialApp(
      theme: ThemeData(brightness: isNight? Brightness.dark: Brightness.light),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => loadingPage(),
        '/home': (context) => Home(),
        '/location': (context) => Location(),
      },
    ),
  );
}
