import 'package:flutter/material.dart';
import 'pokemon_card.dart';
import 'battle_panel.dart';
import 'move_list.dart';

class PokemonScreen extends StatelessWidget {
  const PokemonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gyarados')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            PokemonCard(),
            SizedBox(height: 16),
            BattlePanel(),
            SizedBox(height: 16),
            MoveList(),
          ],
        ),
      ),
    );
  }
}