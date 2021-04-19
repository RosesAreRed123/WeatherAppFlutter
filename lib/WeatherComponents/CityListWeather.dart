import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CityListWeather extends StatefulWidget {
  final String title;

  const CityListWeather({Key key, this.title}) : super(key: key);

  @override
  _CityListWeather createState() => _CityListWeather();
}

class _CityListWeather extends State<CityListWeather> {
  var temp;
  var name;
  var humidity;
  var description;

  @override
  void initState() {
    super.initState();
    this.getWeather(widget.title);
  }

  Future getWeather(String city) async {
    http.Response response = await http.get(Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'q': city,
        'units': 'metric',
        'appid': '9bd7406cc261f48f24bbd2bc6d684de9',
      },
    ));

    var results = jsonDecode(response.body);
    print(results);
    setState(() {
      this.temp = results['main']['temp'];
      this.name = results['name'];
      this.humidity = results['main']['humidity'];
      this.description = results['weather'][0]['main'];
    });
  }

  AssetImage decideWeatherImage() {
    if (this.description == 'Haze') {
      return AssetImage('assets/cloud.png');
    } else {
      return AssetImage('assets/sun.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CircleAvatar(
          //   radius: 80,
          //   backgroundImage: AssetImage('assets/kirito.gif'),
          // ),
          Expanded(
              flex: 2,
              child: Image(
                image: decideWeatherImage(),
                width: 150,
                height: 100,
              )),
          // Image(image: AssetImage('assets/sun.png')),
          // Expanded(
          //   flex: 2,
          //   child: Container(
          //     // color: Colors.amber,
          //     height: 100,
          //   ),
          // ),
          Container(
            child: Text(
              "The Weather For Today Is " +
                  temp.toString() +
                  " Degree \n\n" +
                  "Humidity " +
                  humidity.toString() +
                  "  Percent \n\n" +
                  "Description " +
                  description.toString(),
              textAlign: TextAlign.center,
            ),

            // color: Colors.blue,
            height: 300,
            width: 500,
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black)),
                  child: Text("Back",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              // color: Colors.amber,
              height: 100,
              width: 150,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // color: Colors.amber,
              height: 10,
              width: 150,
            ),
          ),
          // ElevatedButton(
          //     child: Text("Back"),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     })
        ],
      ),
    );
  }
}
