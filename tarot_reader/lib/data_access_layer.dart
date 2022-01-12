import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:riverpod/riverpod.dart';

final imagePathProvider = FutureProvider<List<String>>((ref) async {
  final String manifestContent =
      await rootBundle.loadString('AssetManifest.json');

  final Map<String, dynamic> manifestMap = json.decode(manifestContent);

  final imagePaths = manifestMap.keys
      .where((String key) => key.contains('assets/images/decks/rider-waite/'))
      .toList();

  return imagePaths;
});

final cardDataProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final String jsonPayload =
      await rootBundle.loadString('assets/images/decks/tarot-images.json');

  Map<String, dynamic> data = json.decode(jsonPayload);
  return data;
});
