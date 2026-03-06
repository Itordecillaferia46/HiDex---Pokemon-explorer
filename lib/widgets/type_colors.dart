import 'package:flutter/material.dart';

class TypeColors {
  static const Map<String, Color> colors = {
    'fire': Color(0xFFFF6B35),
    'water': Color(0xFF4FC3F7),
    'grass': Color(0xFF66BB6A),
    'electric': Color(0xFFFFD54F),
    'psychic': Color(0xFFEC407A),
    'ice': Color(0xFF80DEEA),
    'dragon': Color(0xFF5C6BC0),
    'dark': Color(0xFF5D4037),
    'fairy': Color(0xFFF48FB1),
    'fighting': Color(0xFFEF5350),
    'flying': Color(0xFF90CAF9),
    'poison': Color(0xFFAB47BC),
    'ground': Color(0xFFD4A574),
    'rock': Color(0xFF8D6E63),
    'bug': Color(0xFF9CCC65),
    'ghost': Color(0xFF7E57C2),
    'steel': Color(0xFF90A4AE),
    'normal': Color(0xFFBDBDBD),
  };

  static Color forType(String type) {
    return colors[type.toLowerCase()] ?? const Color(0xFFBDBDBD);
  }

  static Color cardBackground(List<String> types) {
    if (types.isEmpty) return const Color(0xFFBDBDBD);
    return forType(types.first).withOpacity(0.15);
  }
}
