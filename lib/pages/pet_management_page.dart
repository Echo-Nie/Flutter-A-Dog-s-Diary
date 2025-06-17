import 'package:flutter/material.dart';

class PetManagementPage extends StatefulWidget {
  const PetManagementPage({super.key});

  @override
  State<PetManagementPage> createState() => _PetManagementPageState();
}

class _PetManagementPageState extends State<PetManagementPage> {
  final List<Map<String, dynamic>> _pets = [
    {
      'name': '皮皮',
      'age': '1岁3个月',
      'image': 'img/dog_avatar.png',
      'breed': '金毛',
      'weight': '25.5',
      'birthday': '2023-01-15',
    },
    {
      'name': '球球',
      'age': '1岁1个月',
      'image': 'img/dog2.png',
      'breed': '拉布拉多',
      'weight': '28.0',
      'birthday': '2023-03-20',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('宠物管理'),
        backgroundColor: theme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddPetDialog(context),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _pets.length,
        itemBuilder: (context, index) {
          final pet = _pets[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(pet['image']),
                        backgroundColor: theme.primaryColor.withOpacity(0.1),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pet['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              pet['age'],
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showEditPetDialog(context, index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteConfirmDialog(context, index),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoItem(Icons.pets, '品种', pet['breed']),
                      _buildInfoItem(Icons.monitor_weight, '体重', '${pet['weight']}kg'),
                      _buildInfoItem(Icons.cake, '生日', pet['birthday']),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _showAddPetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加宠物'),
        content: const Text('此功能正在开发中...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _showEditPetDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑宠物信息'),
        content: const Text('此功能正在开发中...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除${_pets[index]['name']}吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _pets.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('删除成功')),
              );
            },
            child: const Text('确定', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
} 