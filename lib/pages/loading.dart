import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void getTime() async {
    // make request
    Response response = await get('http://worldtimeapi.org/api/timezone/Europe/Berlin');
    Map data = jsonDecode(response.body);

    // get props from data
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);

    //create datetime object

    DateTime now = DateTime.parse(datetime);
    now.add(Duration(hours: int.parse(offset)));
    print(now);

  }

  @override
  void initState() {
    super.initState();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Loading'),
    );
  }
}
