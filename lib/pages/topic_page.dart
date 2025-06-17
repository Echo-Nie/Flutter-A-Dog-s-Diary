import 'package:flutter/material.dart';
import 'topic_detail_page.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({super.key});

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = '';
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// 初始化语音识别
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// 开始语音识别
  void _startListening() async {
    if (_speechEnabled) {
      setState(() {
        _isListening = true;
      });
      await _speechToText.listen(
        onResult: _onSpeechResult,
        localeId: 'zh_CN', // 设置为中文识别
      );
    }
  }

  /// 停止语音识别
  void _stopListening() async {
    if (_speechEnabled) {
      await _speechToText.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  /// 处理语音识别结果
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _searchController.text = result.recognizedWords;
      _searchQuery = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 根据搜索条件过滤话题
    List<int> filteredTopics = List.generate(10, (index) => index);
    
    // 应用搜索关键词筛选
    if (_searchQuery.isNotEmpty) {
      filteredTopics = filteredTopics.where((index) {
        final title = _getTopicTitle(index).toLowerCase();
        final description = _getTopicDescription(index).toLowerCase();
        final tags = _getTopicTags(index).join(' ').toLowerCase();
        final query = _searchQuery.toLowerCase();
        return title.contains(query) || description.contains(query) || tags.contains(query);
      }).toList();
    }

    // 应用分类筛选
    if (_selectedCategory.isNotEmpty) {
      filteredTopics = filteredTopics.where((index) {
        if (_selectedCategory == '医疗') {
          return _getTopicTags(index).contains('医疗');
        } else if (_selectedCategory == '经验') {
          return _getTopicTags(index).contains('经验分享') || _getTopicTitle(index).contains('经验');
        } else if (_selectedCategory == '求助') {
          return _getTopicTitle(index).contains('怎么办') || _getTopicTitle(index).contains('如何');
        } else if (_selectedCategory == '晒宠') {
          return _getTopicTitle(index).contains('晒');
        } else if (_selectedCategory == '热门') {
          // 热门标签不过滤，默认显示所有
          return true;
        }
        return false;
      }).toList();
    }

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
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '搜索宠物话题、经验分享...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 语音输入按钮
                    IconButton(
                      icon: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        color: _isListening ? Theme.of(context).primaryColor : Colors.grey,
                      ),
                      onPressed: _speechEnabled
                          ? (_isListening ? _stopListening : _startListening)
                          : null,
                      tooltip: _isListening ? '停止语音输入' : '语音输入',
                    ),
                    // 清除按钮
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                        tooltip: '清除',
                      ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              onSubmitted: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          
          // 语音识别状态提示
          if (_isListening)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.mic, color: Theme.of(context).primaryColor, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          '正在聆听...',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _stopListening,
                    child: const Text('取消'),
                  ),
                ],
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
          filteredTopics.isEmpty 
              ? Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          '没有找到相关话题',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '尝试使用其他关键词搜索',
                          style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredTopics.length,
                    itemBuilder: (context, i) {
                      final index = filteredTopics[i];
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

  Widget _buildCategoryItem(String title, IconData icon, Color color) {
    final isSelected = _selectedCategory == title;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedCategory == title) {
            _selectedCategory = ''; // 取消选择
          } else {
            _selectedCategory = title; // 选择新类别
          }
        });
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.3) : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : color.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
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
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
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