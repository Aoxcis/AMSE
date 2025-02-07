import 'package:flutter/material.dart';
import 'package:hearthstone/pages/home/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hearthstone',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
