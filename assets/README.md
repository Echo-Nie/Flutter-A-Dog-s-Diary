# 宠物品种识别模型

本文件夹用于存放TensorFlow Lite模型文件，用于宠物品种识别功能。

## 必要文件

应用需要以下两个文件才能使用宠物品种识别功能:

1. `model_unquant.tflite` - TensorFlow Lite模型文件
2. `labels.txt` - 包含模型可以识别的所有宠物品种标签

## 如何获取模型

您可以通过以下方式获取适用于宠物品种识别的模型:

### 选项1: 使用预训练模型

1. 从TensorFlow Hub或者其他资源下载预训练的宠物品种识别模型
2. 使用TensorFlow Lite转换器将模型转换为TFLite格式
3. 确保模型输出与代码中预期的格式一致

### 选项2: 使用现成的TensorFlow Lite模型

您可以使用以下现成的犬种识别模型:

1. 访问 [TensorFlow Hub](https://tfhub.dev/google/lite-model/aiy/vision/classifier/dogs_V1/1)
2. 下载犬种分类器模型
3. 将模型文件重命名为`model_unquant.tflite`并放在此目录
4. 创建一个`labels.txt`文件，其中包含每行一个犬种名称

### 选项3: 训练自己的模型

如果您需要识别特定的宠物品种，可以:

1. 使用TensorFlow和自己的数据集训练模型
2. 使用TensorFlow Lite转换器将其转换为TFLite格式
3. 生成标签文件

## labels.txt格式示例

```
0 拉布拉多
1 哈士奇
2 金毛
3 萨摩耶
4 柯基
...
```

## 注意事项

- 模型大小应控制在合理范围内，建议不超过10MB
- 请确保模型与代码中的设置兼容，特别是`imageMean`和`imageStd`参数
- 对于生产环境，建议使用量化模型以提高性能 