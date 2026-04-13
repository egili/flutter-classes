import 'package:flutter/material.dart';
import 'pokemon.dart';
import 'pokemon_screen.dart';
import 'pokemon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pokemons = [
        Pokemon(
            name: 'Articuno',
            spriteId: 144,
            typeIds: [15, 3], 
            level: 50,
            moves: ['Ice Beam', 'Blizzard', 'Fly', 'Roost'],
        ),
        Pokemon(
            name: 'Zapdos',
            spriteId: 145,
            typeIds: [13, 3], 
            level: 50,
            moves: ['Thunderbolt', 'Drill Peck', 'Thunder', 'Agility'],
        ),
        Pokemon(
            name: 'Moltres',
            spriteId: 146,
            typeIds: [10, 3], 
            level: 50,
            moves: ['Flamethrower', 'Fire Blast', 'Fly', 'Sunny Day'],
        ),
        Pokemon(
            name: 'Gyarados',
            spriteId: 130,
            typeIds: [11, 3],
            level: 45,
            moves: ['Hydro Pump', 'Crunch', 'Dragon Dance', 'Hurricane'],
        ),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = pokemons[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(pokemon.spriteUrl),
              ),
              title: Text(pokemon.name),
              subtitle: Text('Nível ${pokemon.level}'),

              onTap: () async {
                final novoNivel = await Navigator.push<int>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PokemonScreen(pokemon: pokemon),
                  ),
                );

                if (novoNivel != null) {
                  setState(() {
                    pokemon.level = novoNivel;
                  });
                }
              },
            ),
          );
        },
      ),
    );
  }
}