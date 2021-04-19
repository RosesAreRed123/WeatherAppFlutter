import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/City.dart';
import 'package:weather/WeatherComponents/CityList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/WeatherComponents/CityListWeather.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  WeatherToday createState() => WeatherToday();
}

class WeatherToday extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  List<String> City1 = [];

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    City1 = prefs.getStringList("Array");
    if (City1 == null) {
      City1 = [];
    }
    setState(() {});
  }

  removeCityList(String cityName) {
    City1.removeWhere((element) => element.contains(cityName));
    removePreference();
  }

  removePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("Array");

    setState(() {
      prefs.setStringList("Array", City1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Weather Today")),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i in City1)
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          // color: Colors.amber,
                          height: 100,
                        ),
                      ),
                      Container(
                        child: TextButton(
                          child: Text(
                            i,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CityListWeather(title: i)));
                          },
                        ),
                        // color: Colors.blue,
                        height: 70,
                        width: 100,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              removeCityList(i);
                            },
                          ),
                          // color: Colors.amber,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            final result = await Navigator.push(
              context,
              // Create the SelectionScreen in the next step.
              MaterialPageRoute(
                  builder: (context) => CityList(
                        title: 'City List',
                        City1: City1,
                      )),
            );
            if (result != null) {
              City1.add(result);
              prefs.setStringList("Array", City1);
              print(City1);
              setState(() {});
            }
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}
