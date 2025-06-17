import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

// 模型文件的下载链接
const String dogModelUrl = 'https://tfhub.dev/google/lite-model/aiy/vision/classifier/dogs_V1/1?lite-format=tflite';
const String modelOutputPath = '../assets/model_unquant.tflite';

// 宠物品种标签
const List<String> dogBreeds = [
  'Affenpinscher', 'Afghan hound', 'African hunting dog', 'Airedale', 'American Staffordshire terrier',
  'Appenzeller', 'Australian terrier', 'Basenji', 'Basset', 'Beagle',
  'Bedlington terrier', 'Bernese mountain dog', 'Black-and-tan coonhound', 'Blenheim spaniel', 'Bloodhound',
  'Bluetick', 'Border collie', 'Border terrier', 'Borzoi', 'Boston bull',
  'Bouvier des Flandres', 'Boxer', 'Brabancon griffon', 'Briard', 'Brittany spaniel',
  'Bull mastiff', 'Cairn', 'Cardigan', 'Chesapeake Bay retriever', 'Chihuahua',
  'Chow', 'Clumber', 'Cocker spaniel', 'Collie', 'Curly-coated retriever',
  'Dandie Dinmont', 'Dhole', 'Dingo', 'Doberman', 'English foxhound',
  'English setter', 'English springer', 'Entlebucher', 'Eskimo dog', 'Flat-coated retriever',
  'French bulldog', 'German shepherd', 'German short-haired pointer', 'Giant schnauzer', 'Golden retriever',
  'Gordon setter', 'Great Dane', 'Great Pyrenees', 'Greater Swiss Mountain dog', 'Groenendael',
  'Ibizan hound', 'Irish setter', 'Irish terrier', 'Irish water spaniel', 'Irish wolfhound',
  'Italian greyhound', 'Japanese spaniel', 'Keeshond', 'Kelpie', 'Kerry blue terrier',
  'Komondor', 'Kuvasz', 'Labrador retriever', 'Lakeland terrier', 'Leonberg',
  'Lhasa', 'Malamute', 'Malinois', 'Maltese dog', 'Mexican hairless',
  'Miniature pinscher', 'Miniature poodle', 'Miniature schnauzer', 'Newfoundland', 'Norfolk terrier',
  'Norwegian elkhound', 'Norwich terrier', 'Old English sheepdog', 'Otterhound', 'Papillon',
  'Pekinese', 'Pembroke', 'Pomeranian', 'Pug', 'Redbone',
  'Rhodesian ridgeback', 'Rottweiler', 'Saint Bernard', 'Saluki', 'Samoyed',
  'Schipperke', 'Scotch terrier', 'Scottish deerhound', 'Sealyham terrier', 'Shetland sheepdog',
  'Shih-Tzu', 'Siberian husky', 'Silky terrier', 'Soft-coated wheaten terrier', 'Staffordshire bullterrier',
  'Standard poodle', 'Standard schnauzer', 'Sussex spaniel', 'Tibetan mastiff', 'Tibetan terrier',
  'Toy poodle', 'Toy terrier', 'Vizsla', 'Walker hound', 'Weimaraner',
  'Welsh springer spaniel', 'West Highland white terrier', 'Whippet', 'Wire-haired fox terrier', 'Yorkshire terrier'
];

Future<void> main() async {
  print('开始下载宠物识别模型文件...');
  
  try {
    // 创建assets目录（如果不存在）
    final directory = Directory(path.dirname(modelOutputPath));
    if (!await directory.exists()) {
      await directory.create(recursive: true);
      print('创建目录: ${directory.path}');
    }
    
    // 下载模型文件
    print('正在下载模型文件，这可能需要几分钟时间...');
    final response = await http.get(Uri.parse(dogModelUrl));
    
    if (response.statusCode == 200) {
      final File file = File(modelOutputPath);
      await file.writeAsBytes(response.bodyBytes);
      print('模型文件下载完成: $modelOutputPath');
    } else {
      print('模型文件下载失败: ${response.statusCode}');
      print('正在尝试替代方案...');
      
      // 当直接下载失败时，提供替代方案的指导
      print('请手动访问 https://tfhub.dev/google/lite-model/aiy/vision/classifier/dogs_V1/1');
      print('点击"Download"按钮下载模型，然后将下载的文件重命名为"model_unquant.tflite"并放在assets目录下');
    }
    
    // 创建标签文件
    final labelsFile = File('../assets/labels.txt');
    final labelsContent = dogBreeds.asMap().entries.map((entry) => '${entry.key} ${entry.value}').join('\n');
    await labelsFile.writeAsString(labelsContent);
    print('标签文件创建完成: ${labelsFile.path}');
    
    print('模型文件准备完成！');
    print('请在pubspec.yaml确保assets:部分包含assets/和model_unquant.tflite, labels.txt');
    
  } catch (e) {
    print('错误: $e');
    print('请手动下载模型文件并放置在assets目录。');
  }
} 