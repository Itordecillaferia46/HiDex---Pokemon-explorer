import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';

  // Lista paginada, por defecto trae  20 registros
  Future<List<PokemonListItem>> fetchPokemonList({int limit = 20}) async {
    final uri = Uri.parse('$_baseUrl/pokemon?limit=$limit');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List;
      return results.map((e) => PokemonListItem.fromJson(e)).toList();
    } else {
      // Lanzamos excepción si la API responde con error ya sea 404 o 500
      throw Exception('Error al cargar la lista (${response.statusCode})');
    }
  }

// Obtiene el detalle completo de un Pokémon por su nombre o ID.
  Future<PokemonDetail> fetchPokemonDetail(String name) async {
    final uri = Uri.parse('$_baseUrl/pokemon/$name');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return PokemonDetail.fromJson(data);
    } else {
      throw Exception(
          'Error al cargar los detalles de $name (${response.statusCode})');
    }
  }
}
