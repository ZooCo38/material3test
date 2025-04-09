import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import '../models/theme_model.dart';

class ColorEditorCard extends StatefulWidget {
  final ThemeColor themeColor;
  final ValueChanged<Color> onColorChanged;

  const ColorEditorCard({
    super.key,
    required this.themeColor,
    required this.onColorChanged,
  });

  @override
  State<ColorEditorCard> createState() => _ColorEditorCardState();
}

class _ColorEditorCardState extends State<ColorEditorCard> {
  late TextEditingController _hexController;
  
  @override
  void initState() {
    super.initState();
    _hexController = TextEditingController(text: widget.themeColor.hexCode);
  }
  
  @override
  void didUpdateWidget(ColorEditorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.themeColor.color != widget.themeColor.color) {
      _hexController.text = widget.themeColor.hexCode;
    }
  }
  
  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nom de la couleur
            Text(
              widget.themeColor.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (widget.themeColor.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  widget.themeColor.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            const SizedBox(height: 12),
            // Rangée avec le sélecteur de couleur et l'entrée hexadécimale
            Row(
              children: [
                // Pastille de couleur cliquable
                InkWell(
                  onTap: () => _showColorPicker(context),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: widget.themeColor.color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Entrée de code hexadécimal
                Expanded(
                  child: TextField(
                    controller: _hexController,
                    decoration: const InputDecoration(
                      labelText: 'Code hex',
                      hintText: '#000000',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _updateColorFromHex,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-F#]')),
                      LengthLimitingTextInputFormatter(7),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour afficher le sélecteur de couleur
  void _showColorPicker(BuildContext context) async {
    final Color initialColor = widget.themeColor.color;
    
    final Color newColor = await showColorPickerDialog(
      context,
      initialColor,
      title: Text('Sélectionner une couleur pour ${widget.themeColor.name}'),
      width: 40,
      height: 40,
      spacing: 0,
      runSpacing: 0,
      borderRadius: 0,
      wheelDiameter: 165,
      enableOpacity: true,
      showColorCode: true,
      colorCodeHasColor: true,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: true,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
    );
    
    if (newColor != initialColor) {
      // Mettre à jour le contrôleur hexadécimal
      setState(() {
        _hexController.text = '#${newColor.value.toRadixString(16).substring(2).padLeft(6, '0')}';
      });
      
      // Appeler la fonction de rappel
      widget.onColorChanged(newColor);
    }
  }
  
  // Mettre à jour la couleur à partir de l'entrée hexadécimale
  void _updateColorFromHex(String hexValue) {
    if (hexValue.startsWith('#') && hexValue.length == 7) {
      try {
        final colorValue = int.parse('FF${hexValue.substring(1)}', radix: 16);
        final newColor = Color(colorValue);
        
        // Ne mettre à jour que si la couleur est différente
        if (newColor != widget.themeColor.color) {
          widget.onColorChanged(newColor);
        }
      } catch (e) {
        // Ignorer les erreurs de parsing
      }
    }
  }
}