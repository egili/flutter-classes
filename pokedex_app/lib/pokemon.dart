class Pokemon {
  final String name;
  final String spriteUrl; 
  final List<String> types; 
  int level;
  final List<Map<String, dynamic>> moves;

  Pokemon({
    required this.name,
    required this.spriteUrl,
    required this.types,
    required this.level,
    this.moves = const [],
  });
}