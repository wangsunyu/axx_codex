import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../features/auth/presentation/login_page.dart';
import '../features/home/presentation/home_page.dart';
import '../shared/theme/app_theme.dart';

class AnXiaoXinApp extends StatelessWidget {
  const AnXiaoXinApp({super.key});

  static const String loginRoute = '/login';
  static const String homeRoute = '/home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '安小信',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      locale: const Locale('zh', 'CN'),
      supportedLocales: const <Locale>[
        Locale('zh', 'CN'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: loginRoute,
      routes: <String, WidgetBuilder>{
        loginRoute: (_) => const LoginPage(),
        homeRoute: (_) => const HomePage(),
      },
    );
  }
}
