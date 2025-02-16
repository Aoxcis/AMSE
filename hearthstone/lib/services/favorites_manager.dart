class FavoritesManager {
  static final List<String> _favoriteCards = [];

  static void addFavorite(String cardImage) {
    if (!_favoriteCards.contains(cardImage)) {
      _favoriteCards.add(cardImage);
    }
    else {
      _favoriteCards.remove(cardImage);
    }
  }

  bool isFavorite(String cardImage) {
    return _favoriteCards.contains(cardImage);
  }

  static List<String> get favorites => _favoriteCards;
}