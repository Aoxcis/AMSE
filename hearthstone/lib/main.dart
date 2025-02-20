import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:hearthstone/pages/home/home.dart';
import 'package:hearthstone/pages/details/details.dart';
import 'package:hearthstone/pages/info/InfoPage.dart';
import 'package:hearthstone/pages/favorites/FavoritesPage.dart';
import 'package:hearthstone/services/no_transitions_builder.dart';
import 'package:hearthstone/services/no_transition_navigator_observer.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hearthstone',
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