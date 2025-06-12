import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  Set<DateTime> markedDates = {};
  List<_Event> events = [];

  @override
  void initState() {
    super.initState();
    // 默认高亮今天
    markedDates.add(DateTime(today.year, today.month, today.day));
  }

  void _addEvent(DateTime date, String title, String hospital, String result, String desc, DateTime createdTime) {
    setState(() {
      markedDates.add(DateTime(date.year, date.month, date.day));
      events.add(_Event(date: date, title: title, hospital: hospital, result: result, desc: desc, createdTime: createdTime));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('日历记录', style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              _CalendarSection(
                year: today.year,
                month: today.month,
                markedDates: markedDates,
                onTapDay: (date) {
                  setState(() {
                    today = date;
                  });
                },
              ),
              const SizedBox(height: 16),
              _DailyCheckCard(),
              const SizedBox(height: 16),
              ...events
                  .where((e) => e.date.year == today.year && e.date.month == today.month && e.date.day == today.day)
                  .map((e) => _EventCard(
                    event: e,
                    onEdit: (updatedEvent) {
                      setState(() {
                        final idx = events.indexOf(e);
                        if (idx != -1) events[idx] = updatedEvent;
                      });
                    },
                    onDelete: () {
                      setState(() {
                        events.remove(e);
                      });
                    },
                  )),
              _MedicalCard(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<_Event>(
            context: context,
            builder: (context) => _AddEventDialog(selectedDate: today),
          );
          if (result != null) {
            _addEvent(result.date, result.title, result.hospital, result.result, result.desc, result.createdTime);
          }
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class _CalendarSection extends StatelessWidget {
  final int year;
  final int month;
  final Set<DateTime> markedDates;
  final void Function(DateTime) onTapDay;
  const _CalendarSection({required this.year, required this.month, required this.markedDates, required this.onTapDay});

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);
    final weekDayOffset = firstDay.weekday == 7 ? 0 : firstDay.weekday;
    final days = <DateTime?>[];
    for (int i = 0; i < weekDayOffset - 1; i++) {
      days.add(null);
    }
    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(year, month, i));
    }
    while (days.length % 7 != 0) {
      days.add(null);
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('周一'), Text('周二'), Text('周三'), Text('周四'), Text('周五'), Text('周六'), Text('周日'),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 1.2,
            ),
            itemCount: days.length,
            itemBuilder: (context, i) {
              final day = days[i];
              if (day == null) return const SizedBox.shrink();
              final isMarked = markedDates.any((d) => d.year == day.year && d.month == day.month && d.day == day.day);
              return GestureDetector(
                onTap: () => onTapDay(day),
                child: Container(
                  decoration: isMarked
                      ? BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        )
                      : null,
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(fontWeight: isMarked ? FontWeight.bold : FontWeight.normal),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AddEventDialog extends StatefulWidget {
  final DateTime selectedDate;
  const _AddEventDialog({required this.selectedDate});

  @override
  State<_AddEventDialog> createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<_AddEventDialog> {
  late DateTime _date;
  final _titleController = TextEditingController();
  final _hospitalController = TextEditingController();
  final _resultController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _date = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('新建事件'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text('日期：'),
                TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    if (picked != null) setState(() => _date = picked);
                  },
                  child: Text('${_date.year}-${_date.month}-${_date.day}'),
                ),
              ],
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: '标题'),
            ),
            TextField(
              controller: _hospitalController,
              decoration: const InputDecoration(labelText: '医院'),
            ),
            TextField(
              controller: _resultController,
              decoration: const InputDecoration(labelText: '诊断结果'),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: '病情描述'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.isNotEmpty) {
              Navigator.of(context).pop(_Event(
                date: _date,
                title: _titleController.text,
                hospital: _hospitalController.text,
                result: _resultController.text,
                desc: _descController.text,
                createdTime: DateTime.now(),
              ));
            }
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}

class _Event {
  final DateTime date;
  final String title;
  final String hospital;
  final String result;
  final String desc;
  final DateTime createdTime;
  _Event({required this.date, required this.title, required this.hospital, required this.result, required this.desc, required this.createdTime});
}

class _EventCard extends StatelessWidget {
  final _Event event;
  final void Function(_Event) onEdit;
  final VoidCallback? onDelete;
  const _EventCard({required this.event, required this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await showDialog<_EventActionResult>(
          context: context,
          builder: (context) => _EditEventDialog(event: event),
        );
        if (result != null) {
          if (result.deleted) {
            onDelete?.call();
          } else if (result.updatedEvent != null) {
            onEdit(result.updatedEvent!);
          }
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: const Color(0xFFF8F5FC),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(_formatTime(event.createdTime), style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              if (event.hospital.isNotEmpty) Text('医院： ${event.hospital}'),
              if (event.result.isNotEmpty) Text('诊断结果： ${event.result}'),
              if (event.desc.isNotEmpty) Text('病情描述： ${event.desc}'),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}";
  }
}

class _EditEventDialog extends StatefulWidget {
  final _Event event;
  const _EditEventDialog({required this.event});

  @override
  State<_EditEventDialog> createState() => _EditEventDialogState();
}

class _EditEventDialogState extends State<_EditEventDialog> {
  late DateTime _date;
  late TextEditingController _titleController;
  late TextEditingController _hospitalController;
  late TextEditingController _resultController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _date = widget.event.date;
    _titleController = TextEditingController(text: widget.event.title);
    _hospitalController = TextEditingController(text: widget.event.hospital);
    _resultController = TextEditingController(text: widget.event.result);
    _descController = TextEditingController(text: widget.event.desc);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('编辑事件'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text('日期：'),
                TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    if (picked != null) setState(() => _date = picked);
                  },
                  child: Text('${_date.year}-${_date.month}-${_date.day}'),
                ),
              ],
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: '标题'),
            ),
            TextField(
              controller: _hospitalController,
              decoration: const InputDecoration(labelText: '医院'),
            ),
            TextField(
              controller: _resultController,
              decoration: const InputDecoration(labelText: '诊断结果'),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: '病情描述'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_EventActionResult(deleted: true)),
          child: const Text('删除', style: TextStyle(color: Colors.red)),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.isNotEmpty) {
              Navigator.of(context).pop(_EventActionResult(
                updatedEvent: _Event(
                  date: _date,
                  title: _titleController.text,
                  hospital: _hospitalController.text,
                  result: _resultController.text,
                  desc: _descController.text,
                  createdTime: widget.event.createdTime,
                ),
              ));
            }
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}

class _EventActionResult {
  final _Event? updatedEvent;
  final bool deleted;
  _EventActionResult({this.updatedEvent, this.deleted = false});
}

class _DailyCheckCard extends StatefulWidget {
  @override
  State<_DailyCheckCard> createState() => _DailyCheckCardState();
}

class _DailyCheckCardState extends State<_DailyCheckCard> {
  List<String> checkTags = ['洗澡', '体重记录', '遛狗'];

  void _addTag(String tag) {
    setState(() {
      checkTags.add(tag);
    });
  }

  void _removeTag(int index) {
    setState(() {
      checkTags.removeAt(index);
    });
  }

  void _showAddTagDialog() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加打卡项'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: '请输入打卡标签'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('取消')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Navigator.pop(context, controller.text.trim());
              }
            },
            child: const Text('添加'),
          ),
        ],
      ),
    );
    if (result != null) {
      _addTag(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFFF8F5FC),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('日常打卡', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, color: Colors.amber),
                      onPressed: _showAddTagDialog,
                      tooltip: '添加打卡项',
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.grey),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(checkTags.length, (i) {
                return Chip(
                  label: Text(checkTags[i]),
                  backgroundColor: const Color(0xFFFFF9C4),
                  labelStyle: const TextStyle(color: Colors.black87, fontSize: 15),
                  deleteIcon: const Icon(Icons.close, size: 18),
                  onDeleted: () => _removeTag(i),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _MedicalCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('带皮皮看病', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('14:00:00', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            const Text('医院： 昆明附属医院'),
            const Text('诊断结果： 食物中毒'),
            const Text('病情描述： XXX'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset('img/hospital.jpg', fit: BoxFit.contain),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset('img/doctor.jpg', fit: BoxFit.contain),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 