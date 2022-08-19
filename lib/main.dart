import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectoadmfpl/Vista/Routes/App_Pages.dart';
import 'package:proyectoadmfpl/Vista/Routes/App_Routes.dart';
import 'package:proyectoadmfpl/Vista/Themes/App_Theme.dart';
import 'package:proyectoadmfpl/Vista/Themes/Config.dart';

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
      initialRoute: AppRoutes.DASHBOARD,
      getPages: AppPages.list,
      darkTheme: AppThemes.dark,
      themeMode: ThemeMode.system,
      color: Palette().kPrimaryColor,
    );
  }
}