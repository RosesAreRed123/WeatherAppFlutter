import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:weather/WeatherComponents/CityListWeather.dart';

// ignore: must_be_immutable
class CityList extends StatefulWidget {
  final List<String> City1;
  CityList({Key key, this.title, this.City1}) : super(key: key);
  final String title;

  @override
  _CityListState createState() => _CityListState();
}

class _CityListState extends State<CityList> {
  var _textController = new TextEditingController();
  bool isError = false;
  bool isExist = false;
  static Future<int> getWeather(String city) async {
    http.Response response = await http.get(Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'q': city,
        'units': 'metric',
        'appid': '9bd7406cc261f48f24bbd2bc6d684de9',
      },
    ));
    print(response.statusCode);

    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 0.0)),
          Text(
            'Enter New City',
            style: new TextStyle(color: Colors.black, fontSize: 25.0),
          ),
          Padding(padding: EdgeInsets.only(top: 50.0)),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextFormField(
              decoration: new InputDecoration(
                labelText: "Enter City",
                fillColor: Colors.white,
                focusedBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide:
                      new BorderSide(color: isError ? Colors.red : Colors.blue),
                ),
                //fillColor: Colors.green
              ),
              controller: _textController,
            ),
          ),
          isError
              ? Text(
                  "Please Input City",
                  style: new TextStyle(color: Colors.red, fontSize: 20.0),
                )
              : Container(),
          isExist
              ? Text(
                  "City Exists",
                  style: new TextStyle(color: Colors.red, fontSize: 20.0),
                )
              : Container(),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black)),
              child: Text("Enter",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () async {
                if (_textController.text.isEmpty) {
                  setState(() {
                    isError = true;
                    isExist = false;
                  });
                } else if (widget.City1.contains(_textController.text)) {
                  setState(() {
                    isExist = true;
                    isError = false;
                  });
                } else {
                  if (await getWeather(_textController.text) == 404) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('City not found'),
                        duration: Duration(seconds: 10),
                      ),
                    );
                  } else {
                    Navigator.pop(context, _textController.text);
                  }
                }
              }),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black)),
              child: Text("Return",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(context, null);
              })
        ],
      ),
    );
  }
}
