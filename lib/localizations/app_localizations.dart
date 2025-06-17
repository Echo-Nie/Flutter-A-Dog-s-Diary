import 'package:flutter/material.dart';

// 应用本地化类
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // 支持的语言列表
  static const List<Locale> supportedLocales = [
    Locale('zh'),
    Locale('en'),
  ];

  // 是否支持给定的Locale
  static bool isSupported(Locale locale) {
    return supportedLocales.any((supportedLocale) => 
      supportedLocale.languageCode == locale.languageCode);
  }

  // 用于获取当前AppLocalizations实例
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ?? 
           AppLocalizations(const Locale('zh'));
  }

  // 本地化值映射表
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // 通用
      'appTitle': 'Pet Manager',
      
      // 底部导航
      'home': 'Home',
      'topic': 'Topics',
      'my': 'Mine',
      'discover': 'Discover',
      
      // 设置页面
      'settings': 'Settings',
      'personalInfo': 'Personal Info',
      'petManagement': 'Pet Management',
      'themeSettings': 'Theme Settings',
      'languageSettings': 'Language Settings',
      'notificationSettings': 'Notification Settings',
      'about': 'About',
      'logout': 'Logout',
      
      // 主题颜色
      'selectTheme': 'Select Theme',
      'amber': 'Amber',
      'blue': 'Blue',
      'green': 'Green',
      'red': 'Red',
      'purple': 'Purple',
      'teal': 'Teal',
      'orange': 'Orange',
      
      // 语言设置
      'selectLanguage': 'Select Language',
      'chinese': 'Chinese',
      'english': 'English',
      
      // 宠物健康
      'health': 'Health',
      'weight': 'Weight',
      'vaccination': 'Vaccination',
      'medicalRecord': 'Medical Record',
      
      // 首页
      'myPets': 'My Pets',
      'healthManagement': 'Health Management',
      'weightTracking': 'Weight Tracking',
      'reminders': 'Reminders',
      'petCare': 'Pet Care',
      'checkIn': 'Check-in',
      'notes': 'Notes',
      'feedingGuide': 'Feeding Guide',
      
      // 宠物品种识别
      'petBreedDetection': 'Breed Detection',
      'takePhoto': 'Take Photo',
      'chooseFromGallery': 'From Gallery',
      'petBreed': 'Breed',
      'confidence': 'Confidence',
      'noImageSelected': 'No image selected',
      'processingImage': 'Analyzing image...',
      
      // 话题页
      'hotTopics': 'Hot Topics',
      'experience': 'Experience',
      'help': 'Help',
      'petShow': 'Pet Show',
      'medical': 'Medical',
      'searchTopics': 'Search pet topics, experiences...',
      'listening': 'Listening...',
      'cancel': 'Cancel',
      'follow': 'Following',
      'recommended': 'Recommended',
      
      // 我的页面
      'profile': 'My Profile',
      'edit': 'Edit',
      'nickname': 'Nickname',
      'userFollow': 'Follow',
      'fans': 'Fans',
      'viewAll': 'View All',
      
      // 宠物卡片
      'age': 'Age',
      'gender': 'Gender',
      'male': 'Male',
      'female': 'Female',
      'birthday': 'Birthday',
    },
    'zh': {
      // 通用
      'appTitle': '宠物管理',
      
      // 底部导航
      'home': '首页',
      'topic': '话题',
      'my': '我的',
      'discover': '发现',
      
      // 设置页面
      'settings': '设置',
      'personalInfo': '个人信息',
      'petManagement': '宠物管理',
      'themeSettings': '主题设置',
      'languageSettings': '语言设置',
      'notificationSettings': '通知设置',
      'about': '关于',
      'logout': '退出登录',
      
      // 主题颜色
      'selectTheme': '选择主题色',
      'amber': '橙黄',
      'blue': '蓝色',
      'green': '绿色',
      'red': '红色',
      'purple': '紫色',
      'teal': '青色',
      'orange': '橙色',
      
      // 语言设置
      'selectLanguage': '选择语言',
      'chinese': '中文',
      'english': 'English',
      
      // 宠物健康
      'health': '健康',
      'weight': '体重',
      'vaccination': '疫苗',
      'medicalRecord': '病历',
      
      // 首页
      'myPets': '我的宠物',
      'healthManagement': '健康管理',
      'weightTracking': '体重记录',
      'reminders': '提醒事项',
      'petCare': '宠物护理',
      'checkIn': '签到打卡',
      'notes': '随笔记录',
      'feedingGuide': '喂养指南',
      
      // 宠物品种识别
      'petBreedDetection': '品种识别',
      'takePhoto': '拍照',
      'chooseFromGallery': '从相册选择',
      'petBreed': '宠物品种',
      'confidence': '置信度',
      'noImageSelected': '暂无图片',
      'processingImage': '正在分析图片...',
      
      // 话题页
      'hotTopics': '热门',
      'experience': '经验',
      'help': '求助',
      'petShow': '晒宠',
      'medical': '医疗',
      'searchTopics': '搜索宠物话题、经验分享...',
      'listening': '正在聆听...',
      'cancel': '取消',
      'follow': '关注',
      'recommended': '推荐',
      
      // 我的页面
      'profile': '我的资料',
      'edit': '编辑',
      'nickname': '昵称',
      'userFollow': '关注',
      'fans': '粉丝',
      'viewAll': '全部',
      
      // 宠物卡片
      'age': '年龄',
      'gender': '性别',
      'male': '公',
      'female': '母',
      'birthday': '生日',
    },
  };

  // 获取翻译文本
  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? 
           _localizedValues['zh']?[key] ?? 
           key;
  }
}

// 简化访问本地化的扩展方法
extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
  String translate(String key) => loc.translate(key);
}

// 本地化委托实现
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.isSupported(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
} 