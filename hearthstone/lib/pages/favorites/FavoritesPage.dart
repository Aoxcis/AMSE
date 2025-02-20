import 'package:flutter/material.dart';

import '../../services/favorites_manager.dart';
import '../details/details.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  var currentPageIndex = 1;
  final favorites = FavoritesManager.favorites;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysHide;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        animationDuration: Duration.zero, // Remove nav bar animation
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/favorites');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/info');
              break;
          }
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Hearthstone Info'),
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        automaticallyImplyLeading: false,
      ),

      body: Center(
        child: favorites.isEmpty
            ? const Text('Pas encore de favoris')
            : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      cardImagePath: favorites[index],
                      cardId: favorites[index].split('/').last,
                    ),
                  ),
                );
              },
              child: Card(
                child: Image.asset(
                  favorites[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
