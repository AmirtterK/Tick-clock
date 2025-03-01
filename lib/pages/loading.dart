// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import '../services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loadingPage extends StatefulWidget {
  const loadingPage({super.key});

  @override
  State<loadingPage> createState() => _loadingPageState();
}

class _loadingPageState extends State<loadingPage> {
  void setupWorldTime() async {
    WorldTime instance = WorldTime('Berlin', 'germany.png', 'Europe/Berlin');
    await instance.getTime();

    if (mounted) {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'dayTime': instance.dayTime,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitFadingCube(
          color: Color.fromARGB(255, 255, 149, 163),
          size: 55.0,
          duration: Duration(seconds: 2),
        ),
      ),
    );
  }
}
