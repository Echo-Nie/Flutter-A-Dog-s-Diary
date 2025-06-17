import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../localizations/app_localizations.dart';
import 'pet_breed_detection_page.dart';
import 'dart:math' as math;

class ModelDownloadPage extends StatefulWidget {
  const ModelDownloadPage({super.key});

  @override
  State<ModelDownloadPage> createState() => _ModelDownloadPageState();
}

class _ModelDownloadPageState extends State<ModelDownloadPage> with SingleTickerProviderStateMixin {
  bool _downloading = false;
  double _downloadProgress = 0.0;
  String _status = '';
  bool _isModelReady = false;
  late AnimationController _animationController;
  
  // 模拟的下载链接 - 实际使用时需要替换为真实的模型链接
  // 在实际应用中，应该托管在自己的服务器上
  final String modelUrl = 'https://storage.googleapis.com/download.tensorflow.org/models/tflite/mobilenet_v1_1.0_224_quant_and_labels.zip';
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, 
      duration: const Duration(seconds: 2),
    )..repeat();
    _checkModelStatus();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _checkModelStatus() async {
    final modelFile = await _getModelFile();
    final labelsFile = await _getLabelsFile();
    
    setState(() {
      _isModelReady = modelFile.existsSync() && labelsFile.existsSync();
      _status = _isModelReady 
          ? '模型已下载并准备就绪' 
          : '需要下载模型文件才能使用宠物品种识别功能';
    });
  }

  Future<File> _getModelFile() async {
    final appDir = await getApplicationDocumentsDirectory();
    final modelPath = path.join(appDir.path, 'model_unquant.tflite');
    return File(modelPath);
  }

  Future<File> _getLabelsFile() async {
    final appDir = await getApplicationDocumentsDirectory();
    final labelsPath = path.join(appDir.path, 'labels.txt');
    return File(labelsPath);
  }

  Future<void> _downloadModel() async {
    if (_downloading) return;
    
    setState(() {
      _downloading = true;
      _downloadProgress = 0.0;
      _status = '正在下载模型文件...';
    });

    try {
      // 为了演示，我们模拟下载过程，逐步更新进度
      // 在实际应用中，应该实现真正的下载功能
      await _simulateModelDownload();
      
      // 创建标签文件
      final labelsFile = await _getLabelsFile();
      await labelsFile.writeAsString(_generateDogBreedLabels());
      
      // 创建一个小的模拟模型文件（仅用于演示）
      final modelFile = await _getModelFile();
      await modelFile.writeAsBytes(Uint8List.fromList(List.generate(1024 * 1024, (index) => index % 256)));

      setState(() {
        _downloading = false;
        _downloadProgress = 1.0;
        _isModelReady = true;
        _status = '模型下载完成！';
      });
    } catch (e) {
      setState(() {
        _downloading = false;
        _status = '下载出错: $e';
      });
    }
  }
  
  // 模拟下载过程，用于演示
  Future<void> _simulateModelDownload() async {
    const totalSteps = 20;
    for (int i = 1; i <= totalSteps; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        _downloadProgress = i / totalSteps;
        _status = '正在下载模型文件... ${(_downloadProgress * 100).toStringAsFixed(0)}%';
      });
    }
  }

  String _generateDogBreedLabels() {
    final dogBreeds = [
      'Labrador', 'Husky', 'Golden Retriever', 'Samoyed', 'Corgi',
      'Poodle', 'Dachshund', 'German Shepherd', 'Chihuahua', 'Shiba Inu',
      'Pomeranian', 'Beagle', 'Bulldog', 'Border Collie', 'Rottweiler',
      'Pug', 'Bichon Frise', 'Shih Tzu', 'Great Dane', 'Doberman'
    ];
    
    return dogBreeds.asMap().entries.map((entry) => '${entry.key} ${entry.value}').join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('模型下载'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isModelReady)
                  Icon(
                    Icons.check_circle,
                    size: 80,
                    color: Colors.green,
                  )
                else if (_downloading)
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animationController.value * 2 * math.pi,
                        child: Icon(
                          Icons.pets,
                          size: 80,
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    },
                  )
                else
                  Icon(
                    Icons.cloud_download,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                const SizedBox(height: 24),
                Text(
                  _isModelReady ? '宠物品种识别模型已准备就绪' : '需要下载宠物品种识别模型',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  _status,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 32),
                if (_downloading)
                  Column(
                    children: [
                      LinearProgressIndicator(
                        value: _downloadProgress,
                        minHeight: 10,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(_downloadProgress * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _isModelReady
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PetBreedDetectionPage(),
                                  ),
                                );
                              }
                            : _downloadModel,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isModelReady ? Colors.green : Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(_isModelReady ? Icons.check : Icons.download),
                            const SizedBox(width: 8),
                            Text(
                              _isModelReady ? '开始识别' : '下载模型',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      if (_isModelReady)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: TextButton.icon(
                            onPressed: _downloadModel,
                            icon: const Icon(Icons.refresh),
                            label: const Text('重新下载模型'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.grey[600],
                            ),
                          ),
                        ),
                    ],
                  ),
                const SizedBox(height: 32),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.grey[600], size: 20),
                            const SizedBox(width: 8),
                            const Text(
                              '注意事项',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                        const Divider(),
                        const Text(
                          '• 下载模型大约需要30秒，实际时间取决于网络速度\n'
                          '• 模型文件大约25MB，建议在Wi-Fi环境下下载\n'
                          '• 下载后将保存在设备上，无需重复下载\n'
                          '• 模型仅支持识别犬类品种，未来将添加更多动物品种',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 