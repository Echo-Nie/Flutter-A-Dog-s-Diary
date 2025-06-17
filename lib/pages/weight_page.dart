import 'package:flutter/material.dart';
import 'dart:math' as math;

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  final List<WeightRecord> _records = [
    WeightRecord(date: DateTime(2023, 7, 1), weight: 8.5),
    WeightRecord(date: DateTime(2023, 8, 1), weight: 9.2),
    WeightRecord(date: DateTime(2023, 9, 1), weight: 10.0),
    WeightRecord(date: DateTime(2023, 10, 1), weight: 10.8),
    WeightRecord(date: DateTime(2023, 11, 1), weight: 11.3),
    WeightRecord(date: DateTime(2023, 12, 1), weight: 11.7),
    WeightRecord(date: DateTime(2024, 1, 1), weight: 12.0),
  ];

  @override
  Widget build(BuildContext context) {
    // 计算平均体重
    double avgWeight = 0;
    if (_records.isNotEmpty) {
      avgWeight = _records.map((r) => r.weight).reduce((a, b) => a + b) / _records.length;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('体重记录', style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      body: Column(
        children: [
          // 体重统计卡片
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: '当前体重',
                        value: '${_records.isNotEmpty ? _records.last.weight : 0} kg',
                        icon: Icons.monitor_weight,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _StatCard(
                        title: '平均体重',
                        value: '${avgWeight.toStringAsFixed(1)} kg',
                        icon: Icons.insights,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 150,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: _WeightChart(records: _records),
                ),
              ],
            ),
          ),

          // 体重记录列表
          Expanded(
            child: _records.isEmpty
                ? const Center(child: Text('暂无体重记录', style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _records.length,
                    itemBuilder: (context, index) {
                      final reversedIndex = _records.length - 1 - index;
                      final record = _records[reversedIndex];
                      final prevWeight = reversedIndex < _records.length - 1 ? _records[reversedIndex + 1].weight : record.weight;
                      final weightChange = record.weight - prevWeight;
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              // 日期
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${record.date.year}/${record.date.month}/${record.date.day}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  Text(
                                    '${_getWeekdayName(record.date.weekday)}',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              // 体重和变化
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${record.weight} kg',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  if (reversedIndex < _records.length - 1)
                                    Row(
                                      children: [
                                        Icon(
                                          weightChange > 0 ? Icons.arrow_upward : Icons.arrow_downward,
                                          size: 14,
                                          color: weightChange > 0 ? Colors.red : Colors.green,
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          '${weightChange.abs().toStringAsFixed(1)} kg',
                                          style: TextStyle(
                                            color: weightChange > 0 ? Colors.red : Colors.green,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddWeightDialog(),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case 1: return '周一';
      case 2: return '周二';
      case 3: return '周三';
      case 4: return '周四';
      case 5: return '周五';
      case 6: return '周六';
      case 7: return '周日';
      default: return '';
    }
  }

  void _showAddWeightDialog() {
    final weightController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加体重记录'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text('日期：'),
                TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  child: Text('${selectedDate.year}/${selectedDate.month}/${selectedDate.day}'),
                ),
              ],
            ),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                labelText: '体重 (kg)',
                hintText: '请输入体重',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              if (weightController.text.isNotEmpty) {
                final weight = double.parse(weightController.text);
                setState(() {
                  _records.add(WeightRecord(date: selectedDate, weight: weight));
                  _records.sort((a, b) => a.date.compareTo(b.date));
                });
                Navigator.pop(context);
              }
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(color: color, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      ),
    );
  }
}

class _WeightChart extends StatelessWidget {
  final List<WeightRecord> records;

  const _WeightChart({required this.records});

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return const Center(child: Text('暂无数据'));
    }

    // 找出最大和最小体重，用于确定图表的比例
    final minWeight = records.map((r) => r.weight).reduce(math.min);
    final maxWeight = records.map((r) => r.weight).reduce(math.max);
    final range = maxWeight - minWeight;
    final adjustedMin = minWeight - range * 0.1;
    final adjustedMax = maxWeight + range * 0.1;
    final adjustedRange = adjustedMax - adjustedMin;

    return CustomPaint(
      painter: _ChartPainter(
        records: records,
        minWeight: adjustedMin,
        maxWeight: adjustedMax,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final List<WeightRecord> records;
  final double minWeight;
  final double maxWeight;
  final Color color;

  _ChartPainter({
    required this.records,
    required this.minWeight,
    required this.maxWeight,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final width = size.width;
    final height = size.height;
    final xStep = width / (records.length - 1);

    for (int i = 0; i < records.length; i++) {
      final record = records[i];
      final x = i * xStep;
      final normalizedY = 1 - (record.weight - minWeight) / (maxWeight - minWeight);
      final y = normalizedY * height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // 绘制点
      canvas.drawCircle(Offset(x, y), 4, dotPaint);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class WeightRecord {
  final DateTime date;
  final double weight;

  WeightRecord({required this.date, required this.weight});
} 