import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:tp1/pages/home/home.dart';
import 'package:tp1/pages/details/details.dart';
import 'package:tp1/pages/info/InfoPage.dart';
import 'package:tp1/pages/favorites/FavoritesPage.dart';
import 'package:tp1/services/no_transitions_builder.dart';
import 'package:tp1/services/no_transition_navigator_observer.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hearthstone Info',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: NoTransitionsBuilder(),
            TargetPlatform.iOS: NoTransitionsBuilder(),
          },
        ),
      ),
      navigatorObservers: [NoTransitionNavigatorObserver()],
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/info': (context) => const InfoPage(),
        '/favorites': (context) => const FavoritesPage(),
        '/details': (context) => DetailsPage(cardImagePath: '', cardId: ''),
      },
    );
  }
}