class TarotDataProcessor {
  late List<Map<String, dynamic>>? _data;

  TarotDataProcessor(Map<String, dynamic> data) {
    _data = data["cards"];
  }

  // Get's "card" in the context of "card" being the card map
  Map<String, dynamic> getCardData(String name) {
    if (_data == null) {
      return {};
    }
    return _data!.firstWhere((card) => card['name'] == name);
  }
}
