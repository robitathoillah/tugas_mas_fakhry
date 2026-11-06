import 'package:flutter/material.dart';
import '../models/profile_data.dart';
import '../services/pref_service.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.prefs,
    required this.profile,
    required this.isDark,
    required this.onThemeChanged,
    required this.onProfileChanged,
  });

  final PrefService prefs;
  final ProfileData profile;
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<ProfileData> onProfileChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Profil Digital'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push<ProfileData>(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(initialProfile: profile),
                ),
              );
              if (result != null) {
                onProfileChanged(result);
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: colors.primaryContainer,
                    child: Text(
                      profile.name.isNotEmpty ? profile.name[0].toUpperCase() : 'U',
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    profile.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(profile.title),
                  const SizedBox(height: 12),
                  Text(profile.bio, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Mode Gelap'),
            value: isDark,
            onChanged: onThemeChanged,
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'Kartu ini sudah dibuka ${prefs.openCount} kali',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}