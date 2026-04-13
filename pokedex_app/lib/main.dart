import 'package:flutter/material.dart';
import 'pokemon_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      home: const PokemonScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}