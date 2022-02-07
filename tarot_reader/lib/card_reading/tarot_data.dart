import 'dart:convert';

import 'package:flutter/material.dart';

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
    return jsonEncode(payloadMap);
  }

  ListTile _getBasicDisplayTile(String title, String body) {
    return ListTile(
      title: Text(title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      subtitle: Text(body,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  _getQuestionsToAsk() {
    if (questionsToAsk == null) {
      return Container();
    }
    List<Widget> questionsToAskList = [];
    for (var question in questionsToAsk!) {
      questionsToAskList.add(Text(question,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
    }
    return ExpansionTile(
        title: const Text("Questions to ask"), children: questionsToAskList);
  }

  ListView toPanelList() {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: [
            _getBasicDisplayTile("Card name", name ?? ""),
            _getBasicDisplayTile("Number: " + number.toString(), ""),
            _getBasicDisplayTile("Arcana", arcana ?? ""),
            _getBasicDisplayTile("Suit", suit ?? ""),
            // _getBasicDisplayTile("Fortune telling", fortunteTelling ?? ""),
            // _getBasicDisplayTile("Keywords", keywords ?? ""),
            // _getBasicDisplayTile("Meanings", meanings ?? ""),
            _getBasicDisplayTile("Archetype", archetype ?? ""),
            _getBasicDisplayTile("Hebrew alphabet", hebrewAlphabet ?? ""),
            _getBasicDisplayTile("Numerology", numerology ?? ""),
            _getBasicDisplayTile("Elemental", elemental ?? ""),
            _getBasicDisplayTile("Mythical/Spiritual", mythicalSpiritual ?? ""),
            _getQuestionsToAsk(),
            // _getBasicDisplayTile("Questions to ask", questionsToAsk ?? ""),

            // ExpansionTile(
            //   initiallyExpanded: true,
            //   title: Text(name?.toUpperCase() ?? '',
            //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            //   children: <Widget>[
            //     ListTile(title: Text('Title of the item')),
            //     ListTile(
            //       title: Text('Title of the item2'),
            //     )
            //   ],
            // )
          ],
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
