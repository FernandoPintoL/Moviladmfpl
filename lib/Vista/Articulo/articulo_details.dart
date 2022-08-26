import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoadmfpl/Controller/empresa_local_controller.dart';
import 'package:proyectoadmfpl/Controller/intarticulocodbarra_controller.dart';
import 'package:proyectoadmfpl/Controller/intexistencia_controller.dart';
import 'package:proyectoadmfpl/Model/intarticulo.dart';
import 'package:proyectoadmfpl/Model/intarticulocodbarra.dart';
import 'package:proyectoadmfpl/Model/intexistencia.dart';
import 'package:proyectoadmfpl/Vista/Articulo/register_update_articulo.dart';
import 'package:proyectoadmfpl/Vista/Dashboard/dashboard_controller.dart';

//ignore: must_be_immutable
class ArticuloDetails extends StatefulWidget {
  IntArticulo articulo;
  DashboardController dashboardController;
  final VoidCallback onArticuloAdded;
  bool isShow;
  bool isEditing;
  bool isRegister;
  bool isPostRegister;

  ArticuloDetails(
      {Key? key,
      required this.articulo,
      required this.dashboardController,
      required this.onArticuloAdded,
      required this.isEditing,
      required this.isRegister,
      required this.isShow,
      required this.isPostRegister})
      : super(key: key);

  @override
  State<ArticuloDetails> createState() => _ArticuloDetailsState();
}

class _ArticuloDetailsState extends State<ArticuloDetails> {
  GlobalKey<ScaffoldState> scaffoldKeyArticulo = GlobalKey<ScaffoldState>();
  String heroTag = '';

  void changeEdit() {
    setState(() {
      widget.isShow = !widget.isShow;
    });
  }

  void addToCarrito(BuildContext context) {
    setState(() {
      heroTag = "detalle";
    });
    widget.onArticuloAdded();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKeyArticulo,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          // title: Text(
          //     "Cod Alternativo : ${widget.articulo.getArticuloId.toString()}",
          //     style: const TextStyle(color: Colors.black45)),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          actions: [
            widget.isPostRegister ? IconButton(
                onPressed: changeEdit,
                icon: const Icon(
                  CupertinoIcons.pencil_outline,
                  color: Colors.black,
                )) : const Icon(CupertinoIcons.slider_horizontal_below_rectangle)
          ],
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(bottom: 18, top: 12, right: 12, left: 12),
          child: widget.isShow
              ? DetailsArticulo(
                  articulo: widget.articulo,
                  heroTag: heroTag,
                  dashboardController: widget.dashboardController,
                )
              : RegisterEditArticulo(
                  scaffoldKey: scaffoldKeyArticulo,
                  isEditing: widget.isEditing,
                  isRegister: widget.isRegister,
                  isPostRegister: widget.isPostRegister,
                  articulo: widget.articulo,
                ),
        ));
  }
}

//ignore: must_be_immutable
class DetailsArticulo extends StatefulWidget {
  String heroTag;
  IntArticulo articulo;
  DashboardController dashboardController;

  DetailsArticulo(
      {Key? key,
      required this.articulo,
      required this.heroTag,
      required this.dashboardController})
      : super(key: key);

  @override
  State<DetailsArticulo> createState() => _DetailsArticuloState();
}

class _DetailsArticuloState extends State<DetailsArticulo> {
  String urlImg = "";
  bool isLoading = true;
  List<IntArticuloCodBarra> codigosBarras = [];
  List<IntExistencia> existencias = [];

  void cargarDatos() async {
    dynamic cb = await IntArticuloCodBarraController()
        .getCodsBarrasArticulos(widget.articulo.getArticuloId);
    if (cb['status'] == 200) {
      codigosBarras = cb['data'];
    }
    dynamic ext = await IntExistenciaController()
        .getExistenciasArticulos(widget.articulo.getArticuloId);
    if (ext['status'] == 200) {
      existencias = ext['data'];
    }
    urlImg = await EmpresaLocalController().getUrl();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 12,
                ),
                Text("Cargando...", style: TextStyle(color: Colors.black87))
              ],
            ),
          )
        : Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Hero(
                          tag:
                              "List_${widget.articulo.getArticuloId}${widget.heroTag}",
                          child: ClipOval(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                "${widget.dashboardController.url}/${widget.articulo.getArticuloDirFoto}",
                                fit: BoxFit.contain,
                                height:
                                    MediaQuery.of(context).size.height * 0.66,
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Cod: ${widget.articulo.getArticuloId}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(color: Colors.grey)),
                          Text(widget.articulo.getArticuloNombre,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          const SizedBox(height: 20),
                          Text(
                              "Descripcion: ${widget.articulo.getArticuloDescripcion}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(color: Colors.grey)),
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                "${widget.articulo.getArticuloPrecioVenta} Bs",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Divider(color: Colors.black26),
                    const Text("Codigos de Barras",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            codigosBarras.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /*Text(
                                        "Id: ${codigosBarras[index].tadId}",
                                        style: const TextStyle(
                                            color: Colors.black45),
                                      ),*/
                                      Text(
                                        "Cod Barra: ${codigosBarras[index].codBarra}",
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                )),
                      ),
                    ),
                    const Divider(color: Colors.black26),
                    const Text("Existencia",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            existencias.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${existencias[index].almId} : ${existencias[index].exiExistencia}",
                                        style: const TextStyle(
                                            color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                )),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          );
  }
}
