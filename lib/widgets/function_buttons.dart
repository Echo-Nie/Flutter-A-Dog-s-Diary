import 'package:flutter/material.dart';
import '../pages/calendar_page.dart';
import '../pages/guide_page.dart';
import '../pages/todo_page.dart';

class FunctionButtons extends StatelessWidget {
  const FunctionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CalendarPage()),
              );
            },
            child: _FuncBtn(icon: Icons.calendar_today, label: '签到打卡', color: Theme.of(context).primaryColor),
          ),
          _FuncBtn(icon: Icons.health_and_safety, label: '健康管理', color: Theme.of(context).primaryColor),
          _FuncBtn(icon: Icons.monitor_weight, label: '记录体重', color: Theme.of(context).primaryColor),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const TodoPage()),
              );
            },
            child: _FuncBtn(icon: Icons.edit_note, label: '随笔记录', color: Theme.of(context).primaryColor),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const GuidePage()),
              );
            },
            child: _FuncBtn(icon: Icons.menu_book, label: '喂养指南', color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}

class _FuncBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _FuncBtn({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: color),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
} 