import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
import '../../services/favorites_manager.dart';

class DetailsPage extends StatelessWidget {
  final String cardImagePath;
  final String cardId;

  const DetailsPage({
    Key? key,
    required this.cardImagePath,
    required this.cardId,
  }) : super(key: key);

  Future<Map<String, dynamic>> fetchCardDetails() async {
    final String response = await rootBundle.loadString('api/filtered_cards.json');
    final List<dynamic> jsonResponse = jsonDecode(response);
    String newCardId = cardId.substring(0, cardId.length - 4);
    final dynamic cardData = jsonResponse.firstWhere(
          (card) => card['id'] == newCardId,
      orElse: () => {},
    );
    return Map<String, dynamic>.from(cardData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Card Information', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 4,
      ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                cardImagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  print('Failed to load image: $error');
                  return const Icon(Icons.error, size: 100);
                },
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder<Map<String, dynamic>>(
              future: fetchCardDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}', style: Theme.of(context).textTheme.bodyLarge));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No card details available', style: Theme.of(context).textTheme.bodyLarge));
                } else {
                  final cardDetails = snapshot.data!;
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cardDetails['name'] ?? '',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cardDetails['flavor'] ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                            Text(
                              cardDetails['text'],
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          Text(
                            cardDetails['collectible'] == true
                                ? 'Collectionnable'
                                : 'Non Collectionnable',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cardDetails['type'] != null
                                ? 'Type: ${cardDetails['type']}'
                                : 'Pas de Type',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cardDetails['faction'] != null
                                ? 'Faction: ${cardDetails['faction']}'
                                : 'Pas de Faction',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
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
