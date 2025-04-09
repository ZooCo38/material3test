import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';
import '../models/theme_model.dart';
import 'color_editor_card.dart';

class ThemeDrawer extends StatelessWidget {
  const ThemeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final colors = themeModel.colors;
    
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Éditeur de Thème',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Bouton d'importation
                    FilledButton.icon(
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Importer'),
                      onPressed: () => _importTheme(context),
                    ),
                    // Bouton d'exportation
                    FilledButton.icon(
                      icon: const Icon(Icons.download),
                      label: const Text('Exporter'),
                      onPressed: () => _showExportOptions(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: colors.length,
              itemBuilder: (context, index) {
                final color = colors[index];
                // Utiliser la carte d'édition de couleur personnalisée
                return ColorEditorCard(
                  themeColor: color,
                  onColorChanged: (newColor) {
                    themeModel.updateColor(
                      color.name, 
                      newColor, 
                      isLight: themeModel.themeMode == ThemeMode.light,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour importer un thème
  Future<void> _importTheme(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      
      if (result != null && result.files.isNotEmpty) {
        final file = File(result.files.first.path!);
        final jsonContent = await file.readAsString();
        
        // Importer le thème
        Provider.of<ThemeModel>(context, listen: false).importFromJson(jsonContent);
        
        // Afficher un message de succès
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Thème importé avec succès')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'importation: $e')),
        );
      }
    }
  }

  // Afficher les options d'exportation
  void _showExportOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exporter le thème'),
        content: const Text('Choisissez le format d\'exportation:'),
        actions: [
          TextButton(
            onPressed: () => _exportTheme(context, 'json'),
            child: const Text('JSON'),
          ),
          TextButton(
            onPressed: () => _exportTheme(context, 'dart'),
            child: const Text('Dart'),
          ),
          TextButton(
            onPressed: () => _exportTheme(context, 'xml'),
            child: const Text('XML'),
          ),
        ],
      ),
    );
  }

  // Méthode pour exporter un thème
  Future<void> _exportTheme(BuildContext context, String format) async {
    final themeModel = Provider.of<ThemeModel>(context, listen: false);
    
    String content;
    String extension;
    
    // Obtenir le contenu en fonction du format
    switch (format) {
      case 'json':
        content = themeModel.toJsonString();
        extension = 'json';
        break;
      case 'dart':
        content = themeModel.toDartCode();
        extension = 'dart';
        break;
      case 'xml':
        content = themeModel.toXml();
        extension = 'xml';
        break;
      default:
        content = '';
        extension = '';
    }
    
    try {
      // Utiliser FilePicker pour choisir l'emplacement de sauvegarde
      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Enregistrer le thème',
        fileName: 'material3_theme.$extension',
      );
      
      if (result != null) {
        final file = File(result);
        await file.writeAsString(content);
        
        // Fermer la boîte de dialogue
        if (context.mounted) {
          Navigator.of(context).pop();
          
          // Afficher un message de succès
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Thème exporté avec succès')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'exportation: $e')),
        );
      }
    }
  }
}