import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_notifier.dart';
import '../locale_notifier.dart';
import 'notifications_page.dart';
import 'settings_page.dart';
import 'profile_edit_page.dart';
import 'pet_management_page.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('我的', style: TextStyle(color: Colors.white, fontSize: 20)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationsPage()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: theme.primaryColor,
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileEditPage()),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 24),
                      CircleAvatar(
                        radius: 36,
                        backgroundImage: const AssetImage('img/dog_avatar.png'),
                        backgroundColor: theme.primaryColor,
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text('聂宇旋', style: TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.white),
                      const SizedBox(width: 24),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(count: '1', label: '获赞', color: theme.primaryColor),
                      _StatItem(count: '2', label: '粉丝', color: theme.primaryColor),
                      _StatItem(count: '1', label: '关注', color: theme.primaryColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('我的宠物', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: theme.primaryColor)),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PetManagementPage()),
                  ),
                  child: Text('全部', style: TextStyle(color: theme.primaryColor.withOpacity(0.7))),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 2,
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: const AssetImage('img/dog_avatar.png'),
                          backgroundColor: theme.primaryColor.withOpacity(0.1),
                        ),
                        const SizedBox(height: 8),
                        Text('皮皮', style: TextStyle(fontWeight: FontWeight.bold, color: theme.primaryColor)),
                        const Text('1岁3个月', style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 2,
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: const AssetImage('img/dog2.png'),
                          backgroundColor: theme.primaryColor.withOpacity(0.1),
                        ),
                        const SizedBox(height: 8),
                        Text('球球', style: TextStyle(fontWeight: FontWeight.bold, color: theme.primaryColor)),
                        const Text('1岁1个月', style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _SettingItem(
                  title: '主题设置',
                  onTap: () => _showThemeDialog(context),
                  color: theme.primaryColor,
                ),
                _SettingItem(
                  title: '语言设置',
                  onTap: () => _showLanguageDialog(context),
                  color: theme.primaryColor,
                ),
                _SettingItem(
                  title: '退出登录',
                  color: theme.primaryColor,
                ),
              ],
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

class _StatItem extends StatelessWidget {
  final String count;
  final String label;
  final Color color;

  const _StatItem({
    required this.count,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(count, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: color)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: color.withOpacity(0.7))),
        ],
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color color;

  const _SettingItem({
    required this.title,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyle(color: color)),
      trailing: Icon(Icons.chevron_right, color: color),
      onTap: onTap,
      shape: const Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
      tileColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      minVerticalPadding: 0,
    );
  }
} 