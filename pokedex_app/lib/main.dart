// Eliseu Pereira Gili - 25009281
// Pietra Façanha Bortolato - 25002436

import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}