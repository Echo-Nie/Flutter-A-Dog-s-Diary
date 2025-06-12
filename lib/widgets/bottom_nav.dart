import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: SizedBox(
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(icon: Icons.home, label: '首页', selected: true),
            _NavItem(icon: Icons.explore, label: '发现'),
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.amber,
              child: const Icon(Icons.add, color: Colors.white),
              elevation: 2,
            ),
            _NavItem(icon: Icons.forum, label: '话题'),
            _NavItem(icon: Icons.person, label: '我的'),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  const _NavItem({required this.icon, required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: selected ? Colors.amber : Colors.grey),
        Text(label, style: TextStyle(color: selected ? Colors.amber : Colors.grey, fontSize: 12)),
      ],
    );
  }
} 