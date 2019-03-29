import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nekinu',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _url =
      'https://cdn.shibe.online/cats/7e788e792e7f0181a0d7716e2ffa0b5fc9ecfc0c.jpg';

  var _category = 'cat';
  var _apiURL = 'http://shibe.online/api/cats';

  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(_apiURL), headers: {"Accept": "application/json"});
    var extractdata = json.decode(response.body);

    if (_category == 'cat') {
      setState(() {
        _url = extractdata[0];
      });
    } else if (_category == 'dog') {
      setState(() {
        _url = extractdata[0]["url"];
      });
    }
  }

  void changeCategory() {
    if (_category == 'cat') {
      setState(() {
        _category = 'dog';
        _apiURL = 'https://api.thedogapi.com/v1/images/search';
      });
      makeRequest();
    } else if (_category == 'dog') {
      setState(() {
        _category = 'cat';
        _apiURL = 'http://shibe.online/api/cats';
      });
      makeRequest();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.network(
          _url,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
      backgroundColor: Colors.black,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.repeat),
              onPressed: changeCategory,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: null,
              child: Icon(
                Icons.refresh,
              ),
              backgroundColor: Colors.redAccent,
              onPressed: makeRequest,
            ),
          ),
        ],
      ),
    );
  }
}
