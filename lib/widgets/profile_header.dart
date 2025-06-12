import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('14:00', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  elevation: 0,
                ),
                child: const Text('宠物管理', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage('images/dog_avatar.png'),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('聂宇旋', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      Icon(Icons.crop, color: Theme.of(context).primaryColor, size: 20),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('已陪伴 xx 天', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  const Text('1岁2个月萨摩耶 | 12KG', style: TextStyle(fontSize: 14, color: Colors.black54)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
} 