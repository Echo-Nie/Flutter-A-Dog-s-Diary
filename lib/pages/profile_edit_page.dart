import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: '聂宇旋');
    _phoneController = TextEditingController(text: '13800138000');
    _emailController = TextEditingController(text: 'example@email.com');
    _addressController = TextEditingController(text: '北京市海淀区');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('编辑个人信息'),
        backgroundColor: theme.primaryColor,
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text('保存', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: const AssetImage('img/dog_avatar.png'),
                      backgroundColor: theme.primaryColor.withOpacity(0.1),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: theme.primaryColor,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                          onPressed: () {
                            // TODO: 实现头像更换功能
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '姓名',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入姓名';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: '手机号',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入手机号';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: '邮箱',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入邮箱';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: '地址',
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入地址';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // TODO: 实现保存个人信息的逻辑
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('保存成功')),
      );
      Navigator.pop(context);
    }
  }
} 