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

  Future<String> makeRequest() async {
    var response = await http.get(
        Uri.encodeFull('http://shibe.online/api/cats'),
        headers: {"Accept": "application/json"});
    var extractdata = json.decode(response.body);

    setState(() {
      _url = extractdata[0];
    });
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
      floatingActionButton: FloatingActionButton(
        onPressed: makeRequest,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
