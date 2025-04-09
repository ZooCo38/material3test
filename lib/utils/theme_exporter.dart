import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'export_formats.dart';
import '../models/theme_model.dart';

class ThemeExporter {
  static Future<void> exportTheme(
    BuildContext context,
    ThemeModel themeModel,
    ExportFormat format,
  ) async {
    String content = _getContentForFormat(themeModel, format);
    
    try {
      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Enregistrer le thème',
        fileName: 'material3_theme.${format.extension}',
      );
      
      if (result != null) {
        final file = File(result);
        await file.writeAsString(content);
        
        if (context.mounted) {
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

  static String _getContentForFormat(ThemeModel themeModel, ExportFormat format) {
    switch (format) {
      case ExportFormat.json:
        return themeModel.toJsonString();
      case ExportFormat.dart:
        return themeModel.toDartCode();
      case ExportFormat.xml:
        return themeModel.toXml();
    }
  }
}