import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoadmfpl/Model/intarticulo.dart';
import 'package:proyectoadmfpl/Vista/Articulo/articulo_details.dart';
import 'package:proyectoadmfpl/Vista/Dashboard/dashboard_controller.dart';

//ignore: must_be_immutable
class ListArticulo extends StatefulWidget {
  DashboardController dashboardController;
  List<IntArticulo> listArticulos;

  ListArticulo(
      {Key? key,
      required this.dashboardController,
      required this.listArticulos})
      : super(key: key);

  @override
  State<ListArticulo> createState() => _ListArticuloState();
}

class _ListArticuloState extends State<ListArticulo> {
  @override
  Widget build(BuildContext context) {
    return widget.listArticulos.isEmpty
        ? Center(
            child: Column(
            children: const <Widget>[
              Text("Aún no hay empresas activas...",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              SizedBox(height: 20),
              Icon(CupertinoIcons.shopping_cart, size: 42),
            ],
          ))
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              itemCount: widget.listArticulos.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade200,
              ),
              itemBuilder: (context, int index) {
                IntArticulo articulo = widget.listArticulos[index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    onTap: () {
                      //Navigator.push(context, CupertinoPageRoute(builder: (context) => new HomeArticuloMarket(usuario: usuario, dashboardController: widget.homeController,)));
                      Navigator.of(context).push(PageRouteBuilder(
                          transitionDuration:
                              const Duration(milliseconds: 1000),
                          pageBuilder: (context, animated, _) {
                            return FadeTransition(
                                opacity: animated,
                                child: ArticuloDetails(
                                    isShow: true,
                                    isEditing: true,
                                    isRegister: false,
                                    isPostRegister: true,
                                    articulo: articulo,
                                    dashboardController:
                                        widget.dashboardController,
                                    onArticuloAdded: () {
                                      /*articuloProvider
                                      .addArticuloCarrito(articulo);*/
                                      debugPrint("para agregar en el carrito");
                                    }));
                          }));
                    },
                    leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            "${widget.dashboardController.url}/${articulo.artDirFoto}",
                            scale: 100)),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(articulo.getArticuloId.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(articulo.getArticuloNombre.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(articulo.getArticuloDescripcion.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300)),
                        Text("${articulo.getArticuloPrecioVenta.toString()} Bs",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ),
                );
              },
            ));
  }
}
