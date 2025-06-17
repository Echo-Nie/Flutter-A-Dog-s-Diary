import 'package:flutter/material.dart';
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
        title: const Text('设置'),
        backgroundColor: theme.primaryColor,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('个人信息'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileEditPage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.pets),
            title: const Text('宠物管理'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PetManagementPage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('主题设置'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showThemeDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('语言设置'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLanguageDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('通知设置'),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('关于'),
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
              child: const Text('退出登录'),
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
          Colors.amber: '橙黄',
          Colors.blue: '蓝色',
          Colors.green: '绿色',
          Colors.red: '红色',
          Colors.purple: '紫色',
          Colors.teal: '青色',
          Colors.orange: '橙色',
        };
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('选择主题色', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('选择语言', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('中文'),
                onTap: () {
                  Provider.of<LocaleNotifier>(context, listen: false).setLocale(const Locale('zh'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('English'),
                onTap: () {
                  Provider.of<LocaleNotifier>(context, listen: false).setLocale(const Locale('en'));
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