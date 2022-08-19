import 'package:get/get.dart';
import 'package:proyectoadmfpl/Vista/Account/Account_controller.dart';
import 'package:proyectoadmfpl/Vista/Dashboard/Dashboard_controller.dart';
import 'package:proyectoadmfpl/Vista/Home/Home_Controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AccountController>(() => AccountController());
  }

}