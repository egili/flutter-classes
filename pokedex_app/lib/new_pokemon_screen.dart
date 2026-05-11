import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pokemon_service.dart';

class NewPokemonScreen extends StatefulWidget {
  const NewPokemonScreen({super.key});

  @override
  State<NewPokemonScreen> createState() => _NewPokemonScreenState();
}

class _NewPokemonScreenState extends State<NewPokemonScreen> {
  final _service = PokemonService();
  final _formKey = GlobalKey<FormState>();
  final _queryController = TextEditingController();
  final _levelController = TextEditingController(text: '1');

  late Future<List<String>> _searchFuture;
  Map<String, dynamic>? _selected;
  bool _loadingDetails = false;

  @override
  void initState() {
    super.initState();
    _searchFuture = _service.fetchPokemonNames();
  }

  void _buscar() {
    setState(() {
      final query = _queryController.text.trim();
      _searchFuture = query.isEmpty ? _service.fetchPokemonNames() : _service.fetchPokemonByName(query);
    });
  }

  void _selectPokemon(String name) async {
    setState(() => _loadingDetails = true);
    try {
      final details = await _service.fetchPokemonDetails(name);
      setState(() {
        _selected = details;
        _loadingDetails = false;
      });
    } catch (e) {
      setState(() => _loadingDetails = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
  }

  void _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    await FirebaseFirestore.instance.collection('pokemons').add({
      'name': _selected!['name'],
      'spriteUrl': _selected!['spriteUrl'],
      'types': _selected!['types'],
      'level': int.parse(_levelController.text),
    });
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Capturar Pokémon'), backgroundColor: Colors.redAccent),
      body: _loadingDetails 
          ? const Center(child: CircularProgressIndicator())
          : (_selected == null ? _buildList() : _buildForm()),
    );
  }

  Widget _buildList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(child: TextField(controller: _queryController, decoration: const InputDecoration(labelText: 'Buscar Pokémon', border: OutlineInputBorder()))),
              const SizedBox(width: 8),
              IconButton(onPressed: _buscar, icon: const Icon(Icons.search), color: Colors.redAccent),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<String>>(
            future: _searchFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) return const Center(child: Text('Não encontrado.'));
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              final names = snapshot.data!;
              return ListView.builder(
                itemCount: names.length,
                itemBuilder: (context, i) => ListTile(
                  title: Text(names[i].toUpperCase()),
                  onTap: () => _selectPokemon(names[i]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.network(_selected!['spriteUrl'], height: 120),
                    Text(_selected!['name'].toString().toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(spacing: 8, children: (_selected!['types'] as List).map((t) => Chip(label: Text(t.toString().toUpperCase()))).toList()),
                    TextButton(onPressed: () => setState(() => _selected = null), child: const Text('Escolher outro')),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _levelController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nível (1-100)', border: OutlineInputBorder()),
              validator: (v) => (int.tryParse(v ?? '') ?? 0).clamp(1, 100) != int.tryParse(v ?? '') ? 'Inválido' : null,
            ),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _salvar, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text('SALVAR NA POKÉDEX', style: TextStyle(color: Colors.white)))),
          ],
        ),
      ),
    );
  }
}