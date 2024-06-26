class Cartas {
  bool success;
  String deckId;
  List<Card> cards;
  int remaining;

  Cartas({
    required this.success,
    required this.deckId,
    required this.cards,
    required this.remaining,
  });

  static Future<Cartas> fromJson(jsonDecode) {
    return Future.value(Cartas(
      success: jsonDecode['success'],
      deckId: jsonDecode['deck_id'],
      cards: List<Card>.from(jsonDecode['cards'].map((x) => Card.fromJson(x))),
      remaining: jsonDecode['remaining'],
    ));
  }
}

class Card {
  String code;
  String image;
  Images images;
  String value;
  String suit;

  Card({
    required this.code,
    required this.image,
    required this.images,
    required this.value,
    required this.suit,
  });

  static fromJson(x) {
    return Card(
      code: x['code'],
      image: x['image'],
      images: Images(
        svg: x['images']['svg'],
        png: x['images']['png'],
      ),
      value: x['value'],
      suit: x['suit'],
    );
  }
}

class Images {
  String svg;
  String png;

  Images({
    required this.svg,
    required this.png,
  });
}
