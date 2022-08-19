import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoadmfpl/Controller/EmpresaLocalController.dart';
import 'package:proyectoadmfpl/Controller/IntArticuloCodBarra.dart';
import 'package:proyectoadmfpl/Controller/IntArticuloController.dart';
import 'package:proyectoadmfpl/Controller/IntExistenciaController.dart';
import 'package:proyectoadmfpl/Model/IntArticulo.dart';
import 'package:proyectoadmfpl/Model/IntArticuloCodBarra.dart';
import 'package:proyectoadmfpl/Model/IntExistencia.dart';
import 'package:proyectoadmfpl/Vista/Dashboard/Dashboard_controller.dart';
import 'package:proyectoadmfpl/Vista/Themes/Components/ButtomForms.dart';
import 'package:proyectoadmfpl/Vista/Themes/Components/FormTextField.dart';
import 'package:proyectoadmfpl/Vista/Themes/Components/MssgEmergentes.dart';

class ArticuloDetails extends StatefulWidget {
  IntArticulo articulo;
  DashboardController dashboardController;
  final VoidCallback onArticuloAdded;

  ArticuloDetails(
      {Key? key,
      required this.articulo,
      required this.dashboardController,
      required this.onArticuloAdded})
      : super(key: key);

  @override
  State<ArticuloDetails> createState() => _ArticuloDetailsState();
}

class _ArticuloDetailsState extends State<ArticuloDetails> {
  GlobalKey<ScaffoldState> scaffoldKeyArticulo = GlobalKey<ScaffoldState>();
  String heroTag = '';
  bool isEditing = false;
  bool isRegister = false;
  bool isShow = true;

  void changeEdit() {
    setState(() {
      isShow = !isShow;
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
          title: Text(
              "Cod Alternativo : ${widget.articulo.getArticuloId.toString()}",
              style: const TextStyle(color: Colors.black45)),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          actions: [
            IconButton(
                onPressed: changeEdit,
                icon: const Icon(
                  CupertinoIcons.pencil_outline,
                  color: Colors.black,
                ))
          ],
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(bottom: 18, top: 12, right: 12, left: 12),
          child: isShow
              ? DetailsArticulo(
                  articulo: widget.articulo,
                  heroTag: heroTag,
                  dashboardController: widget.dashboardController,
                )
              : RegisterEditArticulo(
                  scaffoldKey: scaffoldKeyArticulo,
                  isEditing: true,
                  isRegister: false,
                  articulo: widget.articulo,
                ),
        ));
  }
}

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

class RegisterEditArticulo extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  IntArticulo articulo;
  bool isRegister;
  bool isEditing;

  RegisterEditArticulo(
      {Key? key,
      required this.scaffoldKey,
      required this.articulo,
      required this.isEditing,
      required this.isRegister})
      : super(key: key);

  @override
  State<RegisterEditArticulo> createState() => _RegisterEditArticuloState();
}

class _RegisterEditArticuloState extends State<RegisterEditArticulo> {
  Vistas vistas = Vistas();
  bool isLoading = true;
  String urlImg = "";
  final GlobalKey<FormState> _formArticulokey = GlobalKey<FormState>();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _precioVenta = TextEditingController();
  final TextEditingController _precioVentaDos = TextEditingController();
  final TextEditingController _precioVentaTres = TextEditingController();
  List<IntArticuloCodBarra> codigosBarras = [];
  List<IntExistencia> existencias = [];

  void cargarDatos() async {
    urlImg = await EmpresaLocalController().getUrl();
    _nombre.text = widget.articulo.getArticuloNombre;
    _descripcion.text = widget.articulo.getArticuloDescripcion;
    _precioVenta.text = widget.articulo.getArticuloPrecioVenta.toString();
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
    setState(() {
      isLoading = false;
    });
  }

  void registrarArticulo() async {
    if (_formArticulokey.currentState!.validate()) {
      // widget.onRegisterClickedForward();
      setState(() {
        isLoading = true;
      });
      _formArticulokey.currentState!.save();
      IntArticulo articuloAux = IntArticulo(
          artNombre: _nombre.text,
          artDescripcion: _descripcion.text,
          artPrecioVenta: double.tryParse(_precioVenta.text),
          artPrecioVentaDos: double.tryParse(_precioVentaDos.text),
          artPrecioVentaTres: double.tryParse(_precioVentaTres.text),
          artFraccionado: "N",
          artDirFoto: "default-articulo.jpg");
      dynamic respuesta = await IntArticuloController().registrar(articuloAux);
      VentanasEmergentes().showSnackBar(
          respuesta['status'] == 200
              ? respuesta['data']
              : "Se registro correctamente!...",
          respuesta['status'],
          context,
          widget.scaffoldKey);
      setState(() {
        isLoading = false;
      });
      // widget.onRegisterClickedReverse();
    }
  }

  void actualizarArticulo() async {
    if (_formArticulokey.currentState!.validate()) {
      _formArticulokey.currentState!.save();
      // widget.onRegisterClickedForward();
      setState(() {
        isLoading = true;
      });
      IntArticulo articuloAux = IntArticulo();
      articuloAux.setId = widget.articulo.getArticuloId;
      articuloAux.setNombre = _nombre.text;
      articuloAux.setDescripcion =
          _descripcion.text.isEmpty ? "" : _descripcion.text;
      articuloAux.artPrecioVenta = double.tryParse(_precioVenta.text);
      articuloAux.artPrecioVentaDos = double.tryParse(_precioVentaDos.text);
      articuloAux.artPrecioVentaTres = double.tryParse(_precioVentaTres.text);
      print(articuloAux.toMap().toString());
      dynamic respuesta = await IntArticuloController().actualizar(articuloAux);
      VentanasEmergentes().showSnackBar(
          respuesta['status'] == 200
              ? "Se actualizo correctamente!..."
              : respuesta['data'],
          respuesta['status'],
          context,
          widget.scaffoldKey);
      setState(() {
        isLoading = false;
      });
      // widget.onRegisterClickedReverse();
    }
  }

  void registrarCodBarra() async {
    setState(() {
      isLoading = true;
    });
    dynamic response = IntArticuloCodBarraController()
        .registrar(widget.articulo.getArticuloId);
    print(response);
    cargarDatos();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Form(
                  key: _formArticulokey,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                                child: CachedNetworkImage(
                                    imageUrl:
                                        "$urlImg/${widget.articulo.getArticuloDirFoto}",
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(
                                            value: 12),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                          Icons.shopping_bag_outlined,
                                          size: 120,
                                          color: Colors.white,
                                        ))),
                            widget.isRegister
                                ? const SizedBox(height: 55)
                                : ElevatedButton(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(Icons.add_a_photo_outlined,
                                            color: Colors.white),
                                        Expanded(
                                            child: Text(" Actualizar Imagen",
                                                style: TextStyle(
                                                    color: Colors.white),
                                                textAlign: TextAlign.center)),
                                      ],
                                    ),
                                    onPressed: () {
                                      // Navigator.push(context, CupertinoPageRoute(builder: (context) => new ActualizarImgArticulo(articulo: widget.articulo)));
                                    }),
                          ],
                        ),
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
                            const TextStyle(color: Colors.black)),
                        vistas.textForm(
                            "Descripción",
                            _descripcion,
                            false,
                            const Icon(
                              Icons.info_outline,
                              color: Colors.blueAccent,
                            ),
                            TextInputType.text,
                            8,
                            const TextStyle(color: Colors.black)),
                        vistas.textForm(
                            "Precio Venta",
                            _precioVenta,
                            false,
                            const Icon(
                              Icons.monetization_on,
                              color: Colors.blueAccent,
                            ),
                            const TextInputType.numberWithOptions(
                                decimal: false),
                            8,
                            const TextStyle(color: Colors.black)),
                        /*vistas.textForm(
                      "Precio Venta Dos",
                      _precioVentaDos,
                      false,
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.blueAccent,
                      ),
                      const TextInputType.numberWithOptions(decimal: false),
                      8),
                  vistas.textForm(
                      "Precio Venta Tres",
                      _precioVentaTres,
                      false,
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.blueAccent,
                      ),
                      const TextInputType.numberWithOptions(decimal: false),
                      8),*/
                        widget.isRegister
                            ? ButtomForm(
                                label: "Registrar Articulo",
                                onPressed: registrarArticulo,
                                isLoading: isLoading)
                            : ButtomForm(
                                label: "Actualizar Articulo",
                                onPressed: actualizarArticulo,
                                isLoading: isLoading),
                        const Divider(color: Colors.black12),
                        CodigosBarras(
                          cb: codigosBarras,
                          registrar: registrarCodBarra,
                          actualizar: () {},
                        ),
                        const Divider(color: Colors.black12),
                        Existencias(
                            existencias: existencias,
                            registrar: (){},
                            actualizar: (){}),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}

class CodigosBarras extends StatefulWidget {
  List<IntArticuloCodBarra> cb;
  Function registrar;
  Function actualizar;

  CodigosBarras(
      {Key? key,
      required this.cb,
      required this.registrar,
      required this.actualizar})
      : super(key: key);

  @override
  State<CodigosBarras> createState() => _CodigosBarrasState();
}

class _CodigosBarrasState extends State<CodigosBarras> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Codigos de Barras",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => widget.registrar,
                icon: const Icon(CupertinoIcons.add_circled,
                    color: Colors.green, size: 35)),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      widget.cb.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Cod(${index + 1}):\n${widget.cb[index].codBarra}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                IconButton(
                                    color: Colors.indigoAccent,
                                    visualDensity:
                                        VisualDensity.adaptivePlatformDensity,
                                    tooltip: "Editar",
                                    onPressed: () {},
                                    icon: const Icon(
                                        CupertinoIcons
                                            .pencil_ellipsis_rectangle,
                                        semanticLabel: "Editar"))
                              ],
                            ),
                          )),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Existencias extends StatefulWidget {
  List<IntExistencia> existencias;
  Function registrar;
  Function actualizar;
  Existencias({Key? key, required this.existencias, required this.registrar, required this.actualizar}) : super(key: key);

  @override
  State<Existencias> createState() => _ExistenciasState();
}

class _ExistenciasState extends State<Existencias> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Existencia",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.start),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.add_circled,
                    color: Colors.green, size: 35)),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      widget.existencias.length,
                          (index) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.existencias[index].almId} : ${widget.existencias[index].exiExistencia}",
                              style: const TextStyle(
                                  color: Colors.black45),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
