# 🐾 FlutterPaws 宠物管理 🐾

[EN](README.md) | 中文

<p align="center">
  <img src="./assets/logo.png" alt="FlutterPaws Logo" width="45%" />
</p>

<div align="center">
  
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Provider](https://img.shields.io/badge/Provider-4285F4?style=for-the-badge&logo=google&logoColor=white)
![shared_preferences](https://img.shields.io/badge/shared_preferences-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![TensorFlow Lite](https://img.shields.io/badge/TensorFlow_Lite-FF6F00?style=for-the-badge&logo=tensorflow&logoColor=white)
![Material Design](https://img.shields.io/badge/Material%20Design-757575?style=for-the-badge&logo=material-design&logoColor=white)
![Cupertino](https://img.shields.io/badge/Cupertino-000000?style=for-the-badge&logo=apple&logoColor=white)
![Font Awesome](https://img.shields.io/badge/Font%20Awesome-4285F4?style=for-the-badge&logo=font-awesome&logoColor=white)

</div>

<div align="center">
  
![MIT License](https://img.shields.io/badge/License-MIT-green?style=flat-square)
![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web-lightgrey?style=flat-square)
![GitHub Stars](https://img.shields.io/github/stars/Echo-Nie/FlutterPaws?style=social)
![GitHub Forks](https://img.shields.io/github/forks/Echo-Nie/FlutterPaws?style=social)

</div>



## 📖 项目概述
FlutterPaws 是一个使用 Flutter 框架开发的全平台宠物日记应用。该应用专为宠物主人设计，提供日记记录、日程管理、健康追踪和照片库等模块，为宠物生活管理提供完整解决方案。

## 🌟 核心功能

#### 📝 智能日记系统
- 多媒体支持：支持文字、图片和视频的组合，记录各种场景下的点点滴滴
- 自动标签：自动生成时间和类型标签，支持自定义标签和分类
- 心情追踪：包含表情选择器（如 😄 开心、😴 困倦、🍖 饿了）
- 模板系统：预设成长记录、健康更新和难忘时刻等模板

#### 📅 宠物日程管理
- 三重提醒系统：喂食（定时/循环）、疫苗（到期提醒）、美容（周期提醒）
- 自定义事件：支持重复周期（如每周驱虫、每月洗澡）
- 彩色日历：通过颜色标签直观显示事件优先级

#### 🏥 健康数据管理
- 体重追踪：交互式图表，支持周/月/年度对比
- 疫苗面板：狂犬病、传染病等疫苗倒计时
- 用药提醒：基于宠物体重的剂量计算（如体重 × 2mg/kg）
- 季度健康报告：自动生成 BMI 分析和疫苗有效期追踪

#### 🔍 宠物品种识别
- AI 智能识别：基于 TensorFlow Lite 的宠物品种识别
- 详细品种信息：显示品种特征、护理建议和相似品种
- 高准确率识别：提供识别结果的可信度评分
- 分享功能：支持分享识别结果到社交平台

#### 📱 社区互动
- 话题分享：用户可以发布和浏览宠物相关话题
- 分类管理：支持按话题类别筛选和浏览内容
- 搜索功能：基于关键词的话题内容搜索

#### ⚙️ 个性化设置
- 主题切换：支持明亮模式和暗黑模式
- 多语言支持：中英文无缝切换
- 个人资料管理：用户信息自定义和宠物档案管理

## 🐾 宠物管理应用原型 (MasterGo)

 - **积分兑换 🛒:** 显示当前积分余额。"查看详情"按钮查看交易历史。可兑换商品列表，包括狗粮、零食、床垫和水瓶等
 - **主页 🏠:** 显示宠物档案，包括照片、年龄、品种和体重。快速访问面板：每日签到、健康追踪、体重记录、笔记和喂食指南。社区互动的关注和推荐板块
 - **体重追踪 📊:** 体重数据随时间变化的图形展示（折线图）。时间范围选择器（周视图、月视图、年视图）。显示最高和最低记录体重
 - **用户档案 👤:** 用户信息，包括头像、昵称、点赞数、粉丝数和关注数。已注册宠物列表。设置选项：主题选择、语言偏好和退出登录
 - **日历记录 📅:** 基于日历的界面，带有活动标记。记录功能包括洗澡、散步、体重记录等。医疗记录部分包括医院名称、诊断和描述

![image](https://github.com/user-attachments/assets/5fc24d68-b51c-4824-833b-86f62610c3b8)
<img width="1959" height="1099" alt="image" src="https://github.com/user-attachments/assets/22076c86-f937-4d2b-9a6d-db3e079277ee" />

## 💻 技术架构

#### 核心技术栈

| 组件                      | 版本   | 描述                       |
| ------------------------- | ------ | -------------------------- |
| **Flutter**               | 3.7.0  | 跨平台 UI 框架             |
| **Dart**                  | 3.0.0  | 支持空安全的编程语言       |
| **Provider**              | 6.1.2  | 主题、语言和数据的状态管理 |
| **SharedPreferences**     | 2.2.2  | 本地轻量级数据持久化       |
| **TensorFlow Lite**       | 1.1.2  | 移动端机器学习模型运行环境 |
| **Http**                  | 1.2.0  | 网络请求管理               |
| **SQLite**                | 2.3.2  | 本地数据库存储             |
| **Flutter Localizations** | -      | 多语言支持系统             |
| **Image Picker**          | 1.0.7  | 图像选择器                 |
| **FL Chart**              | 0.66.2 | 数据可视化图表             |
| **Intl**                  | 0.19.0 | 国际化支持                 |
| **Table Calendar**        | 3.0.9  | 日历组件                   |
| **Cached Network Image**  | 3.3.1  | 网络图片缓存               |

#### 关键技术特性
1. **响应式设计**：使用 `LayoutBuilder` 实现自适应布局，确保在手机、平板和网页上的一致体验
2. **多语言支持**：基于 `AppLocalizations` 的完整国际化支持，支持中英文切换
3. **主题动态切换**：使用 `Provider` 实现明暗主题的无缝切换，提升用户体验
4. **智能识别集成**：通过 `TensorFlow Lite` 实现本地宠物品种识别功能
5. **混合集成**：通过 `platform_channel` 实现本地系统交互（本地通知、相册访问）
6. **性能优化**：使用 `ListView.builder` 实现大列表的虚拟化渲染
7. **本地持久化**：结合 `SharedPreferences` 和 `SQLite` 的数据存储策略

## 📦 项目结构

```
lib/
├── core/              # 核心功能
│   ├── models/        # 数据模型 (Pet.dart, Diary.dart, HealthRecord.dart)
│   ├── services/      # 业务逻辑 (NotificationService, HealthService)
│   └── utils/         # 工具类 (DateUtil, ImageUtil, ThemeUtil)
├── pages/             # UI 页面
│   ├── home_page.dart         # 带有日记时间线和快捷操作的仪表板
│   ├── calendar_page.dart     # 日程可视化
│   ├── health_page.dart       # 健康指标仪表板
│   ├── pet_breed_detection_page.dart # 宠物品种识别页面
│   ├── topic_page.dart        # 话题社区页面
│   └── settings_page.dart     # 设置页面
├── widgets/           # 可复用组件
│   ├── pet_card.dart          # 带状态指示器的宠物档案
│   ├── bottom_nav.dart        # 底部导航栏
│   └── profile_header.dart    # 用户个人资料头部
├── localizations/     # 本地化
│   └── app_localizations.dart # 多语言支持
├── theme_notifier.dart # 主题管理
├── locale_notifier.dart # 语言管理
└── main.dart          # 应用入口点
```

## 🚀 快速开始

1. 安装 [Flutter 3.7.0+](https://flutter.dev/docs/get-started/install)
2. 配置 IDE：安装 Flutter 插件的 Android Studio/VS Code
3. 使用 `flutter doctor` 验证设置

```
# 克隆仓库
git clone https://github.com/Echo-Nie/FlutterPaws.git
cd FlutterPaws
```

```
# 安装依赖
flutter pub get
```

```
# 在默认设备上运行
flutter run
```

```
# 构建 Android 发布版 APK
flutter build apk --release
```

```
# 构建 iOS 发布版 IPA
flutter build ios --release
```

## 🔮 未来增强
- [ ] **宠物社交网络**：社区信息流和基于位置的主人匹配
- [ ] **AI 健康分析**：宠物情绪检测的图像识别和预测分析
- [ ] **云同步**：基于 Firebase 的多设备同步，支持家庭账户共享
- [ ] **智能推荐系统**：基于宠物品种和年龄的个性化内容推荐
- [ ] **语音控制**：基于语音识别的应用控制功能

## 📄 许可证
本项目基于 MIT 开源许可发布。商业使用或衍生作品需要获得作者授权。

> 🌟 如果您觉得这个项目有用，请给它一个 ⭐️！您的支持是持续改进的动力。

## 🙏 致谢
特别感谢 Flutter 团队提供的跨平台框架，以及 Provider、SharedPreferences 等开源库的开发者。同时感谢课程讲师在开发过程中的指导和反馈。

## 📞 联系方式
- GitHub Issues：[报告问题/请求功能](https://github.com/Echo-Nie/FlutterPaws/issues)
- 邮箱：[nyxchaoji123@163.com](mailto:nyxchaoji123@163.com) 
