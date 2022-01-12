class TarotCardData {
  late final String name;
  late final int number;
  late final String arcana;
  late final String suit;
  late final String img;
  late final List<String> fortunteTelling;
  late final List<String> keywords;
  late final List<Map<String, List<String>>> meanings;
  late final String archetype;
  late final String hebrewAlphabet;
  late final String numerology;
  late final String elemental;
  late final String mythicalSpiritual;
  late final List<String> questionsToAsk;
  TarotCardData(
      {required this.name,
      required this.number,
      required this.arcana,
      required this.suit,
      required this.img,
      required this.fortunteTelling,
      required this.keywords,
      required this.meanings,
      required this.archetype,
      required this.hebrewAlphabet,
      required this.numerology,
      required this.elemental,
      required this.mythicalSpiritual,
      required this.questionsToAsk});
}

class TarotDataProcessor {
  late List<TarotCardData> _data;

  TarotDataProcessor(Map<String, dynamic> data) {
    List<Map> cardObjs = data["cards"] as List<Map>;
    for (var element in cardObjs) {
      _data.add(TarotCardData(
        name: element["name"],
        number: element["number"],
        arcana: element["arcana"],
        suit: element["suit"],
        img: element["img"],
        fortunteTelling: element["fortune_telling"],
        keywords: element["keywords"],
        meanings: element["meanings"],
        archetype: element["Archetype"],
        hebrewAlphabet: element["Hebrew Alphabet"],
        numerology: element["Numerology"],
        elemental: element["Elemental"],
        mythicalSpiritual: element["Mythical/Spiritual"],
        questionsToAsk: element["Questions To Ask"],
      ));
    }
  }

  List<TarotCardData> get availableImages {
    return _data;
  }

  // Get's "card" in the context of "card" being the card map
  TarotCardData getCardData(String name) {
    return _data.firstWhere((card) => card.name == name);
  }
}
