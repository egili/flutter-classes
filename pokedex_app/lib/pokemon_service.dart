import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonService {
  static const String _baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  Future<List<String>> fetchPokemonNames() async {
    final response = await http.get(Uri.parse('$_baseUrl?limit=20'));
    if (response.statusCode != 200) throw Exception('Erro ao buscar lista');

    final data = jsonDecode(response.body);
    final results = data['results'] as List<dynamic>;
    return results.map((item) => item['name'] as String).toList();
  }

  Future<List<String>> fetchPokemonByName(String name) async {
    final response = await http.get(Uri.parse('$_baseUrl/${name.toLowerCase()}'));
    if (response.statusCode == 404) throw Exception('Pokémon não encontrado');
    if (response.statusCode != 200) throw Exception('Erro na busca');

    final data = jsonDecode(response.body);
    return [data['name'] as String];
  }

  Future<Map<String, dynamic>> fetchPokemonDetails(String name) async {
    final response = await http.get(Uri.parse('$_baseUrl/${name.toLowerCase()}'));
    if (response.statusCode != 200) throw Exception('Erro ao carregar detalhes');

    final data = jsonDecode(response.body);
    final id = data['id'];
    
    final types = (data['types'] as List)
        .map((t) => t['type']['name'] as String)
        .toList();

    final spriteUrl = (data['sprites']['front_default'] as String?) ??
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

    return {
      'name': data['name'],
      'spriteUrl': spriteUrl,
      'types': types,
    };
  }
}