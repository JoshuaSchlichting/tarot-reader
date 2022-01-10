import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:tarot_reader/card_reading/screens/tarot_reading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String _appTitle = "Tarot Reader";

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Tarot Reader',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: _appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const AutoSizeText('Welcome to your mobile tarot card reading!'),
            ElevatedButton(
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TarotReadingScreen()))
                    },
                child: const Text('Draw 3!'))
          ],
        ),
      ),
    );
  }
}
