import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proyectoadmfpl/Controller/empresa_local_controller.dart';
import 'package:proyectoadmfpl/Controller/intarticulocodbarra_controller.dart';
import 'package:proyectoadmfpl/Controller/intarticulo_controller.dart';
import 'package:proyectoadmfpl/Controller/intexistencia_controller.dart';
import 'package:proyectoadmfpl/Model/intarticulo.dart';
import 'package:proyectoadmfpl/Model/intarticulocodbarra.dart';
import 'package:proyectoadmfpl/Model/intexistencia.dart';
import 'package:proyectoadmfpl/Vista/Articulo/register_update_codbarras.dart';
import 'package:proyectoadmfpl/Vista/Articulo/register_update_existencias.dart';
import 'package:proyectoadmfpl/Vista/Themes/Components/buttom_forms.dart';
import 'package:proyectoadmfpl/Vista/Themes/Components/form_text_field.dart';
import 'package:proyectoadmfpl/Vista/Themes/Components/mssg_emergentes.dart';

//ignore: must_be_immutable
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
      debugPrint(articuloAux.toMap().toString());
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
    debugPrint(response);
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

