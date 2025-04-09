import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aperçu Mobile',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            
            // Cadre simulant un appareil mobile
            Center(
              child: PhoneFrame(
                child: _MobileAppSimulation(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget simulant un cadre de téléphone
class PhoneFrame extends StatelessWidget {
  final Widget child;
  
  const PhoneFrame({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Dimensions simulant un smartphone standard
    const double frameWidth = 360.0;
    const double frameHeight = 640.0;
    const double frameRadius = 32.0;
    
    return Container(
      width: frameWidth,
      height: frameHeight,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(frameRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(frameRadius - 8),
          child: child,
        ),
      ),
    );
  }
}

// Simulation d'une application mobile
class _MobileAppSimulation extends StatefulWidget {
  @override
  State<_MobileAppSimulation> createState() => _MobileAppSimulationState();
}

class _MobileAppSimulationState extends State<_MobileAppSimulation> {
  int _currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    
    // Liste des vues différentes dans l'application mobile simulée
    final List<Widget> _screens = [
      _buildHomeScreen(),
      _buildExploreScreen(),
      _buildProfileScreen(),
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyApp Mobile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explorer',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
  
  // Écran d'accueil simulé
  Widget _buildHomeScreen() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                height: 150,
                color: Theme.of(context).colorScheme.primaryContainer,
                alignment: Alignment.center,
                child: Icon(
                  Icons.image,
                  size: 80,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Titre de l\'article principal',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Description détaillée de l\'article ou du contenu présenté. Ceci est un exemple de texte pour démontrer l\'apparence des cartes Material 3.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('PARTAGER'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton(
                          onPressed: () {},
                          child: const Text('LIRE'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionTitle('Tendances'),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 12),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.photo,
                          size: 40,
                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Élément ${index + 1}',
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Description courte',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionTitle('Pour vous'),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                child: const Icon(Icons.article),
              ),
              title: Text('Recommandation ${index + 1}'),
              subtitle: Text('Sous-titre de l\'élément ${index + 1}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            );
          },
        ),
      ],
    );
  }
  
  // Écran Explorer simulé
  Widget _buildExploreScreen() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    color: [
                      Theme.of(context).colorScheme.primaryContainer,
                      Theme.of(context).colorScheme.secondaryContainer,
                      Theme.of(context).colorScheme.tertiaryContainer,
                      Theme.of(context).colorScheme.errorContainer,
                    ][index % 4],
                    alignment: Alignment.center,
                    child: Icon(
                      [Icons.image, Icons.favorite, Icons.star, Icons.bookmark][index % 4],
                      size: 50,
                      color: [
                        Theme.of(context).colorScheme.onPrimaryContainer,
                        Theme.of(context).colorScheme.onSecondaryContainer,
                        Theme.of(context).colorScheme.onTertiaryContainer,
                        Theme.of(context).colorScheme.onErrorContainer,
                      ][index % 4],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Catégorie ${index + 1}',
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${(index + 2) * 10} éléments',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  // Écran Profil simulé
  Widget _buildProfileScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          // Photo de profil
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(
              Icons.person,
              size: 50,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Nom d\'utilisateur',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'utilisateur@example.com',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          _buildProfileStat(),
          const SizedBox(height: 24),
          _buildProfileActions(),
          const SizedBox(height: 24),
          _buildSectionTitle('Activités récentes'),
          const SizedBox(height: 8),
          _buildActivityList(),
        ],
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
  
  Widget _buildProfileStat() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('Posts', '42'),
            _buildStatItem('Followers', '1.2K'),
            _buildStatItem('Following', '567'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
  
  Widget _buildProfileActions() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.primary),
            title: const Text('Paramètres'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: Icon(Icons.security, color: Theme.of(context).colorScheme.primary),
            title: const Text('Confidentialité'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: Icon(Icons.help_outline, color: Theme.of(context).colorScheme.primary),
            title: const Text('Aide & Support'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
  
  Widget _buildActivityList() {
    return Card(
      child: Column(
        children: List.generate(
          4,
          (index) => Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  child: const Icon(Icons.history),
                ),
                title: Text('Activité ${index + 1}'),
                subtitle: const Text('Il y a 2 heures'),
                onTap: () {},
              ),
              if (index < 3) const Divider(height: 1, indent: 70),
            ],
          ),
        ),
      ),
    );
  }
}