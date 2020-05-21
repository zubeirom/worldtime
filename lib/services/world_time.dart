import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time; // time in that location
  String flag; // url to an asset flag icon
  String url; // api url world time api
  bool isDayTime; // true or false depending on daytime

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // make request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // get props from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'could not get time data';
    }
  }
}
