import 'package:get/get.dart';
import 'package:proyectoadmfpl/Vista/Account/account_controller.dart';
import 'package:proyectoadmfpl/Vista/Dashboard/dashboard_controller.dart';
import 'package:proyectoadmfpl/Vista/Home/home_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AccountController>(() => AccountController());
  }

}