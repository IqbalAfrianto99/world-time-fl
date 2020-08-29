import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {

    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      print('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // Get props from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      // Create datetime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Set time to string
//      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      isDaytime = false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print(e);
      time = 'Error occured';
      isDaytime = false;
    }

  }
}
