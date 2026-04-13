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
            moves: [
                {'name': 'Raio de Gelo', 'icon': Icons.ac_unit},
                {'name': 'Nevasca', 'icon': Icons.cloud},
                {'name': 'Voo', 'icon': Icons.flight},
                {'name': 'Refletir', 'icon': Icons.home},
            ],
        ),
        Pokemon(
            name: 'Zapdos',
            spriteId: 145,
            typeIds: [13, 3],
            level: 50,
            moves: [
                {'name': 'Choque do Trovão', 'icon': Icons.flash_on},
                {'name': 'Descarga', 'icon': Icons.bolt},
                {'name': 'Bico Broca', 'icon': Icons.gps_fixed},
                {'name': 'Chute Trovão', 'icon': Icons.speed},
            ],
        ),
        Pokemon(
            name: 'Moltres',
            spriteId: 146,
            typeIds: [10, 3],
            level: 50,
            moves: [
                {'name': 'Onda de Calor', 'icon': Icons.local_fire_department},
                {'name': 'Giro de Fogo', 'icon': Icons.whatshot},
                {'name': 'Corte de Ar', 'icon': Icons.flight},
                {'name': 'Brasa', 'icon': Icons.wb_sunny},
            ],
        ),
        Pokemon(
            name: 'Gyarados',
            spriteId: 130,
            typeIds: [11, 3],
            level: 45,
            moves: [
                {'name': 'Cachoeira', 'icon': Icons.water},
                {'name': 'Dança do Dragão', 'icon': Icons.warning},
                {'name': 'Presa de Gelo', 'icon': Icons.cyclone},
            ],
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