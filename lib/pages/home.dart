import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Timer? _timer;
DateTime? timeNow;

class _HomeState extends State<Home> {
  Map data = {};
  String timeTheme = "";
  @override
  void initState() {
    super.initState();
  }

  Future<void> fixTime() async {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        timeNow = timeNow?.add(Duration(seconds: 2));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      data = data.isEmpty
          ? ModalRoute.of(context)!.settings.arguments as Map
          : data;
    } else {
      data = {};
    }

    timeTheme = data['dayTime'] ? "morning.jpg" : "night.jpg";
    timeNow ??= DateTime.parse(data['time']);
    fixTime();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/$timeTheme"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 140, 0, 0),
          child: Column(
            children: [
              const SizedBox(height: 7),
              TextButton.icon(
                onPressed: () async {
                  dynamic update =
                      await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = update as Map;
                    timeNow = DateTime.parse(data['dateTime']);
                  });
                  fixTime();
                },
                label: const Text('change location'),
                icon: const Icon(
                  Icons.edit_location_outlined,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                ),
              ),
              const SizedBox(height: 27),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      letterSpacing: 2,
                      fontFamily: "Nunito",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              Text(
                DateFormat.jm().format(timeNow!),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 67,
                  fontFamily: "Nunito",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
