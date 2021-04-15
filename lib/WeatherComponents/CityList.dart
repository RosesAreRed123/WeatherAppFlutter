import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class CityList extends StatefulWidget {
  CityList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CityListState createState() => _CityListState();
}

class _CityListState extends State<CityList> {
  var _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Enter New City"),
          TextField(
            controller: _textController,
          ),
          ElevatedButton(
              child: Text("Enter"),
              onPressed: () {
                Navigator.pop(context, _textController.text);
              }),
          ElevatedButton(
              child: Text("Return"),
              onPressed: () {
                Navigator.pop(context, null);
              })
        ],
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  final String value;

  NextPage({Key key, this.value}) : super(key: key);
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("New City List"),
      ),
      body: new Text("${widget.value}"),
    );
  }
}
