import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
import 'package:hearthstone/services/favorites_manager.dart';

import '../../services/favorites_manager.dart';

class DetailsPage extends StatelessWidget {
  final String cardImagePath;
  final String cardId;


  DetailsPage({
    Key? key,
    required this.cardImagePath,
    required this.cardId,
  }) : super(key: key);

  Future<Map<String, dynamic>> fetchCardDetails() async {
    var newCardId = '';
    final String response = await rootBundle.loadString('api/filtered_cards.json');
    final List<dynamic> jsonResponse = jsonDecode(response);

    // Log the jsonResponse and cardId for debugging
    //log('jsonResponse: $jsonResponse');
    log('cardId: $cardId');
    newCardId = cardId.substring(0, cardId.length - 4);

    // Find the card matching the cardId
    final dynamic cardData = jsonResponse.firstWhere(
          (card) => card['id'] == newCardId,
      orElse: () => {},
    );
    log('cardData: $cardData');

    // Convert the found map into a Map<String, dynamic>
    return Map<String, dynamic>.from(cardData);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Information')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FavoritesManager.addFavorite(cardImagePath);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Added to favorites!')),
          );
        },
        child: FavoritesManager().isFavorite(cardImagePath)
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border),
      ),
      body: Center(
        child: ListView(
          children: [
            Image.asset(
              cardImagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                print('Failed to load image: $error');
                return const Icon(Icons.error);
              },
            ),
            const SizedBox(height: 8),
            FutureBuilder<Map<String, dynamic>>(
              future: fetchCardDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No card details available');
                } else {
                  final cardDetails = snapshot.data!;
                  return Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          cardDetails['name'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              cardDetails['flavor'],
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Collectable : ${cardDetails['collectible']}',
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'rarity : ${cardDetails['rarity']}',
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 8),
                            if (cardDetails['faction'] != null)
                              Text(
                                'Faction : ${cardDetails['faction']}',
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.left,
                              ),
                            if (cardDetails['faction'] == null)
                              Text(
                                'Pas de Faction',
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.left,
                              ),
                          ],
                        ),
                      ],
                    ),
                  );

                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
