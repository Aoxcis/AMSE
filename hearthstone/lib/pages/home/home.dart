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
  NavigationDestinationLabelBehavior labelBehavior = NavigationDestinationLabelBehavior.alwaysHide;
  List<String> cardUrls = [];
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    fetchCardUrls();
  }

  Future<void> fetchCardUrls() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final cardImagePaths = manifestMap.keys.where((String key) => key.contains('images/')).toList();
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Hearthstone Info', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: currentCards.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
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
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        currentCards[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('Failed to load image: $error');
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
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
                Text('Page ${currentPage + 1}', style: Theme.of(context).textTheme.titleMedium),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NavigationBar(
          selectedIndex: currentPageIndex,
          animationDuration: Duration.zero,
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
      ),
    );
  }
}
