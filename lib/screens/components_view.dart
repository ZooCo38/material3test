import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';

class ComponentsView extends StatelessWidget {
  const ComponentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Thème Material 3 - Aperçu des composants'),
            const SizedBox(height: 24),
            
            // Grille de composants
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildComponentCard(context, 'Boutons', _buildButtonsPreview(context)),
                _buildComponentCard(context, 'Champs de texte', _buildTextFieldsPreview(context)),
                _buildComponentCard(context, 'Cartes', _buildCardsPreview(context)),
                _buildComponentCard(context, 'Appbar & Navigation', _buildAppBarPreview(context)),
                _buildComponentCard(context, 'Couleurs du thème', _buildColorsPreview(context, themeModel)),
                _buildComponentCard(context, 'Typographie', _buildTypographyPreview(context)),
                _buildComponentCard(context, 'Contrôles de sélection', _buildSelectionControlsPreview(context)),
                _buildComponentCard(context, 'Dialogues & Snackbars', _buildDialogPreview(context)),
              ],
            ),
            
            const SizedBox(height: 24),
            _buildComponentSection(context, 'Section complète : FAB & Actions', _buildExtendedFabPreview(context)),
            const SizedBox(height: 24),
            _buildComponentSection(context, 'Section complète : Listes', _buildListPreview(context)),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
  
  Widget _buildComponentCard(BuildContext context, String title, Widget content) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            Expanded(child: Center(child: content)),
          ],
        ),
      ),
    );
  }
  
  Widget _buildComponentSection(BuildContext context, String title, Widget content) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }
  
  // Prévisualisations des composants
  
  Widget _buildButtonsPreview(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        FilledButton(
          onPressed: () {},
          child: const Text('Filled'),
        ),
        FilledButton.tonal(
          onPressed: () {},
          child: const Text('Tonal'),
        ),
        OutlinedButton(
          onPressed: () {},
          child: const Text('Outlined'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Elevated'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Text'),
        ),
      ],
    );
  }
  
  Widget _buildTextFieldsPreview(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Champ standard',
            hintText: 'Saisissez du texte',
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            labelText: 'Champ avec icône',
            hintText: 'Recherche',
            prefixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
  
  Widget _buildCardsPreview(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.album),
            title: const Text('Card avec ListTile'),
            subtitle: const Text('Description secondaire'),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Card avec contenu personnalisé'),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('ANNULER'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('ACCEPTER'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildAppBarPreview(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 64,
          color: Theme.of(context).colorScheme.primary,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.onPrimary),
                onPressed: () {},
              ),
              Text(
                'Exemple d\'AppBar',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.more_vert, color: Theme.of(context).colorScheme.onPrimary),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          color: Theme.of(context).colorScheme.surface,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildColorsPreview(BuildContext context, ThemeModel themeModel) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      shrinkWrap: true,
      children: [
        _buildColorTile(context, 'P', Theme.of(context).colorScheme.primary),
        _buildColorTile(context, 'PC', Theme.of(context).colorScheme.primaryContainer),
        _buildColorTile(context, 'S', Theme.of(context).colorScheme.secondary),
        _buildColorTile(context, 'SC', Theme.of(context).colorScheme.secondaryContainer),
        _buildColorTile(context, 'T', Theme.of(context).colorScheme.tertiary),
        _buildColorTile(context, 'TC', Theme.of(context).colorScheme.tertiaryContainer),
        _buildColorTile(context, 'E', Theme.of(context).colorScheme.error),
        _buildColorTile(context, 'Bg', Theme.of(context).colorScheme.background),
        _buildColorTile(context, 'Su', Theme.of(context).colorScheme.surface),
      ],
    );
  }
  
  Widget _buildColorTile(BuildContext context, String label, Color color) {
    final onColor = color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    
    return Container(
      color: color,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: onColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  
  Widget _buildTypographyPreview(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Text('Display Large', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20)),
        Text('Display Medium', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 18)),
        Text('Display Small', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 16)),
        Text('Headline Large', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 16)),
        Text('Headline Medium', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 14)),
        Text('Title Large', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14)),
        Text('Title Medium', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12)),
        Text('Body Large', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12)),
        Text('Body Medium', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 10)),
      ],
    );
  }
  
  Widget _buildSelectionControlsPreview(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool checkboxValue = true;
        bool switchValue = true;
        int radioValue = 0;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: checkboxValue,
                  onChanged: (value) => setState(() => checkboxValue = value!),
                ),
                const Text('Checkbox'),
              ],
            ),
            Row(
              children: [
                Switch(
                  value: switchValue,
                  onChanged: (value) => setState(() => switchValue = value),
                ),
                const Text('Switch'),
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 0,
                  groupValue: radioValue,
                  onChanged: (value) => setState(() => radioValue = value!),
                ),
                const Text('Option 1'),
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: radioValue,
                  onChanged: (value) => setState(() => radioValue = value!),
                ),
                const Text('Option 2'),
              ],
            ),
          ],
        );
      },
    );
  }
  
  Widget _buildDialogPreview(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Dialogue d\'alerte'),
                content: const Text('Voici un exemple de dialogue Material 3.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('ANNULER'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: const Text('Afficher dialogue'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Ceci est un exemple de Snackbar'),
                action: SnackBarAction(
                  label: 'OK',
                  onPressed: () {},
                ),
              ),
            );
          },
          child: const Text('Afficher snackbar'),
        ),
      ],
    );
  }
  
  Widget _buildExtendedFabPreview(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.small(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 16),
              FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 16),
              FloatingActionButton.extended(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Créer'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text('Actions segmentées'),
          const SizedBox(height: 8),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment<int>(value: 0, label: Text('Jour')),
              ButtonSegment<int>(value: 1, label: Text('Semaine')),
              ButtonSegment<int>(value: 2, label: Text('Mois')),
            ],
            selected: const {0},
            onSelectionChanged: (Set<int> newSelection) {},
          ),
        ],
      ),
    );
  }
  
  Widget _buildListPreview(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text('${index + 1}'),
          ),
          title: Text('Élément de liste ${index + 1}'),
          subtitle: const Text('Description secondaire'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        );
      },
    );
  }
}