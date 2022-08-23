import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectoadmfpl/Vista/Articulo/list_articulo.dart';
import 'package:proyectoadmfpl/Vista/Dashboard/dashboard_controller.dart';
import 'package:proyectoadmfpl/Vista/Themes/Components/header_with_search_box.dart';
//ignore: must_be_immutable
class HomePage extends StatefulWidget {
  DashboardController? dashboardController;

  HomePage({Key? key, dashboardController}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: GetBuilder<DashboardController>(
              init: widget.dashboardController,
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    HeaderWithSearchBox(
                        size: size, dashboardController: controller),
                    Expanded(
                      child: controller.isLoading
                          ? Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const <Widget>[
                                CupertinoActivityIndicator(radius: 20),
                                SizedBox(height: 12),
                                Text("Cargando Articulos....",
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ))
                          : ListArticulo(
                              listArticulos: controller.listArticulos.isEmpty
                                  ? []
                                  : controller.listArticulos,
                              dashboardController: controller,
                            ),
                    ),
                  ],
                );
              })),
    );
  }
}
