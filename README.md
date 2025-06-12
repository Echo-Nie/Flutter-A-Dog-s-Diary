# Flutter-A-Dog-s-Diary 🐕

<div align="center">

![Flutter Version](https://img.shields.io/badge/Flutter-3.7.0-blue)
![Dart Version](https://img.shields.io/badge/Dart-3.0.0-blue)
![License](https://img.shields.io/badge/License-MIT-green)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey)

</div>

## 📖 项目介绍

Flutter-A-Dog-s-Diary 是一个使用 Flutter 开发的跨平台宠物日记应用。它旨在为宠物主人提供一个便捷的平台，用于记录和分享与爱宠的日常生活。无论是记录宠物的成长历程、健康状态，还是分享有趣的瞬间，这个应用都能满足您的需求。

### 🌟 主要特点

- **📝 智能日记系统**
  - 支持文字、图片、视频等多种格式
  - 智能标签分类
  - 心情记录功能
  - 支持日记模板

- **📅 宠物日程管理**
  - 喂食提醒
  - 疫苗预约
  - 美容提醒
  - 自定义事件提醒
  - 日历视图

- **🏥 健康档案管理**
  - 体重记录
  - 疫苗记录
  - 体检记录
  - 用药提醒
  - 健康报告生成

- **📸 照片墙功能**
  - 照片分类管理
  - 智能相册
  - 照片编辑
  - 分享功能

- **🌙 个性化设置**
  - 深色模式
  - 自定义主题
  - 字体大小调整
  - 界面布局自定义

- **🌍 多语言支持**
  - 中文
  - 英文
  - 更多语言支持计划中

## 🚀 技术栈

### 核心框架
- Flutter 3.7.0
- Dart 3.0.0

### 状态管理
- Provider 6.1.2
  - 用于全局状态管理
  - 主题切换
  - 语言切换

### 数据存储
- Shared Preferences 2.2.2
  - 本地数据持久化
  - 用户配置存储

### 国际化
- Flutter Localizations
  - 多语言支持
  - 本地化资源管理

### UI 组件
- Cupertino Icons 1.0.8
  - iOS 风格图标
  - Material Design 图标

## 📱 应用截图

[在这里添加应用主要界面的截图]

## 🛠️ 开发环境设置

### 系统要求
- Flutter SDK 3.7.0 或更高版本
- Dart SDK 3.0.0 或更高版本
- Android Studio / VS Code
- Git

### 安装步骤

1. **安装 Flutter SDK**
```bash
# 检查 Flutter 环境
flutter doctor
```

2. **克隆项目**
```bash
git clone https://github.com/Echo-Nie/Flutter-A-Dog-s-Diary.git
cd Flutter-A-Dog-s-Diary
```

3. **安装依赖**
```bash
flutter pub get
```

4. **运行项目**
```bash
# 运行在默认设备上
flutter run

# 运行在特定设备上
flutter run -d <device-id>
```

5. **构建发布版本**
```bash
# Android
flutter build apk

# iOS
flutter build ios

# Web
flutter build web
```

## 📦 项目结构

```
lib/
  ├── pages/                # 页面文件
  │   ├── home_page.dart    # 首页
  │   ├── calendar_page.dart # 日历页
  │   ├── guide_page.dart   # 指南页
  │   ├── my_page.dart      # 我的页面
  │   ├── todo_page.dart    # 待办页面
  │   └── topic_page.dart   # 话题页面
  │
  ├── widgets/              # 可复用组件
  │   ├── bottom_nav.dart   # 底部导航
  │   ├── function_buttons.dart # 功能按钮
  │   ├── pet_card.dart     # 宠物卡片
  │   ├── profile_header.dart # 个人信息头部
  │   └── tab_section.dart  # 标签部分
  │
  ├── theme_notifier.dart   # 主题管理
  ├── locale_notifier.dart  # 语言管理
  └── main.dart            # 应用入口
```

## 🤝 贡献指南

我们欢迎任何形式的贡献，无论是新功能、bug 修复还是文档改进。

### 贡献流程

1. Fork 这个仓库
2. 创建您的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

### 代码规范

- 遵循 Flutter 官方代码规范
- 使用有意义的变量和函数命名
- 添加必要的注释
- 确保代码通过所有测试

### 提交规范

提交信息格式：
```
<type>(<scope>): <subject>

<body>

<footer>
```

type 类型：
- feat: 新功能
- fix: 修复
- docs: 文档
- style: 格式
- refactor: 重构
- test: 测试
- chore: 构建过程或辅助工具的变动

## 📄 开源协议

本项目采用 MIT 协议 - 查看 [LICENSE](LICENSE) 文件了解详情

## 👥 作者

- Echo-Nie - [GitHub](https://github.com/Echo-Nie)

## 🙏 致谢

感谢所有为这个项目做出贡献的开发者！

特别感谢：
- Flutter 团队
- Provider 包作者
- Shared Preferences 包作者
- 所有提交 Issue 和 Pull Request 的贡献者

## 📞 联系方式

如有任何问题或建议，欢迎通过以下方式联系：

- 创建 Issue
- 发送邮件至：[您的邮箱]
- 加入我们的讨论组：[讨论组链接]

## 🔮 未来计划

- [ ] 添加宠物社交功能
- [ ] 集成宠物健康数据分析
- [ ] 添加宠物训练计划
- [ ] 支持更多平台（Windows、macOS、Linux）
- [ ] 添加云同步功能

---

如果这个项目对您有帮助，欢迎给一个 ⭐️

<div align="center">
  <img src="path/to/your/logo.png" alt="Logo" width="200"/>
</div>
