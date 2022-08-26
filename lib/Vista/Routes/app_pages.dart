import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:proyectoadmfpl/Vista/Account/account_page.dart';
import 'package:proyectoadmfpl/Vista/Account/account_binding.dart';
import 'package:proyectoadmfpl/Vista/Dashboard/dashboard_binding.dart';
import 'package:proyectoadmfpl/Vista/Dashboard/dashboard_page.dart';
import 'package:proyectoadmfpl/Vista/Home/home_binding.dart';
import 'package:proyectoadmfpl/Vista/Home/home_page.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(name: AppRoutes.home, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: AppRoutes.account, page: () => AccountPage(), binding: AccountBinding()),
    GetPage(name: AppRoutes.dashboard, page: () => const DashboardPage(), binding: DashboardBinding()),
  ];
}