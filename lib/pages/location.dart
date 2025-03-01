import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:time_app/pages/home.dart';
import '../services/world_time.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => __LocationState();
}

class __LocationState extends State<Location> {
  bool load = false;
  List<WorldTime> locations = [
    WorldTime("Berlin", "DE.png", "Europe/Berlin"),
    WorldTime("Rome", "ITAL.png", "Europe/Rome"),
    WorldTime("Madrid", "SPAIN.png", "Europe/Madrid"),
    WorldTime("Algiers", "ALG.png", "Africa/Algiers"),
    WorldTime("Moscow", "RUSS.png", "Europe/Moscow"),
    WorldTime("Tokyo", "JAP.png", "Asia/Tokyo"),
    WorldTime("Seoul", "SK.png", "Asia/Seoul"),
  ];
  Future<void> updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    if (mounted) {
      timeNow = null;
      Navigator.pop(context, {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'dayTime': instance.dayTime,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('location'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 1.4, horizontal: 4),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 0,
                    child: ListTile(
                      onTap: () async {
                        setState(() {
                          load = true;
                        });
                        await updateTime(index);
                      },
                      title: Text(locations[index].location),
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/${locations[index].flag}"),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          load
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: SpinKitFadingCube(
                    color: Color.fromARGB(255, 255, 149, 163),
                    size: 30.0,
                    duration: Duration(seconds: 2),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
