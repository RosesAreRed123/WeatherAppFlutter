import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/City.dart';
import 'package:weather/WeatherComponents/CityList.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  List<String> City1;

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      City1 = prefs.getStringList("Array");
    });
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i in City1)
                  Row(
                    children: [
                      TextButton(
                        child: Text(i),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => City(title: i)));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          removeCityList(i);
                        },
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
                  builder: (context) => CityList(title: 'City List')),
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
