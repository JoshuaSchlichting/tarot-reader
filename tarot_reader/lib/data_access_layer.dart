import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:riverpod/riverpod.dart';

final imagePathProvider = FutureProvider<List<String>>((ref) async {
  final String manifestContent =
      await rootBundle.loadString('AssetManifest.json');

  final Map<String, dynamic> manifestMap = json.decode(manifestContent);

  final imagePaths = manifestMap.keys
      .where((String key) => key.contains('assets/images/decks/marseille/'))
      .toList();

  return imagePaths;
});
