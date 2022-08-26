import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectoadmfpl/Vista/Routes/app_pages.dart';
import 'package:proyectoadmfpl/Vista/Routes/app_routes.dart';
import 'package:proyectoadmfpl/Vista/Themes/app_theme.dart';
import 'package:proyectoadmfpl/Vista/Themes/config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Administrador Fpl',
      initialRoute: AppRoutes.dashboard,
      getPages: AppPages.list,
      darkTheme: AppThemes.dark,
      themeMode: ThemeMode.system,
      color: Palette().kPrimaryColor,
    );
  }
}