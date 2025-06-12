# 🐾 FlutterPaws 🐾

<p align="center">
  <img src="./assets/logo.png" alt="YOLO-Drone" width="80%" />
</p>

<div align="center">
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Provider](https://img.shields.io/badge/Provider-4285F4?style=for-the-badge&logo=google&logoColor=white)
![shared_preferences](https://img.shields.io/badge/shared_preferences-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Material Design](https://img.shields.io/badge/Material%20Design-757575?style=for-the-badge&logo=material-design&logoColor=white)
![Cupertino](https://img.shields.io/badge/Cupertino-000000?style=for-the-badge&logo=apple&logoColor=white)
![Font Awesome](https://img.shields.io/badge/Font%20Awesome-4285F4?style=for-the-badge&logo=font-awesome&logoColor=white)

</div>



<div align="center">
![MIT License](https://img.shields.io/badge/License-MIT-green?style=flat-square)
![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web-lightgrey?style=flat-square)
![GitHub Stars](https://img.shields.io/github/stars/Echo-Nie/Flutter-A-Dog-s-Diary?style=social)
![GitHub Forks](https://img.shields.io/github/forks/Echo-Nie/Flutter-A-Dog-s-Diary?style=social)

</div>

<br>


## 📖 项目概述  
Flutter-A-Dog-s-Diary 是我独立开发的移动应用开发期末大作业，基于 Flutter 框架构建的跨平台宠物日记应用。项目聚焦宠物主人的核心需求，实现了日记记录、日程管理、健康档案、照片墙等功能模块，完整覆盖宠物生活管理场景。  


## 🌟 核心功能特性  
### 📝 智能日记系统  
- 支持文字/图片/视频混合记录，适配多场景回忆留存  
- 自动生成时间/类型标签，支持自定义标签分类检索  
- 集成心情状态选择器（如😄快乐/😴困倦/🍖贪吃等）  
- 预设成长日记/健康记录/趣味瞬间等模板  

### 📅 宠物日程管理  
- 三维提醒系统：喂食（定时循环）、疫苗（到期预警）、美容（周期提醒）  
- 自定义事件支持重复周期设置（如每周驱虫、每月洗澡）  
- 日历视图支持按标签颜色标记事件优先级  

### 🏥 健康数据管理  
- 体重曲线可视化图表（支持周/月/年维度对比）  
- 疫苗接种倒计时看板（含狂犬疫苗、传染病疫苗等分类）  
- 用药提醒支持剂量/频次智能计算（如体重×2mg/kg）  
- 自动生成季度健康报告（含BMI评估、疫苗时效分析）  


## 🚀 技术架构详情  
### 核心技术栈  

| 技术模块        | 版本号       | 说明                          |  
|-----------------|--------------|-------------------------------|  
| **Flutter**     | 3.7.0        | 跨平台UI框架，一套代码多端部署 |  
| **Dart**        | 3.0.0        | 编程语言，支持空安全特性       |  
| **Provider**    | 6.1.2        | 状态管理，分层控制主题/语言/数据|  
| **SharedPreferences**| 2.2.2      | 本地轻量级数据持久化          |  
| **Flutter Localizations**| -          | 多语言支持系统                |  
| **Cupertino Icons**| 1.0.8      | iOS风格图标库                 |  

### 技术实现亮点  
1. **响应式布局**：通过 `LayoutBuilder` 实现多设备屏幕适配，在手机/平板/网页端保持一致体验  
2. **混合开发**：通过 `platform_channel` 实现与原生系统的交互（如本地通知、相册访问）  
3. **性能优化**：使用 `ListView.builder` 实现大数据量列表的虚拟渲染  


## 📦 项目结构解析  
```dart
lib/
├── core/              # 核心功能层
│   ├── models/        # 数据模型（Pet.dart, Diary.dart, HealthRecord.dart）
│   ├── services/      # 业务逻辑（NotificationService, HealthService）
│   └── utils/         # 工具类（DateUtil, ImageUtil, ThemeUtil）
├── presentation/      # 展示层
│   ├── pages/         # 页面组件
│   │   ├── HomePage.dart       # 首页（日记时间线+快捷功能）
│   │   ├── CalendarPage.dart   # 日程日历（事件可视化）
│   │   ├── HealthPage.dart     # 健康档案（数据图表展示）
│   ├── widgets/       # 可复用组件
│   │   ├── PetCard.dart        # 宠物信息卡片（含状态指示器）
│   │   ├── DiaryItem.dart      # 日记条目组件（支持媒体预览）
│   │   └── ReminderTile.dart   # 提醒事项磁贴（带倒计时）
├── config/            # 配置层
│   ├── themes/        # 主题配置（Light/Dark模式）
│   └── locales/       # 多语言资源（zh_CN/en_US）
└── main.dart          # 应用入口（初始化Provider状态）
```


## 🛠️ 开发与部署指南  
**环境准备**  

1. 安装 [Flutter 3.7.0+](https://flutter.dev/docs/get-started/install)  
2. 配置开发工具：Android Studio/VS Code（推荐安装 Flutter 插件）  
3. 确保 `flutter doctor` 检查无异常（重点关注 Android/iOS 开发环境）  



**快速启动**  

```bash
# 克隆项目
git clone https://github.com/Echo-Nie/Flutter-A-Dog-s-Diary.git
cd Flutter-A-Dog-s-Diary

# 安装依赖
flutter pub get

# 运行应用（默认设备）
flutter run

# 构建发布版本（Android）
flutter build apk --release

# 构建发布版本（iOS）
flutter build ios --release
```


## 🔮 未来迭代计划  
- [ ] **宠物社交模块**：添加宠物动态广场、主人交流社区（含地理位置匹配）  
- [ ] **AI 健康分析**：集成图像识别（宠物表情分析）+ 数据预测（体重趋势预警）  
- [ ] **多设备同步**：基于 Firebase 实现云同步（支持家庭账号共享）  
- [ ] **可穿戴设备集成**：对接宠物智能项圈（运动量/体温数据接入）  


## 📄 项目声明  
本项目为移动应用开发课程期末作业，采用 MIT 开源协议。如需商业使用或二次开发，请联系作者获取授权。  

> 🌟 若项目对您有帮助，欢迎点击右上角 ⭐️ 收藏，您的支持是我持续优化的动力！  


## 👨‍💻 开发者  

[Echo-Nie](https://github.com/Echo-Nie)  

## 🙏 致谢  
感谢 Flutter 团队提供的跨平台框架，以及 Provider、SharedPreferences 等开源库的作者。同时感谢课程老师在开发过程中给予的指导以及很多可行性建议。  


## 📞 联系方式  
- GitHub Issue：[提交问题/建议](https://github.com/Echo-Nie/Flutter-A-Dog-s-Diary/issues)  
- 邮箱：[nyxchaoji123@163.com](nyxchaoji123@163.com)
