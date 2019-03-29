import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var url =
      'https://cdn.shibe.online/cats/7e788e792e7f0181a0d7716e2ffa0b5fc9ecfc0c.jpg';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nekinu',
      home: Scaffold(
        body: Container(
          child: Image.network(
            url,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
