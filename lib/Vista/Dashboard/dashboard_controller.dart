import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:proyectoadmfpl/Controller/empresa_local_controller.dart';
import 'package:proyectoadmfpl/Controller/intarticulocodbarra_controller.dart';
import 'package:proyectoadmfpl/Controller/intarticulo_controller.dart';
import 'package:proyectoadmfpl/Controller/intexistencia_controller.dart';
import 'package:proyectoadmfpl/Model/empresa.dart';
import 'package:proyectoadmfpl/Model/intarticulo.dart';

class DashboardController extends GetxController{
  Empresa empresa = Empresa();
  int tabIndex = 0;
  late bool isLoading = true;
  List<IntArticulo> listArticulos = [];
  IntArticuloController intArticuloController = IntArticuloController();
  IntArticuloCodBarraController intArticuloCodBarraController = IntArticuloCodBarraController();
  IntExistenciaController intExistenciaController = IntExistenciaController();
  EmpresaLocalController empresaLocalController = EmpresaLocalController();
  String mensaje = "Articulos Listado : ";
  String query = "";
  String url = "";

  @override
  void onInit() async{
    super.onInit();
    cargarArticulos();
    /*print("creacion dahsboard "+usuario.getId.toString());
    this.cargarUserActivo();
    // this.cargarUsers();
    update();*/
  }
  
  void cargarArticulos() async{
    url = await empresaLocalController.getUrl();
    dynamic respuesta = await intArticuloController.getQueryArticulo("");
    empresa =  await EmpresaLocalController().getFirstEmpresa();
    if(respuesta['status'] == 200){
      listArticulos = respuesta['data'];
    }else{
      listArticulos = [];
    }
    mensaje = "Articulos Listado : ${listArticulos.length}";
    isLoading = false;
    update();
  }

  void consultarArticulos(String consulta) async{
    isLoading = true;
    update();
    dynamic respuesta = await intArticuloController.getQueryArticulo(consulta);
    if(respuesta['status'] == 200){
      listArticulos = respuesta['data'];
    }else{
      listArticulos = [];
    }
    query = "Coincidencias con $consulta => encontradas : ${listArticulos.length}";
    mensaje = "Articulos Listado : ${listArticulos.length}";
    isLoading = false;
    update();
  }

  void consultarArticulosCodBarra(String codBarra) async{
    isLoading = true;
    update();
    dynamic respuesta = await intArticuloCodBarraController.getCodBarraArticulo(codBarra);
    debugPrint(respuesta);
    if(respuesta['status'] == 200){
      listArticulos = respuesta['data'];
    }else{
      listArticulos = [];
    }
    query = "Coincidencias con $codBarra => encontradas : ${listArticulos.length}";
    mensaje = "Articulos Listado : ${listArticulos.length}";
    isLoading = false;
    update();
  }

  /*Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }*/

  void changeTabIndex(int index){
    tabIndex = index;
    update();
  }
  /*void cargarUserActivo() async{
    this.isLoading = true;
    this.usuario = null;
    update();
    await UsuarioLocal().getUserActivo().then((value){
      if(value.getId > 0){
        this.usuario = value;
      }else{
        this.usuario = new Usuario(id: 0);
      }
      this.isLoading = false;
      print("carga usuario terminando");
      update();
    });
    update();
  }

  Future<List<Usuario>> getEmpresas() async{
    await UsuarioController().listarUsuarios(3).then((value){
      this.listUsers = value;
    });
    return this.listUsers;
  }





  String mosotrarMensaje(){
    return this.mensaje;
  }

  void login(){
    UsuarioLocal().getUserActivo().then((value){
      if(value.getId > 0){
        usuario = value;
      }else{
        usuario = new Usuario(id: 0);
      }
      update();
    });
    changeTabIndex(0);
    update();
  }

  void register(){
    UsuarioLocal().getUserActivo().then((value){
      if(value.getId > 0){
        usuario = value;
      }else{
        usuario = new Usuario(id: 0);
      }
      update();
    });
    changeTabIndex(0);
    update();
  }

  void logout(){
    print(usuario.getName);
    isLoading = true;
    update();
    UsuarioLocal().actualizarEstadoLinea(usuario, 0).then((value){
      isLoading = false;
      usuario = new Usuario(id: 0);
      update();
    });
  }*/


}