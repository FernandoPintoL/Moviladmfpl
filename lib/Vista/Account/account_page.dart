// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectoadmfpl/Controller/empresa_local_controller.dart';
import 'package:proyectoadmfpl/Model/empresa.dart';
import 'package:proyectoadmfpl/Vista/Dashboard/dashboard_controller.dart';
import 'package:proyectoadmfpl/Vista/Themes/Components/buttom_forms.dart';
import 'package:proyectoadmfpl/Vista/Themes/Components/form_text_field.dart';

class AccountPage extends StatefulWidget {
  DashboardController? dashboardController;

  AccountPage({Key? key, this.dashboardController}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Vistas vistas = Vistas();
  bool isLoading = false;
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _url = TextEditingController();
  Empresa empresaAux = Empresa();

  void cargarDatos() async{
    
  }

  void actulizarEmpresa(int id) async{
    setState(() {
      isLoading = true;
    });
    empresaAux.id = id;
    empresaAux.nombre = _nombre.text;
    empresaAux.url = _url.text;
    await EmpresaLocalController().update(empresaAux);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<DashboardController>(
            init: widget.dashboardController,
            builder: (controller) {
              _nombre.text = controller.empresa.getNombre;
              _url.text = controller.empresa.getUrl;
              return Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Empresa: ${controller.empresa.getNombre}"),
                      Text("URL::// ${controller.empresa.getUrl}"),
                      vistas.textForm(
                          "Nombre",
                          _nombre,
                          false,
                          const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.blueAccent,
                          ),
                          TextInputType.text,
                          8,
                          const TextStyle(color: Colors.white)
                      ),
                      vistas.textForm(
                          "Url",
                          _url,
                          false,
                          const Icon(
                            Icons.web,
                            color: Colors.blueAccent,
                          ),
                          TextInputType.text,
                          8,
                          const TextStyle(color: Colors.white)
                      ),
                      ButtomForm(
                          label: "Actualizar Articulo",
                          onPressed: (){
                            actulizarEmpresa(controller.empresa.getId);
                          },
                          isLoading: isLoading),
                      // CircularProgressIndicator()
                    ]),
              );
            }),
      ),
    );
  }
}
