import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../details/details.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysHide;
  List<String> cardUrls = [];
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    fetchCardUrls();
  }

  Future<void> fetchCardUrls() async {
    // Load the list of image assets from the assets folder
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    // Filter the assets to get only the card images
    final cardImagePaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .toList();

    setState(() {
      cardUrls = cardImagePaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    int startIndex = currentPage * 10;
    int endIndex = startIndex + 10;
    List<String> currentCards = cardUrls.sublist(
      startIndex,
      endIndex > cardUrls.length ? cardUrls.length : endIndex,
    );

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        animationDuration: const Duration(milliseconds: 1),
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/favorites');
              break;
            case 2:
              Navigator.pushNamed(context, '/info');
              break;
          }
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_border),
            label: 'Favorite',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.info),
            icon: Icon(Icons.info_outline),
            label: 'Info',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: currentCards.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            cardImagePath: currentCards[index],
                            cardId: currentCards[index].split('/').last,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Image.asset(
                        currentCards[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Optionally, print the error to the console
                          print('Failed to load image: $error');
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: currentPage > 0
                      ? () {
                    setState(() {
                      currentPage--;
                    });
                  }
                      : null,
                ),
                Text('Page ${currentPage + 1}'),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: endIndex < cardUrls.length
                      ? () {
                    setState(() {
                      currentPage++;
                    });
                  }
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}