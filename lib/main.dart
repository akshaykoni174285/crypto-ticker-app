import 'package:crypto_tracker_app/price_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF5E81AC),
        scaffoldBackgroundColor: Color(0xFF81A1C1),
      ),
      home: PriceScreen(),
    );
  }
}
