import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';
import '../widgets/navigation_rail.dart';
import '../widgets/theme_drawer.dart';
import 'components_view.dart';
import 'mobile_view.dart';
import 'web_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    
    // Déterminer quelle vue afficher en fonction de la sélection
    Widget mainContent;
    switch (themeModel.selectedView) {
      case 'mobile':
        mainContent = const MobileView();
        break;
      case 'web':
        mainContent = const WebView();
        break;
      case 'components':
      default:
        mainContent = const ComponentsView();
        break;
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material 3 Theme Editor'),
        actions: [
          // Toggle entre les modes clair et sombre
          IconButton(
            icon: Icon(
              themeModel.themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              themeModel.setThemeMode(
                themeModel.themeMode == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light,
              );
            },
            tooltip: 'Changer de thème',
          ),
        ],
      ),
      drawer: const ThemeDrawer(),
      body: Row(
        children: [
          // Navigation Rail sur le côté gauche
          const CustomNavigationRail(),
          
          // Contenu principal qui occupe le reste de l'espace
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}