import 'package:flutter/material.dart';
import 'pet_card.dart';

class TabSection extends StatefulWidget {
  const TabSection({super.key});

  @override
  State<TabSection> createState() => _TabSectionState();
}

class _TabSectionState extends State<TabSection> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _tabIndex = 0),
                child: Text('关注',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _tabIndex == 0 ? Colors.black : Colors.black38)),
              ),
              const SizedBox(width: 24),
              GestureDetector(
                onTap: () => setState(() => _tabIndex = 1),
                child: Text('推荐',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _tabIndex == 1 ? Colors.amber : Colors.black38)),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
            children: const [
              PetCard(
                avatar: 'img/dog1.png',
                user: '聂宇旋1号',
                tag: '#狗狗喂养心得',
                tagColor: Color(0xFFFFF9C4),
                content: '必备物品💖：xxx',
                like: 40,
                view: 2,
                image: 'img/dog1.png',
              ),
              PetCard(
                avatar: 'img/dog2.png',
                user: '聂宇旋2号',
                tag: '#推荐',
                tagColor: Color(0xFFFFF9C4),
                content: '宠物喂养专用净味器，终于拿下了！',
                like: 39,
                view: 1,
                image: 'img/dog2.png',
              ),
            ],
          ),
        ),
      ],
    );
  }
} 