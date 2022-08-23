import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoadmfpl/Vista/Dashboard/dashboard_controller.dart';
import 'package:proyectoadmfpl/Vista/Themes/config.dart';
//ignore: must_be_immutable
class Buscador extends StatefulWidget {
  DashboardController? dashboardController;
  Function? function;
  GlobalKey<ScaffoldState> scaffoldKey;
  Buscador({Key? key, this.dashboardController, this.function, required this.scaffoldKey}) : super(key: key);
  @override
  State<Buscador> createState() => _BuscadorState();
}

class _BuscadorState extends State<Buscador> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: Palette().kDefaultPadding),
      padding: EdgeInsets.symmetric(horizontal: Palette().kDefaultPadding),
      height: 45,
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              onChanged: (value) {
                if(value.isEmpty) {
                  widget.dashboardController?.cargarArticulos();
                  return;
                }
                widget.dashboardController?.consultarArticulos(value.toString());
              },
              decoration: const InputDecoration(
                hintText: "Buscar",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          IconButton(
              icon: const Icon(CupertinoIcons.clear_circled,
              // color: Palette().kPrimaryColor,
                color: Colors.white,
              ), onPressed: (){
            widget.function!();
            /*widget.dashboardController.mensaje = '';
            widget.dashboardController.cargarUsers();
            */
          })
        ],
      ),
    );
  }
}
