import 'package:flutter/material.dart';
import 'package:security/caeser_cipher.dart';
import 'package:security/home_screen.dart';
import 'package:security/mono_alphabetic_cipher.dart';
import 'package:security/play_fair_cipher.dart';
import 'package:security/rail_fence_cipher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme:ThemeData.dark(),
      home: HomeScreen()
    );
  }
}


