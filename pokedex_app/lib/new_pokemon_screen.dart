import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewPokemonScreen extends StatefulWidget {
  const NewPokemonScreen({super.key});

  @override
  State<NewPokemonScreen> createState() => _NewPokemonScreenState();
}

class _NewPokemonScreenState extends State<NewPokemonScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _nameController = TextEditingController();
  final _spriteIdController = TextEditingController();
  final _levelController = TextEditingController();
  
  final _nameFocusNode = FocusNode();
  final _spriteIdFocusNode = FocusNode();
  final _levelFocusNode = FocusNode();
  
  String? _selectedType;
  
  String _previewName = '';
  
  final List<String> _types = [
    'Fogo', 'Água', 'Planta', 'Elétrico', 
    'Normal', 'Psíquico', 'Gelo', 'Dragão'
  ];
  
  final Map<String, int> _typeIds = {
    'Fogo': 1,
    'Água': 2,
    'Planta': 3,
    'Elétrico': 4,
    'Normal': 5,
    'Psíquico': 6,
    'Gelo': 7,
    'Dragão': 8,
  };

  @override
  void dispose() {
    _nameController.dispose();
    _spriteIdController.dispose();
    _levelController.dispose();
    
    _nameFocusNode.dispose();
    _spriteIdFocusNode.dispose();
    _levelFocusNode.dispose();
    
    super.dispose();
  }

  Future<void> _savePokemon() async {
    if (!_formKey.currentState!.validate()) return;
    
    final name = _nameController.text.trim();
    final spriteId = int.parse(_spriteIdController.text);
    final level = int.parse(_levelController.text);
    final typeId = _typeIds[_selectedType!];
    
    await FirebaseFirestore.instance.collection('pokemons').add({
      'name': name,
      'spriteId': spriteId,
      'level': level,
      'typeIds': [typeId], 
    });
    
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Pokémon'),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_previewName.isNotEmpty)
                Card(
                  color: Colors.amber.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Cadastrando: $_previewName',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocusNode,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nome do Pokémon',
                  hintText: 'Ex: Charizard, Pikachu...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.tag),
                ),
                onChanged: (value) {
                  setState(() {
                    _previewName = value.trim();
                  });
                },
                onFieldSubmitted: (_) {
                  _spriteIdFocusNode.requestFocus();
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (value.trim().length < 2) {
                    return 'Mínimo de 2 caracteres';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _spriteIdController,
                focusNode: _spriteIdFocusNode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Sprite ID',
                  hintText: 'Número entre 1 e 1025',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.image),
                ),
                onFieldSubmitted: (_) {
                  _levelFocusNode.requestFocus();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  final id = int.tryParse(value);
                  if (id == null) {
                    return 'Digite um número válido';
                  }
                  if (id < 1 || id > 1025) {
                    return 'ID deve estar entre 1 e 1025';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _levelController,
                focusNode: _levelFocusNode,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nível inicial',
                  hintText: 'Número entre 1 e 100',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.star),
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).unfocus();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  final level = int.tryParse(value);
                  if (level == null) {
                    return 'Digite um número válido';
                  }
                  if (level < 1 || level > 100) {
                    return 'Nível deve estar entre 1 e 100';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Tipo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.local_fire_department),
                ),
                items: _types.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione um tipo';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 32),
              
              ElevatedButton.icon(
                onPressed: _savePokemon,
                icon: const Icon(Icons.save),
                label: const Text(
                  'Salvar Pokémon',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
              
              const SizedBox(height: 16),
              
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel),
                label: const Text('Cancelar'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}