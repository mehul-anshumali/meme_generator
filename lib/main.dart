import 'package:flutter/material.dart';
import 'package:meme_app/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Meme Generator',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
