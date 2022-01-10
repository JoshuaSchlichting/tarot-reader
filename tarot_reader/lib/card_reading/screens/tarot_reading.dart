import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarot_reader/data_access_layer.dart';
import 'package:flutter/material.dart';

class TarotReadingScreen extends ConsumerWidget {
  const TarotReadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<String>> availableImageNames = ref.watch(imagePathProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarot Reading'),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(children: [
          // CircularProgressIndicator(),
          ...TarotCardFactory(
              deckType: "marseille",
              availableImageNames: availableImageNames.when(
                data: (data) => data,
                loading: () => [
                  // Temp assets for during load
                  "assets/images/decks/marseille/a01.jpg",
                  "assets/images/decks/marseille/a02.jpg",
                  "assets/images/decks/marseille/a03.jpg",
                ],
                error: (error, stackTrance) => [],
              )).getCards(3),
        ])),
      ),
    );
  }
}

class CardDisplay extends StatelessWidget {
  final List<Card>? cards;
  const CardDisplay({
    Key? key,
    required this.cards,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: cards!);
  }
}

class Card extends StatelessWidget {
  final Image image;
  final String title;
  const Card({Key? key, required this.image, required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: image,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(50))),
    );
  }
}

class TarotCardFactory {
  final String deckType;
  List<String> availableImageNames = [];
  List<String> _alreadyDrawn = [];

  TarotCardFactory({required this.deckType, required this.availableImageNames});

  List<Card> getCards(int numberOfCards) {
    debugPrint(
        "Getting $numberOfCards card" + ((numberOfCards == 1) ? '' : 's'));

    final List<Card> cards = [];
    for (int i = 0; i < numberOfCards; i++) {
      cards.add(Card(
        image: _getRandomCardImage(),
        title: "TODO: get card titles",
      ));
    }
    _alreadyDrawn = [];
    return cards;
  }

  String _getRandomCardFilename() {
    if (availableImageNames.isEmpty) {
      return "";
    }
    while (true) {
      int randomIndex = math.Random().nextInt(availableImageNames.length);
      String randomCardName = availableImageNames[randomIndex];

      if (!_alreadyDrawn.contains(randomCardName)) {
        _alreadyDrawn.add(randomCardName);
        return randomCardName;
      }
    }
  }

  Image _getRandomCardImage() {
    String cardName = _getRandomCardFilename();
    return Image(image: AssetImage(cardName));
  }
}
