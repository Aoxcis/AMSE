import 'package:flutter/material.dart';
import 'package:hearthstone/pages/home/widgets/header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5F67EA),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                HeaderSection(),
              ],
            )
          ],
        )),
      bottomNavigationBar: NavigationBar(),
    );
  }
}


Widget NavigationBar() {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: [
      BottomNavigationBarItem(
        label: 'Home',
        icon: Icon(Icons.home),
      ),
      BottomNavigationBarItem(
        label: 'Liked',
        icon: Icon(Icons.favorite),
      ),
      BottomNavigationBarItem(
        label: 'About',
        icon: Icon(Icons.info),
      ),
    ],
  );
}