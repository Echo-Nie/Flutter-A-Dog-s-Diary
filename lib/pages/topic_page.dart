import 'package:flutter/material.dart';
import 'topic_detail_page.dart';

class TopicPage extends StatelessWidget {
  const TopicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('话题'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // 搜索栏
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: '搜索宠物话题、经验分享...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.mic),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          
          // 话题分类
          Container(
            height: 110,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryItem('热门', Icons.local_fire_department, Colors.orange),
                _buildCategoryItem('经验', Icons.lightbulb_outline, Colors.blue),
                _buildCategoryItem('求助', Icons.help_outline, Colors.green),
                _buildCategoryItem('晒宠', Icons.pets, Colors.pink),
                _buildCategoryItem('医疗', Icons.medical_services_outlined, Colors.red),
              ],
            ),
          ),

          // 话题列表
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, index) {
                final title = _getTopicTitle(index);
                final description = _getTopicDescription(index);
                final participants = _getRandomNumber(1000, 5000, index);
                final comments = _getRandomNumber(50, 200, index);
                final tags = _getTopicTags(index);
                
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TopicDetailPage(
                          title: title,
                          description: description,
                          participants: participants,
                          comments: comments,
                          tags: tags,
                        ),
                      ),
                    );
                  },
                  child: _buildTopicItem(
                    title: title,
                    description: description,
                    participants: participants,
                    comments: comments,
                    tags: tags,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getTopicTitle(int index) {
    final titles = [
      '新手养猫必看！这些常见问题你遇到过吗？',
      '狗狗挑食怎么办？资深铲屎官分享经验',
      '猫咪绝育后需要注意什么？',
      '如何训练狗狗定点上厕所？',
      '宠物医院避坑指南，这些检查真的必要吗？',
      '猫咪应激反应怎么办？',
      '狗狗皮肤病治疗经验分享',
      '如何给猫咪剪指甲？',
      '宠物保险有必要买吗？',
      '养宠必备好物推荐',
    ];
    return titles[index % titles.length];
  }

  String _getTopicDescription(int index) {
    final descriptions = [
      '分享新手养猫常见问题及解决方案，让新手铲屎官少走弯路...',
      '从饮食调整到行为训练，全方位解决狗狗挑食问题...',
      '专业兽医解答猫咪绝育后的护理要点，让猫咪更快恢复...',
      '科学训练方法分享，让狗狗养成良好习惯...',
      '资深铲屎官总结的宠物医院避坑经验，帮你省钱又安心...',
      '猫咪应激反应的原因及处理方法，让猫咪更健康...',
      '分享治疗狗狗皮肤病的经验，包括用药和护理方法...',
      '安全有效的猫咪剪指甲技巧，让猫咪不再抗拒...',
      '详细分析宠物保险的优缺点，帮你做出明智选择...',
      '实用又实惠的养宠好物推荐，提升养宠体验...',
    ];
    return descriptions[index % descriptions.length];
  }

  List<String> _getTopicTags(int index) {
    final tags = [
      ['新手必看', '经验分享'],
      ['饮食', '训练'],
      ['医疗', '护理'],
      ['训练', '习惯养成'],
      ['医疗', '省钱'],
      ['健康', '护理'],
      ['医疗', '经验分享'],
      ['日常护理', '技巧'],
      ['保险', '建议'],
      ['好物', '推荐'],
    ];
    return tags[index % tags.length];
  }

  int _getRandomNumber(int min, int max, int index) {
    return min + (index % (max - min));
  }

  Widget _buildCategoryItem(String title, IconData icon, Color color) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicItem({
    required String title,
    required String description,
    required int participants,
    required int comments,
    required List<String> tags,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: tags.map((tag) => _buildTag(tag)).toList(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildActionButton(Icons.people_outline, '$participants人参与'),
                const SizedBox(width: 16),
                _buildActionButton(Icons.comment_outlined, '$comments条评论'),
                const Spacer(),
                _buildActionButton(Icons.share_outlined, '分享'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: Colors.blue[700],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
} 