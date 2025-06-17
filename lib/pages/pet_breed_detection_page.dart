import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../localizations/app_localizations.dart';
import 'model_download_page.dart';

class PetBreedDetectionPage extends StatefulWidget {
  const PetBreedDetectionPage({super.key});

  @override
  State<PetBreedDetectionPage> createState() => _PetBreedDetectionPageState();
}

class _PetBreedDetectionPageState extends State<PetBreedDetectionPage> with SingleTickerProviderStateMixin {
  bool _loading = true;
  File? _image;
  List? _outputs;
  final _imagePicker = ImagePicker();
  String _errorMessage = '';
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _modelLoaded = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.repeat(reverse: true);
    
    _checkModelAndLoad();
  }

  Future<void> _checkModelAndLoad() async {
    try {
      final modelFile = await _getModelFile();
      final labelsFile = await _getLabelsFile();
      
      if (!modelFile.existsSync() || !labelsFile.existsSync()) {
        setState(() {
          _loading = false;
          _modelLoaded = false;
          _errorMessage = '模型文件未找到，请先下载模型';
        });
        return;
      }
      
      final result = await loadModel();
      if (result) {
        setState(() {
          _loading = false;
          _modelLoaded = true;
        });
      } else {
        setState(() {
          _loading = false;
          _errorMessage = '模型加载失败，请重新下载';
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
        _errorMessage = '模型检查错误: $e';
      });
    }
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

  @override
  void dispose() {
    _animationController.dispose();
    Tflite.close();
    super.dispose();
  }

  Future<bool> loadModel() async {
    try {
      final modelFile = await _getModelFile();
      final labelsFile = await _getLabelsFile();
      
      await Tflite.loadModel(
        model: modelFile.path,
        labels: labelsFile.path,
      );
      return true;
    } catch (e) {
      _errorMessage = '加载模型错误: $e';
      return false;
    }
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await _imagePicker.pickImage(source: source);
      if (image == null) return;
      
      setState(() {
        _loading = true;
        _image = File(image.path);
        _outputs = null;
      });
      
      await classifyImage(_image!);
    } catch (e) {
      setState(() {
        _loading = false;
        _errorMessage = '图片处理错误: $e';
      });
    }
  }

  Future classifyImage(File image) async {
    try {
      var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 5,
        threshold: 0.1,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      setState(() {
        _loading = false;
        _outputs = output;
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _errorMessage = '识别错误: $e';
      });
    }
  }

  void _navigateToModelDownload() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ModelDownloadPage(),
      ),
    ).then((_) => _checkModelAndLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate('petBreedDetection')),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_download),
            onPressed: _navigateToModelDownload,
            tooltip: '下载模型',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.7),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 顶部提示信息
              if (!_modelLoaded && _errorMessage.isNotEmpty)
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: _navigateToModelDownload,
                        child: const Text('下载模型'),
                      ),
                    ],
                  ),
                ),
                
              // 图片显示区域
              Expanded(
                child: _loading && _image != null
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 16),
                          Text(context.translate('processingImage')),
                        ],
                      ),
                    )
                  : Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_image == null)
                              Container(
                                height: 300,
                                width: 300,
                                margin: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.pets,
                                      size: 80,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      context.translate('noImageSelected'),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    if (_modelLoaded)
                                      const SizedBox(height: 24)
                                    else
                                      Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: FadeTransition(
                                          opacity: _animation,
                                          child: Text(
                                            '请先下载模型文件',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.orange[700],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              )
                            else
                              Stack(
                                children: [
                                  Hero(
                                    tag: 'petImage',
                                    child: Container(
                                      height: 300,
                                      width: 300,
                                      margin: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 10,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                        image: DecorationImage(
                                          image: FileImage(_image!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_outputs == null && _errorMessage.isNotEmpty)
                                    Positioned(
                                      bottom: 16,
                                      left: 16,
                                      right: 16,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.7),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          _errorMessage,
                                          style: const TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              
                            // 识别结果
                            if (_outputs != null && _outputs!.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "${context.translate('petBreed')}: ${_outputs![0]["label"].toString().split(' ').sublist(1).join(' ')}",
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    LinearProgressIndicator(
                                      value: _outputs![0]["confidence"],
                                      backgroundColor: Colors.grey[200],
                                      color: Theme.of(context).primaryColor,
                                      minHeight: 8,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "${context.translate('confidence')}: ${(_outputs![0]["confidence"] * 100).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      '其他可能的品种:',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Column(
                                      children: _outputs!.sublist(1, _outputs!.length > 3 ? 3 : _outputs!.length).map((output) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                output["label"].toString().split(' ').sublist(1).join(' '),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                              Text(
                                                "${(output["confidence"] * 100).toStringAsFixed(1)}%",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
              ),
              
              // 底部按钮
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _modelLoaded ? () => pickImage(ImageSource.camera) : _navigateToModelDownload,
                            icon: const Icon(Icons.camera_alt),
                            label: Text(context.translate('takePhoto')),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _modelLoaded ? () => pickImage(ImageSource.gallery) : _navigateToModelDownload,
                            icon: const Icon(Icons.photo_library),
                            label: Text(context.translate('chooseFromGallery')),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Colors.white,
                              foregroundColor: Theme.of(context).primaryColor,
                              side: BorderSide(color: Theme.of(context).primaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_image != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _image = null;
                              _outputs = null;
                            });
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('重新选择图片'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey[700],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 