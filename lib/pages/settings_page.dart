import 'package:flutter/material.dart';
import 'package:lakes6/localizations/app_localizations.dart';
import 'package:provider/provider.dart';
import '../theme_notifier.dart';
import '../locale_notifier.dart';
import 'profile_edit_page.dart';
import 'pet_management_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate('settings')),
        backgroundColor: theme.primaryColor,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(context.translate('personalInfo')),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileEditPage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.pets),
            title: Text(context.translate('petManagement')),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PetManagementPage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(context.translate('themeSettings')),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showThemeDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(context.translate('languageSettings')),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLanguageDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(context.translate('notificationSettings')),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(context.translate('about')),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text(context.translate('logout')),
            ),
          ),
        ],
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final theme = Provider.of<ThemeNotifier>(context);
        final colors = <MaterialColor, String>{
          Colors.amber: context.translate('amber'),
          Colors.blue: context.translate('blue'),
          Colors.green: context.translate('green'),
          Colors.red: context.translate('red'),
          Colors.purple: context.translate('purple'),
          Colors.teal: context.translate('teal'),
          Colors.orange: context.translate('orange'),
        };
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.translate('selectTheme'),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: colors.entries.map((entry) {
                  final color = entry.key;
                  final label = entry.value;
                  final selected = theme.color == color;
                  return GestureDetector(
                    onTap: () {
                      theme.setColor(color);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: selected ? 28 : 24,
                          backgroundColor: color,
                          child: selected ? const Icon(Icons.check, color: Colors.white) : null,
                        ),
                        const SizedBox(height: 6),
                        Text(label, style: TextStyle(color: selected ? color : Colors.black87)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final localeNotifier = Provider.of<LocaleNotifier>(context);
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.translate('selectLanguage'),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 16),
              ListTile(
                title: Text(context.translate('chinese')),
                trailing: localeNotifier.locale.languageCode == 'zh'
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  localeNotifier.setLocale(const Locale('zh'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(context.translate('english')),
                trailing: localeNotifier.locale.languageCode == 'en'
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  localeNotifier.setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
} 