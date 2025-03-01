import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldTime {
  String location;
  String time = '';
  String flag;
  String url;
  bool dayTime = true;
  WorldTime(this.location, this.flag, this.url);

  Future<void> getTime() async {
    try {
      final response = await http
          .get(Uri.parse(
              'https://timeapi.io/api/Time/current/zone?timeZone=$url'))
          ;
      Map? data;

      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
      } else {
        data = null;
      }
      print(" data: $data");
      DateTime timeNow = DateTime.parse(data!['dateTime']);
      dayTime = (timeNow.hour >= 6 && timeNow.hour < 20) ? true : false;
      time = timeNow.toString();
    } catch (e) {
      return getTime();
    }
  }
}
