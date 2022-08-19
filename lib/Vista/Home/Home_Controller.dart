import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:proyectoadmfpl/Controller/IntArticuloController.dart';
import 'package:proyectoadmfpl/Model/IntArticulo.dart';

class HomeController extends GetxController{
  String title = 'Home Title';
  List<IntArticulo> listArticulos = [];
  IntArticuloController intArticuloController = IntArticuloController();
  @override
  void onInit(){
    super.onInit();
    listArticulos = [];
    cargarArticulos();
    update();
  }

  void cargarArticulos() async{
    listArticulos = await intArticuloController.getQueryArticulo("");
    update();
  }
}