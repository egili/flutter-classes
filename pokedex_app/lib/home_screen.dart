import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importação necessária
import 'pokemon.dart';
import 'pokemon_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Referência da coleção no Firestore
  final collection = FirebaseFirestore.instance.collection('pokemons');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      // Parte 1: Substituindo a lista fixa pelo StreamBuilder
      body: StreamBuilder<QuerySnapshot>(
        stream: collection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text('Erro ao carregar'));
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final docId = docs[index].id; // ID único do documento no Firebase

              // Criamos o objeto Pokemon com os dados vindos do banco
              final pokemon = Pokemon(
                name: data['name'] ?? 'Sem nome',
                spriteId: data['spriteId'] ?? 1,
                // Ajuste conforme sua classe Pokemon lida com tipos (array de strings)
                typeIds: List<int>.from(data['typeIds'] ?? []), 
                level: data['level'] ?? 1,
                moves: [], // Pode deixar vazio se não estiver no banco
              );

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(pokemon.spriteUrl),
                  ),
                  title: Text(pokemon.name),
                  subtitle: Text('Nível ${pokemon.level}'),
                  // Parte 3: Botão de Deletar
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await collection.doc(docId).delete();
                    },
                  ),
                  onTap: () {
                    // Parte 2: Navegando e passando o docId
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PokemonScreen(
                          pokemon: pokemon,
                          docId: docId, // Precisamos adicionar isso na PokemonScreen
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}