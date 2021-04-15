import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class City extends StatelessWidget {
  City({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("The Weather For Today Is 35 Degree"),
          ElevatedButton(
              child: Text("Back"),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
