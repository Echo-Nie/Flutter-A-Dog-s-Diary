import 'package:flutter/material.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('健康管理', style: TextStyle(color: Colors.white, fontSize: 20)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: '基本信息'),
            Tab(text: '疫苗记录'),
            Tab(text: '健康检查'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _BasicInfoTab(),
          _VaccineTab(),
          _HealthCheckTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final currentIndex = _tabController.index;
          switch (currentIndex) {
            case 0:
              _showBasicInfoDialog();
              break;
            case 1:
              _showVaccineDialog();
              break;
            case 2:
              _showHealthCheckDialog();
              break;
          }
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
  
  void _showBasicInfoDialog() {
    // 对话框逻辑将在后续添加
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加基本信息'),
        content: const Text('功能开发中...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }
  
  void _showVaccineDialog() {
    // 对话框逻辑将在后续添加
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加疫苗记录'),
        content: const Text('功能开发中...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }
  
  void _showHealthCheckDialog() {
    // 对话框逻辑将在后续添加
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加健康检查'),
        content: const Text('功能开发中...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }
}

class _BasicInfoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoCard(
            title: '基本信息',
            content: const [
              _InfoItem(label: '宠物名称', value: '皮皮'),
              _InfoItem(label: '品种', value: '萨摩耶'),
              _InfoItem(label: '出生日期', value: '2023年3月15日'),
              _InfoItem(label: '性别', value: '公'),
              _InfoItem(label: '绝育情况', value: '已绝育'),
              _InfoItem(label: '芯片号', value: 'CH12345678'),
            ],
          ),
          const SizedBox(height: 16),
          _InfoCard(
            title: '饮食习惯',
            content: const [
              _InfoItem(label: '主粮', value: '皇家幼犬粮'),
              _InfoItem(label: '零食', value: '鸡肉干、牛肉条'),
              _InfoItem(label: '日喂食量', value: '200g'),
              _InfoItem(label: '喂食次数', value: '早晚各一次'),
              _InfoItem(label: '饮水习惯', value: '自由饮水'),
            ],
          ),
          const SizedBox(height: 16),
          _InfoCard(
            title: '过敏信息',
            content: const [
              _InfoItem(label: '食物过敏', value: '鸡蛋、牛奶'),
              _InfoItem(label: '药物过敏', value: '无'),
              _InfoItem(label: '环境过敏', value: '花粉'),
            ],
          ),
        ],
      ),
    );
  }
}

class _VaccineTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _VaccineCard(
          vaccineName: '狂犬疫苗',
          date: '2023年4月15日',
          nextDate: '2024年4月15日',
          hospital: '爱宠动物医院',
          notes: '首次接种',
        ),
        _VaccineCard(
          vaccineName: '六联疫苗',
          date: '2023年5月20日',
          nextDate: '2024年5月20日',
          hospital: '爱宠动物医院',
          notes: '首次接种',
        ),
        _VaccineCard(
          vaccineName: '犬瘟热疫苗',
          date: '2023年6月25日',
          nextDate: '2024年6月25日',
          hospital: '爱宠动物医院',
          notes: '首次接种',
        ),
      ],
    );
  }
}

class _HealthCheckTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _HealthCheckCard(
          date: '2023年7月15日',
          hospital: '爱宠动物医院',
          items: const ['体格检查', '血常规', '心脏检查'],
          result: '健康状况良好',
          notes: '建议定期驱虫',
        ),
        _HealthCheckCard(
          date: '2023年10月20日',
          hospital: '爱宠动物医院',
          items: const ['体格检查', '牙齿检查', '皮肤检查'],
          result: '牙结石轻微',
          notes: '建议注意口腔卫生',
        ),
        _HealthCheckCard(
          date: '2024年1月25日',
          hospital: '爱宠动物医院',
          items: const ['体格检查', '血常规', '尿检'],
          result: '健康状况良好',
          notes: '无异常',
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<Widget> content;

  const _InfoCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...content,
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: TextStyle(color: Colors.grey[700])),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _VaccineCard extends StatelessWidget {
  final String vaccineName;
  final String date;
  final String nextDate;
  final String hospital;
  final String notes;

  const _VaccineCard({
    required this.vaccineName,
    required this.date,
    required this.nextDate,
    required this.hospital,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(vaccineName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _rowItem('接种日期', date),
            _rowItem('下次接种', nextDate),
            _rowItem('接种医院', hospital),
            _rowItem('备注', notes),
          ],
        ),
      ),
    );
  }

  Widget _rowItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: TextStyle(color: Colors.grey[700])),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _HealthCheckCard extends StatelessWidget {
  final String date;
  final String hospital;
  final List<String> items;
  final String result;
  final String notes;

  const _HealthCheckCard({
    required this.date,
    required this.hospital,
    required this.items,
    required this.result,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('健康检查 - $date', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _rowItem('检查医院', hospital),
            _rowItem('检查项目', items.join(', ')),
            _rowItem('检查结果', result),
            _rowItem('医生建议', notes),
          ],
        ),
      ),
    );
  }

  Widget _rowItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: TextStyle(color: Colors.grey[700])),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
} 