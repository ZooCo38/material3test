import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'models/theme_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModel(),
      child: const MaterialThemeEditor(),
    ),
  );
}

class MaterialThemeEditor extends StatelessWidget {
  const MaterialThemeEditor({super.key});

  @override
  Widget build(BuildContext context) {
    // Accéder au modèle de thème pour obtenir le thème actuel
    final themeModel = Provider.of<ThemeModel>(context);
    
    return MaterialApp(
      title: 'Material 3 Theme Editor',
      debugShowCheckedModeBanner: false,
      theme: themeModel.lightTheme,
      darkTheme: themeModel.darkTheme,
      themeMode: themeModel.themeMode,
      home: const HomeScreen(),
    );
  }
}