// Clase usada para el listado inicial (Home).
class PokemonListItem {
  final String name;
  final String url;

  const PokemonListItem({required this.name, required this.url});

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
// Genera la URL de la imagen oficial basándose en el ID extraído de la URL https://pokeapi.co/api/v2/pokemon/1/
  String get spriteUrl {
    final uri = Uri.parse(url);
    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    final id = segments.last;
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }
}

class PokemonDetail {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<String> types;
  final String spriteUrl;
  final List<PokemonStat> stats;

  const PokemonDetail({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.spriteUrl,
    required this.stats,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    final types = (json['types'] as List)
        .map((t) => t['type']['name'] as String)
        .toList();

    final stats =
        (json['stats'] as List).map((s) => PokemonStat.fromJson(s)).toList();

    final id = json['id'] as int;

    return PokemonDetail(
      id: id,
      name: json['name'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      // Extraemos solo el nombre del tipo de la estructura anidada
      types: types,
      spriteUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
      stats: stats,
    );
  }
}

class PokemonStat {
  final String name;
  final int value;

  const PokemonStat({required this.name, required this.value});

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(
      name: json['stat']['name'] as String,
      value: json['base_stat'] as int,
    );
  }
}
