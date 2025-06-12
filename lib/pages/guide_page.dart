import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_GuideItem> items = [
      _GuideItem(icon: Icons.schedule, title: '定时喂食', desc: '给宠物定时定量喂食，保持规律饮食习惯。'),
      _GuideItem(icon: Icons.water_drop, title: '饮水充足', desc: '保证宠物随时有干净的饮用水。'),
      _GuideItem(icon: Icons.restaurant, title: '营养均衡', desc: '选择适合宠物年龄和体型的优质粮食，适当补充营养品。'),
      _GuideItem(icon: Icons.directions_run, title: '适量运动', desc: '每天带宠物适当运动，保持健康体重。'),
      _GuideItem(icon: Icons.medical_services, title: '定期体检', desc: '定期带宠物去医院体检，预防疾病。'),
      _GuideItem(icon: Icons.clean_hands, title: '清洁卫生', desc: '保持宠物生活环境和餐具清洁，预防寄生虫。'),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('喂养指南', style: TextStyle(color: Colors.white, fontSize: 20)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, i) {
          final item = items[i];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(item.icon, color: Theme.of(context).primaryColor, size: 36),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 6),
                      Text(item.desc, style: const TextStyle(fontSize: 15, color: Colors.black87)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _GuideItem {
  final IconData icon;
  final String title;
  final String desc;
  _GuideItem({required this.icon, required this.title, required this.desc});
} 