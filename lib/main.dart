import 'package:flutter/material.dart';
import 'models/profile_data.dart';
import 'pages/profile_page.dart';
import 'services/pref_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await PrefService.init();
  await prefs.increaseOpenCount();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.prefs});
  final PrefService prefs;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ValueNotifier<bool> _isDark =
      ValueNotifier(widget.prefs.isDarkMode);
  late final ValueNotifier<ProfileData> _profile =
      ValueNotifier(widget.prefs.profile);

  void _changeTheme(bool value) {
    _isDark.value = value;
    widget.prefs.setDarkMode(value);
  }

  void _updateProfile(ProfileData newProfile) {
    _profile.value = newProfile;
    widget.prefs.saveProfile(newProfile);
  }

  @override
  void dispose() {
    _isDark.dispose();
    _profile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isDark,
      builder: (context, isDark, _) {
        return ValueListenableBuilder<ProfileData>(
          valueListenable: _profile,
          builder: (context, profile, _) {
            return MaterialApp(
              title: 'Kartu Profil Digital',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(colorSchemeSeed: Colors.indigo),
              darkTheme: ThemeData(
                colorSchemeSeed: Colors.indigo,
                brightness: Brightness.dark,
              ),
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              home: ProfilePage(
                prefs: widget.prefs,
                profile: profile,
                isDark: isDark,
                onThemeChanged: _changeTheme,
                onProfileChanged: _updateProfile,
              ),
            );
          },
        );
      },
    );
  }
}