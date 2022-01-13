class TarotCardData {
  String? name;
  int? number;
  String? arcana;
  String? suit;
  String? img;
  List<dynamic>? fortunteTelling;
  List<dynamic>? keywords;
  var meanings;
  String? archetype;
  String? hebrewAlphabet;
  String? numerology;
  String? elemental;
  String? mythicalSpiritual;
  List<String>? questionsToAsk;
  TarotCardData(
      {this.name,
      this.number,
      this.arcana,
      this.suit,
      this.img,
      this.fortunteTelling,
      this.keywords,
      this.meanings,
      this.archetype,
      this.hebrewAlphabet,
      this.numerology,
      this.elemental,
      this.mythicalSpiritual,
      this.questionsToAsk});
}

class TarotDataProcessor {
  List<TarotCardData> _data = [];

  TarotDataProcessor(Map<String, dynamic> data) {
    List cardObjs = data["cards"] as List;
    for (var element in cardObjs) {
      _data.add(TarotCardData(
        name: element["name"],
        number: int.parse(element["number"]),
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
