import 'package:flutter/material.dart';
import '../pages/calendar_page.dart';
import '../pages/guide_page.dart';
import '../pages/todo_page.dart';
import '../pages/health_page.dart';
import '../pages/weight_page.dart';
import '../pages/model_download_page.dart';
import '../localizations/app_localizations.dart';

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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const CalendarPage()),
                  );
                },
                child: _FuncBtn(icon: Icons.calendar_today, label: context.translate('checkIn'), color: Theme.of(context).primaryColor),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HealthPage()),
                  );
                },
                child: _FuncBtn(icon: Icons.health_and_safety, label: context.translate('healthManagement'), color: Theme.of(context).primaryColor),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const WeightPage()),
                  );
                },
                child: _FuncBtn(icon: Icons.monitor_weight, label: context.translate('weightTracking'), color: Theme.of(context).primaryColor),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const TodoPage()),
                  );
                },
                child: _FuncBtn(icon: Icons.edit_note, label: context.translate('notes'), color: Theme.of(context).primaryColor),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const GuidePage()),
                  );
                },
                child: _FuncBtn(icon: Icons.menu_book, label: context.translate('feedingGuide'), color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ModelDownloadPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.pets, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 8),
                    Text(
                      context.translate('petBreedDetection'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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