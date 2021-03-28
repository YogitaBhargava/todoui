

import 'package:flutter/material.dart';
import 'package:todoin/todoui.dart';



void main() => runApp(MaterialApp( debugShowCheckedModeBanner: false,
    home: MyApp()));





class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TODO",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
      ).copyWith(

      ),
      home: todoui(),
    );
  }
}