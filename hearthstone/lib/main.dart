import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:hearthstone/pages/home/home.dart';
import 'package:hearthstone/pages/details/details.dart';
import 'package:hearthstone/pages/info/InfoPage.dart';
import 'package:hearthstone/pages/favorites/FavoritesPage.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hearthstone',
        debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/info': (context) => InfoPage(),
        '/favorites': (context) => FavoritesPage(),
        '/details': (context) => DetailsPage(cardImagePath: '',cardId: '',),
      },
    );
  }
}