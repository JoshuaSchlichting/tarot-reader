import 'dart:math' as math;
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarot_reader/data_access_layer.dart' show cardDataProvider;
import 'package:tarot_reader/card_reading/tarot_data.dart'
    show TarotCardData, TarotDataProcessor;
import 'package:flutter/material.dart';

class TarotReadingScreen extends ConsumerWidget {
  const TarotReadingScreen({Key? key}) : super(key: key);

  List<TarotCardData> _getCardData(WidgetRef ref) {
    AsyncValue<Map<String, dynamic>> data = ref.watch(cardDataProvider);

    Map<String, dynamic> rawCardData = data.when(
      data: (data) => data,
      error: (error, stackTrace) => {},
      loading: () => {},
    );
    return TarotDataProcessor(rawCardData).availableImages;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: definitely want to wait here before calling get card data
    List<TarotCardData> availableCards = _getCardData(ref);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarot Reading'),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(children: [
          // CircularProgressIndicator(),
          ...TarotCardFactory(
                  deckType: "marseille", availableCardData: availableCards)
              .getCards(3),
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

class Card extends ConsumerWidget {
  final Widget image;
  final String title;
  const Card({Key? key, required this.image, required this.title})
      : super(key: key);

  String getCardText(String cardName, WidgetRef ref) {
    AsyncValue<Map<String, dynamic>> jsonPayload = ref.watch(cardDataProvider);

    TarotCardData data = TarotDataProcessor(jsonPayload.when(
      data: (data) => data,
      loading: () => {},
      error: (error, stackTrance) => {},
    )).getCardData(cardName);
    return data.toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Text(getCardText(title, ref))))
            },
        child: Container(
          child: image,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(50))),
        ));
  }
}

class TarotCardFactory {
  final String deckType;
  List<TarotCardData> availableCardData = [];
  List<TarotCardData> _alreadyDrawn = [];

  TarotCardFactory({required this.deckType, required this.availableCardData});

  List<Card> getCards(int numberOfCards) {
    debugPrint(
        "Getting $numberOfCards card" + ((numberOfCards == 1) ? '' : 's'));

    final List<Card> cards = [];
    for (int i = 0; i < numberOfCards; i++) {
      double rotateAngle = 0;
      if (Random().nextBool()) {
        rotateAngle = 91.11;
      }

      cards.add(Card(
        image:
            Transform.rotate(child: _getRandomCardImage(), angle: rotateAngle),
        title: "TODO: get card titles",
      ));
    }
    _alreadyDrawn = [];
    return cards;
  }

  TarotCardData _getRandomCardData() {
    while (true) {
      int randomIndex = math.Random().nextInt(availableCardData.length);
      TarotCardData randomCard = availableCardData[randomIndex];

      if (!_alreadyDrawn.contains(randomCard)) {
        _alreadyDrawn.add(randomCard);
        return randomCard;
      }
    }
  }

  Widget _getRandomCardImage() {
    String cardName = _getRandomCardData().name;

    return Image(image: AssetImage(cardName));
  }
}
