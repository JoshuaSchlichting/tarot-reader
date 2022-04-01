import 'dart:convert';

import 'package:flutter/material.dart';

class CardDetail {
  static const String name = "Name";
  static const String number = 'Number';
  static const String arcana = "Arcana";
  static const String suit = "Suit";
  static const String archetype = "Archetype";
  static const String hebrewAlphabet = "Hebrew Alphabet";
  static const String numerology = "Numerology";
  static const String elemental = "Elemental";
  static const String mythicalSpiritual = "Mythical/Spiritual";
}

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
  List? questionsToAsk;
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

  String toJson() {
    Map<String, dynamic> payloadMap = {
      'name': name,
      'number': number,
      'arcana': arcana,
      'suit': suit,
      'img': img,
      'fortunteTelling': fortunteTelling,
      'keywords': keywords,
      'meanings': meanings,
      'archetype': archetype,
      'hebrewAlphabet': hebrewAlphabet,
      'numerology': numerology,
      'elemental': elemental,
      'mythicalSpiritual': mythicalSpiritual,
      'questionsToAsk': questionsToAsk
    };
    for (var key in payloadMap.keys) {
      if (payloadMap[key] == null) {
        payloadMap.remove(key);
      }
    }
    return jsonEncode(payloadMap);
  }

  ListTile _getBasicDisplayTile(String title, String body) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      subtitle: Text(body,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  _getQuestionsToAsk() {
    if (questionsToAsk == null) {
      return Container();
    }
    List<Widget> questionsToAskList = [];
    for (var question in questionsToAsk!) {
      questionsToAskList
          .add(Align(alignment: Alignment.centerLeft, child: Text(question)));
      questionsToAskList.add(const Divider());
    }
    return ExpansionTile(
        title: const Text("Questions to ask",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        children: questionsToAskList);
  }

  ListView toPanelList() {
    List<Widget> list = [];
    list.add(_getBasicDisplayTile("Card name", name ?? ""));
    list.add(_getBasicDisplayTile("Number: " + number.toString(), ""));
    list.add(_getBasicDisplayTile(CardDetail.arcana, arcana ?? ""));
    list.add(_getBasicDisplayTile(CardDetail.suit, suit ?? ""));
    // list.add(_getBasicDisplayTile("Fortune telling", fortunteTelling ?? ""));
    // list.add(_getBasicDisplayTile("Keywords", keywords ?? ""));
    // list.add(_getBasicDisplayTile("Meanings", meanings ?? ""));
    list.add(_getBasicDisplayTile(CardDetail.archetype, archetype ?? ""));
    list.add(
        _getBasicDisplayTile(CardDetail.hebrewAlphabet, hebrewAlphabet ?? ""));
    list.add(_getBasicDisplayTile(CardDetail.numerology, numerology ?? ""));
    list.add(_getBasicDisplayTile(CardDetail.elemental, elemental ?? ""));
    list.add(_getBasicDisplayTile(
        CardDetail.mythicalSpiritual, mythicalSpiritual ?? ""));
    list.add(_getQuestionsToAsk());
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: list,
        )
      ],
    );
  }
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
        questionsToAsk: element["Questions to Ask"],
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
