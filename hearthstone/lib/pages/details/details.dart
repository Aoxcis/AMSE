import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

    // Find the card matching the cardId
    final dynamic cardData = jsonResponse.firstWhere(
          (card) => card['id'] == cardId,
      orElse: () => {},
    );

    // Convert the found map into a Map<String, dynamic>
    return Map<String, dynamic>.from(cardData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Information')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              cardImagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                print('Failed to load image: $error');
                return const Icon(Icons.error);
              },
            ),
            const SizedBox(height: 16),
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
                  return Text(cardDetails['name'] ?? 'Unknown card');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
