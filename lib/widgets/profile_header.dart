import 'package:flutter/material.dart';
import '../pages/pet_management_page.dart';

class ProfileHeader extends StatelessWidget {
  final String currentTime;
  final DateTime petBirthday = DateTime(2023, 3, 15); // 假设宠物的生日是2023年3月15日
  
  ProfileHeader({super.key, required this.currentTime});

  int _calculateDaysWithPet() {
    final now = DateTime.now();
    return now.difference(petBirthday).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final daysWithPet = _calculateDaysWithPet();
    
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
              Text(currentTime, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const PetManagementPage()),
                  );
                },
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
                backgroundImage: AssetImage('img/dog_avatar.png'),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('聂宇旋', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(width: 4),
                      Icon(Icons.crop, color: Colors.white, size: 20),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('已陪伴 $daysWithPet 天', style: const TextStyle(fontSize: 16, color: Colors.white)),
                  const SizedBox(height: 4),
                  const Text('1岁2个月萨摩耶 | 12KG', style: TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
} 