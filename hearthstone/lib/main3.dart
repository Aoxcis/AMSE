import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}


class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(home: HomePage());
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        home: HomePage(),
        title: 'Hearthstone',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.teal,
          )
        )
      )
    );
  }
}

class MyAppState extends ChangeNotifier {
  var favourites = <cards>{};
  var current = cards();
  int currentFavouriteIndex = 0;

  void getNext(){
    notifyListeners();
  }

  void toggleFavorite() {
    if (favourites.contains(current)){
      favourites.remove(current);
    }
    else {
      favourites.add(current);
    }
    notifyListeners();
  }
}

class cards {
  var img = '';
  var name = '';
  // TODO potential info from api
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysHide;
  //List<cards> currentCards;
  int selectedIndex = 0;


  @override
  Widget build(BuildContext context) {

    Widget page:
      switch(selectedIndex) {
        case 0:
          page = HomePage();
          break;
        case 1:
          page = FavouritesPage();
          break;
        case 2:
          page = AboutPage();
          break;
        default:
          throw UnimplementedError('Invalid Index : $selectedIndex');
      }
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const <Widget> [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home'
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_outline),
            label: 'Liked',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.info),
            icon: Icon(Icons.info_outlined),
            label: 'About',
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
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
                                builder: (context) => CardDetailPage(
                                  cardImagePath: currentCards[index],
                                ),
                            ),
                        );
                      },
                    );
                  },
              ),
            )
          ],
        ),

      )
    );
  }
}

