import 'package:flutter/material.dart';

import '../features/home/presentation/home_page.dart';
import '../shared/theme/app_theme.dart';

class AnXiaoXinApp extends StatelessWidget {
  const AnXiaoXinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '安小信',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const HomePage(),
    );
  }
}
