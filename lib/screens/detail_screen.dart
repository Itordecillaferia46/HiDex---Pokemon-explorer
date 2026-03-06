import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/pokemon.dart';
import '../services/pokemon_service.dart';
import '../widgets/type_badge.dart';
import '../widgets/type_colors.dart';
import '../widgets/stat_bar.dart';
import '../core/colors.dart';

class DetailScreen extends StatefulWidget {
  final String pokemonName;

  const DetailScreen({super.key, required this.pokemonName});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final PokemonService _service = PokemonService();
  late Future<PokemonDetail> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = _service.fetchPokemonDetail(widget.pokemonName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FutureBuilder<PokemonDetail>(
        future: _detailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppColors.primary),
                  SizedBox(height: 16),
                  Text('Cargando detalles...',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 60, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text('Error al cargar detalles',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => setState(() => _detailFuture =
                          _service.fetchPokemonDetail(widget.pokemonName)),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final pokemon = snapshot.data!;
          final primaryColor = pokemon.types.isNotEmpty
              ? TypeColors.forType(pokemon.types.first)
              : AppColors.primary;

          return CustomScrollView(
            slivers: [
              _buildSliverAppBar(context, pokemon, primaryColor),
              SliverToBoxAdapter(
                child: _buildDetailContent(pokemon, primaryColor),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSliverAppBar(
      BuildContext context, PokemonDetail pokemon, Color primaryColor) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: primaryColor.withOpacity(0.85),
      leading: IconButton(
        icon:
            const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor.withOpacity(0.9),
                    primaryColor.withOpacity(0.6),
                  ],
                ),
              ),
            ),
            // Decorative Pokéball watermark
            Positioned(
              right: -30,
              top: -30,
              child: Opacity(
                opacity: 0.1,
                child: Icon(Icons.catching_pokemon,
                    size: 200, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 20,
              child: CachedNetworkImage(
                imageUrl: pokemon.spriteUrl,
                height: 180,
                placeholder: (_, __) => const SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2),
                ),
                errorWidget: (_, __, ___) => Icon(Icons.catching_pokemon,
                    size: 120, color: Colors.white.withOpacity(0.5)),
              ),
            ),
            Positioned(
              top: 60,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#${pokemon.id.toString().padLeft(3, '0')}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    _capitalize(pokemon.name),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailContent(PokemonDetail pokemon, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Types
          _buildSection(
            title: 'Tipo',
            child: Wrap(
              spacing: 8,
              children: pokemon.types.map((t) => TypeBadge(type: t)).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Physical info
          _buildSection(
            title: 'Información',
            child: Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    icon: Icons.height,
                    label: 'Altura',
                    value: '${(pokemon.height / 10).toStringAsFixed(1)} m',
                    color: AppColors.card,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInfoCard(
                    icon: Icons.monitor_weight_outlined,
                    label: 'Peso',
                    value: '${(pokemon.weight / 10).toStringAsFixed(1)} kg',
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Stats
          _buildSection(
            title: 'Estadísticas base',
            child: Column(
              children: pokemon.stats
                  .map((s) => StatBar(
                        label: s.name,
                        value: s.value,
                        color: primaryColor,
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A2E),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, size: 26, color: color),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A2E),
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        ),
      ],
    );
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}
