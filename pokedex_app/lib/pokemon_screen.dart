class PokemonScreen extends StatelessWidget {
  final Pokemon pokemon;
  final String docId; // ADICIONE AQUI

  // ATUALIZE O CONSTRUTOR
  const PokemonScreen({super.key, required this.pokemon, required this.docId});

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
            // REPASSE O docId PARA O BATTLE PANEL
            BattlePanel(pokemon: pokemon, docId: docId), 
            const SizedBox(height: 16),
            MoveList(moves: pokemon.moves),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}