import 'package:flutter/material.dart';
import 'dart:convert';

class ThemeColor {
  String name;
  Color color;
  String description;

  ThemeColor({
    required this.name,
    required this.color,
    this.description = '',
  });

  String get hexCode => '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  
  void updateFromHex(String hexCode) {
    if (hexCode.startsWith('#')) {
      hexCode = hexCode.substring(1);
    }
    
    try {
      color = Color(int.parse('FF$hexCode', radix: 16));
    } catch (e) {
      debugPrint('Erreur lors de la conversion de la couleur: $e');
    }
  }
}

class ThemeModel extends ChangeNotifier {
  // Mode du thème (clair/sombre)
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  
  // Vue sélectionnée (composants, mobile, web)
  String _selectedView = 'components';
  String get selectedView => _selectedView;
  
  // Couleurs du thème Material 3
  List<ThemeColor> _colors = [
    // Couleurs primaires
    ThemeColor(name: 'primary', color: const Color(0xFF6750A4), description: 'Couleur primaire principale'),
    ThemeColor(name: 'onPrimary', color: const Color(0xFFFFFFFF), description: 'Couleur du texte sur fond primaire'),
    ThemeColor(name: 'primaryContainer', color: const Color(0xFFEADDFF), description: 'Couleur du conteneur primaire'),
    ThemeColor(name: 'onPrimaryContainer', color: const Color(0xFF21005E), description: 'Couleur du texte sur conteneur primaire'),
    
    // Couleurs secondaires
    ThemeColor(name: 'secondary', color: const Color(0xFF625B71), description: 'Couleur secondaire principale'),
    ThemeColor(name: 'onSecondary', color: const Color(0xFFFFFFFF), description: 'Couleur du texte sur fond secondaire'),
    ThemeColor(name: 'secondaryContainer', color: const Color(0xFFE8DEF8), description: 'Couleur du conteneur secondaire'),
    ThemeColor(name: 'onSecondaryContainer', color: const Color(0xFF1E192B), description: 'Couleur du texte sur conteneur secondaire'),
    
    // Couleurs tertiaires
    ThemeColor(name: 'tertiary', color: const Color(0xFF7D5260), description: 'Couleur tertiaire principale'),
    ThemeColor(name: 'onTertiary', color: const Color(0xFFFFFFFF), description: 'Couleur du texte sur fond tertiaire'),
    ThemeColor(name: 'tertiaryContainer', color: const Color(0xFFFFD8E4), description: 'Couleur du conteneur tertiaire'),
    ThemeColor(name: 'onTertiaryContainer', color: const Color(0xFF31111D), description: 'Couleur du texte sur conteneur tertiaire'),
    
    // Couleurs d'erreur
    ThemeColor(name: 'error', color: const Color(0xFFB3261E), description: 'Couleur d\'erreur principale'),
    ThemeColor(name: 'onError', color: const Color(0xFFFFFFFF), description: 'Couleur du texte sur fond d\'erreur'),
    ThemeColor(name: 'errorContainer', color: const Color(0xFFF9DEDC), description: 'Couleur du conteneur d\'erreur'),
    ThemeColor(name: 'onErrorContainer', color: const Color(0xFF410E0B), description: 'Couleur du texte sur conteneur d\'erreur'),
    
    // Couleurs de fond
    ThemeColor(name: 'background', color: const Color(0xFFFFFBFE), description: 'Couleur de fond principale'),
    ThemeColor(name: 'onBackground', color: const Color(0xFF1C1B1F), description: 'Couleur du texte sur fond principal'),
    ThemeColor(name: 'surface', color: const Color(0xFFFFFBFE), description: 'Couleur de surface'),
    ThemeColor(name: 'onSurface', color: const Color(0xFF1C1B1F), description: 'Couleur du texte sur surface'),
    
    // Variantes de surface
    ThemeColor(name: 'surfaceVariant', color: const Color(0xFFE7E0EC), description: 'Variante de la couleur de surface'),
    ThemeColor(name: 'onSurfaceVariant', color: const Color(0xFF49454F), description: 'Couleur du texte sur variante de surface'),
    ThemeColor(name: 'outline', color: const Color(0xFF79747E), description: 'Couleur des contours'),
    ThemeColor(name: 'outlineVariant', color: const Color(0xFFCAC4D0), description: 'Variante de la couleur des contours'),
  ];
  
  // Même couleurs mais avec des valeurs sombres pour le thème Dark
  List<ThemeColor> _darkColors = [
    // Couleurs primaires (dark)
    ThemeColor(name: 'primary', color: const Color(0xFFCFBCFF), description: 'Couleur primaire principale'),
    ThemeColor(name: 'onPrimary', color: const Color(0xFF381E72), description: 'Couleur du texte sur fond primaire'),
    ThemeColor(name: 'primaryContainer', color: const Color(0xFF4F378B), description: 'Couleur du conteneur primaire'),
    ThemeColor(name: 'onPrimaryContainer', color: const Color(0xFFEADDFF), description: 'Couleur du texte sur conteneur primaire'),
    
    // Couleurs secondaires (dark)
    ThemeColor(name: 'secondary', color: const Color(0xFFCCC2DC), description: 'Couleur secondaire principale'),
    ThemeColor(name: 'onSecondary', color: const Color(0xFF332D41), description: 'Couleur du texte sur fond secondaire'),
    ThemeColor(name: 'secondaryContainer', color: const Color(0xFF4A4458), description: 'Couleur du conteneur secondaire'),
    ThemeColor(name: 'onSecondaryContainer', color: const Color(0xFFE8DEF8), description: 'Couleur du texte sur conteneur secondaire'),
    
    // Couleurs tertiaires (dark)
    ThemeColor(name: 'tertiary', color: const Color(0xFFEFB8C8), description: 'Couleur tertiaire principale'),
    ThemeColor(name: 'onTertiary', color: const Color(0xFF492532), description: 'Couleur du texte sur fond tertiaire'),
    ThemeColor(name: 'tertiaryContainer', color: const Color(0xFF633B48), description: 'Couleur du conteneur tertiaire'),
    ThemeColor(name: 'onTertiaryContainer', color: const Color(0xFFFFD8E4), description: 'Couleur du texte sur conteneur tertiaire'),
    
    // Couleurs d'erreur (dark)
    ThemeColor(name: 'error', color: const Color(0xFFF2B8B5), description: 'Couleur d\'erreur principale'),
    ThemeColor(name: 'onError', color: const Color(0xFF601410), description: 'Couleur du texte sur fond d\'erreur'),
    ThemeColor(name: 'errorContainer', color: const Color(0xFF8C1D18), description: 'Couleur du conteneur d\'erreur'),
    ThemeColor(name: 'onErrorContainer', color: const Color(0xFFF9DEDC), description: 'Couleur du texte sur conteneur d\'erreur'),
    
    // Couleurs de fond (dark)
    ThemeColor(name: 'background', color: const Color(0xFF1C1B1F), description: 'Couleur de fond principale'),
    ThemeColor(name: 'onBackground', color: const Color(0xFFE6E1E5), description: 'Couleur du texte sur fond principal'),
    ThemeColor(name: 'surface', color: const Color(0xFF1C1B1F), description: 'Couleur de surface'),
    ThemeColor(name: 'onSurface', color: const Color(0xFFE6E1E5), description: 'Couleur du texte sur surface'),
    
    // Variantes de surface (dark)
    ThemeColor(name: 'surfaceVariant', color: const Color(0xFF49454F), description: 'Variante de la couleur de surface'),
    ThemeColor(name: 'onSurfaceVariant', color: const Color(0xFFCAC4D0), description: 'Couleur du texte sur variante de surface'),
    ThemeColor(name: 'outline', color: const Color(0xFF938F99), description: 'Couleur des contours'),
    ThemeColor(name: 'outlineVariant', color: const Color(0xFF49454F), description: 'Variante de la couleur des contours'),
  ];
  
  // Getters pour accéder aux listes de couleurs
  List<ThemeColor> get colors => _themeMode == ThemeMode.dark ? _darkColors : _colors;
  List<ThemeColor> get lightColors => _colors;
  List<ThemeColor> get darkColors => _darkColors;
  
  // Getter pour créer un ColorScheme à partir des couleurs actuelles
  ColorScheme get _lightColorScheme => ColorScheme(
    brightness: Brightness.light,
    primary: getColorByName('primary', isLight: true),
    onPrimary: getColorByName('onPrimary', isLight: true),
    primaryContainer: getColorByName('primaryContainer', isLight: true),
    onPrimaryContainer: getColorByName('onPrimaryContainer', isLight: true),
    secondary: getColorByName('secondary', isLight: true),
    onSecondary: getColorByName('onSecondary', isLight: true),
    secondaryContainer: getColorByName('secondaryContainer', isLight: true),
    onSecondaryContainer: getColorByName('onSecondaryContainer', isLight: true),
    tertiary: getColorByName('tertiary', isLight: true),
    onTertiary: getColorByName('onTertiary', isLight: true),
    tertiaryContainer: getColorByName('tertiaryContainer', isLight: true),
    onTertiaryContainer: getColorByName('onTertiaryContainer', isLight: true),
    error: getColorByName('error', isLight: true),
    onError: getColorByName('onError', isLight: true),
    errorContainer: getColorByName('errorContainer', isLight: true),
    onErrorContainer: getColorByName('onErrorContainer', isLight: true),
    background: getColorByName('background', isLight: true),
    onBackground: getColorByName('onBackground', isLight: true),
    surface: getColorByName('surface', isLight: true),
    onSurface: getColorByName('onSurface', isLight: true),
    surfaceVariant: getColorByName('surfaceVariant', isLight: true),
    onSurfaceVariant: getColorByName('onSurfaceVariant', isLight: true),
    outline: getColorByName('outline', isLight: true),
    outlineVariant: getColorByName('outlineVariant', isLight: true),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: getColorByName('onSurface', isLight: true),
    onInverseSurface: getColorByName('surface', isLight: true),
    inversePrimary: getColorByName('onPrimary', isLight: true),
  );
  
  ColorScheme get _darkColorScheme => ColorScheme(
    brightness: Brightness.dark,
    primary: getColorByName('primary', isLight: false),
    onPrimary: getColorByName('onPrimary', isLight: false),
    primaryContainer: getColorByName('primaryContainer', isLight: false),
    onPrimaryContainer: getColorByName('onPrimaryContainer', isLight: false),
    secondary: getColorByName('secondary', isLight: false),
    onSecondary: getColorByName('onSecondary', isLight: false),
    secondaryContainer: getColorByName('secondaryContainer', isLight: false),
    onSecondaryContainer: getColorByName('onSecondaryContainer', isLight: false),
    tertiary: getColorByName('tertiary', isLight: false),
    onTertiary: getColorByName('onTertiary', isLight: false),
    tertiaryContainer: getColorByName('tertiaryContainer', isLight: false),
    onTertiaryContainer: getColorByName('onTertiaryContainer', isLight: false),
    error: getColorByName('error', isLight: false),
    onError: getColorByName('onError', isLight: false),
    errorContainer: getColorByName('errorContainer', isLight: false),
    onErrorContainer: getColorByName('onErrorContainer', isLight: false),
    background: getColorByName('background', isLight: false),
    onBackground: getColorByName('onBackground', isLight: false),
    surface: getColorByName('surface', isLight: false),
    onSurface: getColorByName('onSurface', isLight: false),
    surfaceVariant: getColorByName('surfaceVariant', isLight: false),
    onSurfaceVariant: getColorByName('onSurfaceVariant', isLight: false),
    outline: getColorByName('outline', isLight: false),
    outlineVariant: getColorByName('outlineVariant', isLight: false),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: getColorByName('onSurface', isLight: false),
    onInverseSurface: getColorByName('surface', isLight: false),
    inversePrimary: getColorByName('onPrimary', isLight: false),
  );
  
  // Getters pour les thèmes
  ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: _lightColorScheme,
  );
  
  ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme,
  );
  
  // Obtenir une couleur par son nom
  Color getColorByName(String name, {bool isLight = true}) {
    final colorsList = isLight ? _colors : _darkColors;
    final colorObject = colorsList.firstWhere(
      (c) => c.name == name, 
      orElse: () => ThemeColor(name: name, color: Colors.purple),
    );
    return colorObject.color;
  }
  
  // Mettre à jour une couleur
  void updateColor(String name, Color newColor, {bool isLight = true}) {
    final colorsList = isLight ? _colors : _darkColors;
    final index = colorsList.indexWhere((c) => c.name == name);
    
    if (index != -1) {
      colorsList[index].color = newColor;
      notifyListeners();
    }
  }
  
  // Changer le mode du thème
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
  
  // Changer la vue sélectionnée
  void setSelectedView(String view) {
    _selectedView = view;
    notifyListeners();
  }
  
  // Exporter le thème vers JSON
  Map<String, dynamic> toJson() {
    return {
      'light': _colors.map((color) => {
        'name': color.name,
        'color': color.hexCode,
        'description': color.description,
      }).toList(),
      'dark': _darkColors.map((color) => {
        'name': color.name,
        'color': color.hexCode,
        'description': color.description,
      }).toList(),
    };
  }
  
  // Exporter en format JSON
  String toJsonString() {
    return jsonEncode(toJson());
  }
  
  // Exporter en format Dart
  String toDartCode() {
    final buffer = StringBuffer();
    
    buffer.writeln('// Thème Material 3 généré');
    buffer.writeln('import \'package:flutter/material.dart\';');
    buffer.writeln();
    buffer.writeln('class AppTheme {');
    
    // Light Theme
    buffer.writeln('  static ThemeData get lightTheme => ThemeData(');
    buffer.writeln('    useMaterial3: true,');
    buffer.writeln('    colorScheme: lightColorScheme,');
    buffer.writeln('  );');
    buffer.writeln();
    
    // Dark Theme
    buffer.writeln('  static ThemeData get darkTheme => ThemeData(');
    buffer.writeln('    useMaterial3: true,');
    buffer.writeln('    colorScheme: darkColorScheme,');
    buffer.writeln('  );');
    buffer.writeln();
    
    // Light ColorScheme
    buffer.writeln('  static final ColorScheme lightColorScheme = ColorScheme(');
    buffer.writeln('    brightness: Brightness.light,');
    for (final color in _colors) {
      buffer.writeln('    ${color.name}: const Color(0x${color.color.value.toRadixString(16).padLeft(8, '0')}),');
    }
    buffer.writeln('    shadow: Colors.black,');
    buffer.writeln('    scrim: Colors.black,');
    buffer.writeln('    inverseSurface: const Color(0x${getColorByName("onSurface", isLight: true).value.toRadixString(16).padLeft(8, '0')}),');
    buffer.writeln('    onInverseSurface: const Color(0x${getColorByName("surface", isLight: true).value.toRadixString(16).padLeft(8, '0')}),');
    buffer.writeln('    inversePrimary: const Color(0x${getColorByName("onPrimary", isLight: true).value.toRadixString(16).padLeft(8, '0')}),');
    buffer.writeln('  );');
    buffer.writeln();
    
    // Dark ColorScheme
    buffer.writeln('  static final ColorScheme darkColorScheme = ColorScheme(');
    buffer.writeln('    brightness: Brightness.dark,');
    for (final color in _darkColors) {
      buffer.writeln('    ${color.name}: const Color(0x${color.color.value.toRadixString(16).padLeft(8, '0')}),');
    }
    buffer.writeln('    shadow: Colors.black,');
    buffer.writeln('    scrim: Colors.black,');
    buffer.writeln('    inverseSurface: const Color(0x${getColorByName("onSurface", isLight: false).value.toRadixString(16).padLeft(8, '0')}),');
    buffer.writeln('    onInverseSurface: const Color(0x${getColorByName("surface", isLight: false).value.toRadixString(16).padLeft(8, '0')}),');
    buffer.writeln('    inversePrimary: const Color(0x${getColorByName("onPrimary", isLight: false).value.toRadixString(16).padLeft(8, '0')}),');
    buffer.writeln('  );');
    buffer.writeln('}');
    
    return buffer.toString();
  }
  
  // Exporter en format XML
  String toXml() {
    final buffer = StringBuffer();
    
    buffer.writeln('<?xml version="1.0" encoding="utf-8"?>');
    buffer.writeln('<resources>');
    buffer.writeln('  <!-- Thème Material 3 Light -->');
    
    for (final color in _colors) {
      buffer.writeln('  <color name="md_theme_light_${color.name}">${color.hexCode}</color>');
    }
    
    buffer.writeln('  <!-- Thème Material 3 Dark -->');
    for (final color in _darkColors) {
      buffer.writeln('  <color name="md_theme_dark_${color.name}">${color.hexCode}</color>');
    }
    
    buffer.writeln('</resources>');
    
    return buffer.toString();
  }
  
  // Importer depuis JSON
  void importFromJson(String jsonString) {
    try {
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      
      if (data.containsKey('light')) {
        final lightList = List<Map<String, dynamic>>.from(data['light']);
        for (final item in lightList) {
          final name = item['name'] as String;
          final hexColor = item['color'] as String;
          final description = item['description'] as String? ?? '';
          
          final index = _colors.indexWhere((c) => c.name == name);
          if (index != -1) {
            final color = ThemeColor(name: name, color: Colors.black, description: description);
            color.updateFromHex(hexColor);
            _colors[index] = color;
          }
        }
      }
      
      if (data.containsKey('dark')) {
        final darkList = List<Map<String, dynamic>>.from(data['dark']);
        for (final item in darkList) {
          final name = item['name'] as String;
          final hexColor = item['color'] as String;
          final description = item['description'] as String? ?? '';
          
          final index = _darkColors.indexWhere((c) => c.name == name);
          if (index != -1) {
            final color = ThemeColor(name: name, color: Colors.black, description: description);
            color.updateFromHex(hexColor);
            _darkColors[index] = color;
          }
        }
      }
      
      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors de l\'importation du thème: $e');
    }
  }
}