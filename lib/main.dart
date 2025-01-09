import 'package:convertidor_criptomoneda/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(). copyWith(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white
      ),

      home: HomeScreen()
    );
  }
}
