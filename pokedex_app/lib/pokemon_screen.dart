import 'package:flutter/material.dart';
import 'pokemon.dart';
import 'pokemon_card.dart';
import 'battle_panel.dart';
import 'move_list.dart';
import 'pokemon.dart';

class PokemonScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pokemon.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            PokemonCard(pokemon: pokemon),
            const SizedBox(height: 16),
            BattlePanel(pokemon: pokemon),
            const SizedBox(height: 16),
            MoveList(moves: pokemon.moves),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Encerrar Batalha'),
            ),
          ],
        ),
      ),
    );
  }
}