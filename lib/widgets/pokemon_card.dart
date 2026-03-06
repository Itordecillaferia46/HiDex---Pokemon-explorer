import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final PokemonListItem pokemon;
  final VoidCallback onTap;

  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  String get _pokemonId {
    final uri = Uri.parse(pokemon.url);
    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    return segments.last.padLeft(3, '0');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Background pattern
              Positioned(
                right: -10,
                bottom: -10,
                child: Opacity(
                  opacity: 0.06,
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/5/53/Pok%C3%A9_Ball_icon.svg',
                    width: 90,
                    height: 90,
                    errorBuilder: (_, __, ___) => const SizedBox(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#$_pokemonId',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[400],
                        letterSpacing: 0.5,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: pokemon.spriteUrl,
                          placeholder: (context, url) => const Center(
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFFEF5350),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.catching_pokemon,
                            size: 50,
                            color: Colors.grey[300],
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      _capitalize(pokemon.name),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}
