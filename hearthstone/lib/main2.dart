import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
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
    // Example URLs, replace with actual API call if needed
    List<String> urls = List.generate(100, (index) {
      // Compute a card number between 1 and 10
      final cardNumber = ((index % 10) + 1).toString().padLeft(3, '0'); // pads numbers less than 10 with a leading zero
      return 'https://art.hearthstonejson.com/v1/render/latest/frFR/256x/EX1_$cardNumber.png';
    });

    setState(() {
      cardUrls = urls;
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
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
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
            label: 'favorite',
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
                  return Card(
                    child: Image.network(
                      currentCards[index],
                      errorBuilder: (context, error, stackTrace) {
                        // Optionally, print the error to the console
                        print('Failed to load image: $error');
                        return const Icon(Icons.error);
                      },
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