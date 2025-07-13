import 'dart:async';
import 'package:flutter/material.dart';
import 'pet_breed_detection_page.dart';

class ModelDownloadPage extends StatefulWidget {
  const ModelDownloadPage({super.key});

  @override
  State<ModelDownloadPage> createState() => _ModelDownloadPageState();
}

class _ModelDownloadPageState extends State<ModelDownloadPage> {
  bool _isDownloading = false;
  bool _isCompleted = false;
  double _progress = 0.0;

  void _simulateDownload() {
    setState(() {
      _isDownloading = true;
      _progress = 0.0;
    });

    // 模拟下载进度
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 0.05;
        if (_progress >= 1.0) {
          _progress = 1.0;
          _isDownloading = false;
          _isCompleted = true;
          timer.cancel();
          
          // 下载完成后自动返回上一页
          Timer(const Duration(milliseconds: 500), () {
            Navigator.pop(context);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('模型下载'),
        backgroundColor: Colors.amber,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Colors.amber.withOpacity(0.1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 云下载图标
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  _isCompleted ? Icons.check : Icons.cloud_download,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 30),
              
              // 提示文字
              Text(
                _isCompleted ? '模型已下载完成' : '需要下载宠物品种识别模型',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // 进度条
              if (_isDownloading)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        value: _progress,
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.amber,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 10),
                      Text('下载中 ${(_progress * 100).toInt()}%'),
                    ],
                  ),
                ),
              
              const SizedBox(height: 40),
              
              // 下载按钮
              if (!_isDownloading && !_isCompleted)
                ElevatedButton.icon(
                  onPressed: _simulateDownload,
                  icon: const Icon(Icons.download),
                  label: const Text('下载模型'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              
              // 注意事项
              const SizedBox(height: 60),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.info_outline, color: Colors.grey),
                        const SizedBox(width: 10),
                        const Text(
                          '注意事项',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    _buildInfoItem('下载模型大约需要30秒，实际时间取决于网络速度'),
                    _buildInfoItem('模型文件大约25MB，建议在Wi-Fi环境下下载'),
                    _buildInfoItem('下载后将保存在设备上，无需重复下载'),
                    _buildInfoItem('模型仅支持识别犬类品种，未来将添加更多动物品种'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
} 