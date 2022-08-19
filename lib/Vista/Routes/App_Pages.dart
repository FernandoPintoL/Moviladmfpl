import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:proyectoadmfpl/Vista/Account/Account_Page.dart';
import 'package:proyectoadmfpl/Vista/Account/Account_binding.dart';
import 'package:proyectoadmfpl/Vista/Dashboard/Dashboard_binding.dart';
import 'package:proyectoadmfpl/Vista/Dashboard/Dashboard_page.dart';
import 'package:proyectoadmfpl/Vista/Home/Home_binding.dart';
import 'package:proyectoadmfpl/Vista/Home/Home_page.dart';
import 'App_Routes.dart';

class AppPages {
  static var list = [
    GetPage(name: AppRoutes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: AppRoutes.ACCOUNT, page: () => AccountPage(), binding: AccountBinding()),
    GetPage(name: AppRoutes.DASHBOARD, page: () => const DashboardPage(), binding: DashboardBinding()),
  ];
}