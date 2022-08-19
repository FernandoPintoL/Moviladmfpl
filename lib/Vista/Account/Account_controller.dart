import 'package:get/get.dart';

class AccountController extends GetxController{
  bool isLoading = true;
  // Usuario usuario;
  void onInit() async{
    /*await UsuarioLocal().getUserActivo().then((value){
      print("ID "+ value.getId.toString());
      // print(value.getDirFoto);
      // print(value.getName);
      if(value.getId != -1){
        usuario = value;
      }else{
        usuario = null;
      }
      isLoading = false;
      update();
    });*/
    super.onInit();
  }
  /*void logout() async{
    await UsuarioLocal().cerrarSession(usuario).then((value){
      isLoading = true;
      update();
    });
  }*/
}