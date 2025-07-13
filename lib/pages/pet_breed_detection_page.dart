import 'package:flutter/material.dart';

class PetBreedDetectionPage extends StatefulWidget {
  const PetBreedDetectionPage({super.key});

  @override
  State<PetBreedDetectionPage> createState() => _PetBreedDetectionPageState();
}

class _PetBreedDetectionPageState extends State<PetBreedDetectionPage> {
  // 预设的识别结果数据
  final Map<String, dynamic> _detectionResult = {
    'breed': '萨摩耶犬',
    'confidence': 0.92,
    'characteristics': [
      '友善、活泼、聪明',
      '白色蓬松被毛',
      '嘴角上扬似微笑',
      '适应寒冷气候',
    ],
    'careInfo': [
      '需要定期梳理被毛',
      '需要充分运动',
      '易患皮肤问题',
      '适合凉爽气候',
    ],
    'similarBreeds': [
      {'name': '日本尖嘴犬', 'similarity': 0.75},
      {'name': '美国爱斯基摩犬', 'similarity': 0.68},
      {'name': '白色瑞士牧羊犬', 'similarity': 0.62},
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('宠物品种识别'),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 顶部提示区域
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.amber.withOpacity(0.2),
              child: const Text(
                '智能AI识别宠物品种，提供品种特征和护理建议',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            
            // 图片显示区域
            Container(
              height: 300,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'img/dog1.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // 识别结果区域
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 识别结果标题
                  Row(
                    children: [
                      const Icon(Icons.pets, color: Colors.amber),
                      const SizedBox(width: 10),
                      const Text(
                        '识别结果',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '可信度: ${(_detectionResult['confidence'] * 100).toInt()}%',
                          style: TextStyle(color: Colors.green.shade700),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  
                  // 品种名称
                  Text(
                    _detectionResult['breed'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // 特征描述
                  const Text(
                    '品种特征:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...(_detectionResult['characteristics'] as List).map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, size: 16, color: Colors.green),
                          const SizedBox(width: 10),
                          Text(item),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                  
                  // 护理信息
                  const Text(
                    '护理建议:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...(_detectionResult['careInfo'] as List).map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info_outline, size: 16, color: Colors.blue),
                          const SizedBox(width: 10),
                          Expanded(child: Text(item)),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                  
                  // 相似品种
                  const Text(
                    '相似品种:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...(_detectionResult['similarBreeds'] as List).map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Text(item['name']),
                          const Spacer(),
                          Text(
                            '相似度: ${(item['similarity'] * 100).toInt()}%',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            // 底部按钮
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('更多品种识别功能开发中')),
                        );
                      },
                      icon: const Icon(Icons.photo_library),
                      label: const Text('更多品种'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('分享功能开发中')),
                        );
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('分享结果'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 