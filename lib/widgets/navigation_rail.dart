import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';

class CustomNavigationRail extends StatelessWidget {
  const CustomNavigationRail({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final currentView = themeModel.selectedView;
    
    // Déterminer l'index sélectionné en fonction de la vue
    int selectedIndex;
    switch (currentView) {
      case 'components':
        selectedIndex = 0;
        break;
      case 'mobile':
        selectedIndex = 1;
        break;
      case 'web':
        selectedIndex = 2;
        break;
      default:
        selectedIndex = 0;
    }
    
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        // Mettre à jour la vue sélectionnée dans le modèle
        switch (index) {
          case 0:
            themeModel.setSelectedView('components');
            break;
          case 1:
            themeModel.setSelectedView('mobile');
            break;
          case 2:
            themeModel.setSelectedView('web');
            break;
        }
      },
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.grid_view),
          label: Text('Composants'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.phone_android),
          label: Text('Mobile'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.desktop_windows),
          label: Text('Web'),
        ),
      ],
      leading: Column(
        children: [
          const SizedBox(height: 8),
          // Mode clair/sombre
          IconButton(
            icon: Icon(themeModel.themeMode == ThemeMode.light 
                ? Icons.light_mode 
                : Icons.dark_mode),
            onPressed: () {
              themeModel.setThemeMode(
                themeModel.themeMode == ThemeMode.light 
                    ? ThemeMode.dark 
                    : ThemeMode.light,
              );
            },
            tooltip: themeModel.themeMode == ThemeMode.light 
                ? 'Mode clair' 
                : 'Mode sombre',
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}