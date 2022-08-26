import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoadmfpl/Controller/empresa_local_controller.dart';
import 'package:proyectoadmfpl/Controller/intarticulocodbarra_controller.dart';
import 'package:proyectoadmfpl/Controller/intarticulo_controller.dart';
import 'package:proyectoadmfpl/Controller/intexistencia_controller.dart';
import 'package:proyectoadmfpl/Controller/intparametro_controller.dart';
import 'package:proyectoadmfpl/Model/intarticulo.dart';
import 'package:proyectoadmfpl/Model/intarticulocodbarra.dart';
import 'package:proyectoadmfpl/Model/intexistencia.dart';
import 'package:proyectoadmfpl/Model/intparametro.dart';
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
  bool isPostRegister;

  RegisterEditArticulo(
      {Key? key,
      required this.scaffoldKey,
      required this.articulo,
      required this.isEditing,
      required this.isRegister,
      required this.isPostRegister})
      : super(key: key);

  @override
  State<RegisterEditArticulo> createState() => _RegisterEditArticuloState();
}

class _RegisterEditArticuloState extends State<RegisterEditArticulo> {
  Vistas vistas = Vistas();
  bool isLoading = true;
  String urlImg = "";
  String imgUpReg = "Insertar Imagen";
  final GlobalKey<FormState> _formArticulokey = GlobalKey<FormState>();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _precioVenta = TextEditingController();
  final TextEditingController _precioVentaDos = TextEditingController();
  final TextEditingController _precioVentaTres = TextEditingController();
  List<IntArticuloCodBarra> codigosBarras = [];
  List<IntExistencia> existencias = [];

  void cargarDatos() async {
    _precioVentaDos.text = "0";
    _precioVentaTres.text = "0";
    if (widget.isEditing) {
      imgUpReg = "Actualizar Imagen";
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
      IntParametro parametro = await IntParametroController().getIdArticulo();
      IntArticulo articuloAux = IntArticulo();
      articuloAux.setId = parametro.getInpContadorArticulo;
      articuloAux.setNombre = _nombre.text;
      articuloAux.setDescripcion =
      _descripcion.text.isEmpty ? "" : _descripcion.text;
      articuloAux.artPrecioVenta = double.tryParse(_precioVenta.text);
      articuloAux.artPrecioVentaDos = double.tryParse(_precioVentaDos.text);
      articuloAux.artPrecioVentaTres = double.tryParse(_precioVentaTres.text);
      dynamic respuesta = await IntArticuloController().registrar(articuloAux);
      if(respuesta['status'] == 200) {
        parametro.setInpId = parametro.getInpContadorArticulo + 1;
        dynamic resParametro = await IntParametroController().actualizarId(parametro);
        if(resParametro['status'] == 200){
          IntArticulo articulo = respuesta['data'];
          dynamic cb = await IntArticuloCodBarraController()
              .getCodsBarrasArticulos(articulo.getArticuloId);
          if (cb['status'] == 200) {
            codigosBarras = cb['data'];
          }
          dynamic ext = await IntExistenciaController()
              .getExistenciasArticulos(articulo.getArticuloId);
          if (ext['status'] == 200) {
            existencias = ext['data'];
          }
        }
      }
      VentanasEmergentes().showSnackBar(
          respuesta['status'] == 200
              ? respuesta['data']
              : "Se registro correctamente!...",
          respuesta['status'],
          context,
          widget.scaffoldKey);
      setState(() {
        isLoading = false;
        widget.isPostRegister = true;
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
      dynamic respuesta = await IntArticuloController().actualizar(articuloAux);
      if(respuesta['status'] == 200) {
        IntArticulo articulo = respuesta['data'];
        widget.articulo = articulo;
      }
      VentanasEmergentes().showSnackBar(
          respuesta['status'] == 200
              ? "Se actualizo correctamente!..."
              : respuesta['data'],
          respuesta['status'],
          context,
          widget.scaffoldKey);
      setState(() {
        isLoading = false;
        widget.isPostRegister = true;
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
              widget.isEditing
                  ? Text("Cod.: ${widget.articulo.getArticuloId}",
                      style: const TextStyle(
                          color: CupertinoColors.darkBackgroundGray,
                          fontWeight: FontWeight.bold,
                          fontSize: 25))
                  : const SizedBox(height: 2),
              Center(
                child: ClipOval(
                    child: widget.isEditing
                        ? CachedNetworkImage(
                            height: 150,
                            width: 150,
                            imageUrl:
                                "$urlImg/${widget.articulo.getArticuloDirFoto}",
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(value: 12),
                            errorWidget: (context, url, error) => const Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 100,
                                  color: Colors.white,
                                ))
                        : const Icon(CupertinoIcons.shopping_cart,
                            color: CupertinoColors.link, size: 89)),
              ),
              Expanded(
                child: Form(
                  key: _formArticulokey,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListView(
                      children: [
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
                        widget.isRegister
                            ? ButtomForm(
                                label: "Registrar Articulo",
                                onPressed: registrarArticulo,
                                isLoading: isLoading)
                            : ButtomForm(
                                label: "Actualizar Articulo",
                                onPressed: actualizarArticulo,
                                isLoading: isLoading),
                        // const Divider(color: CupertinoColors.inactiveGray),
                        widget.isPostRegister
                            ? Column(
                                children: <Widget>[
                                  ElevatedButton(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Icon(Icons.add_a_photo_outlined,
                                              color: Colors.white),
                                          Expanded(
                                              child: Text(imgUpReg,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center)),
                                        ],
                                      ),
                                      onPressed: () {
                                        // Navigator.push(context, CupertinoPageRoute(builder: (context) => new ActualizarImgArticulo(articulo: widget.articulo)));
                                      }),
                                  const Divider(color: Colors.black12),
                                  CodigosBarras(
                                    cb: codigosBarras,
                                    registrar: registrarCodBarra,
                                    actualizar: () {},
                                  ),
                                  const Divider(color: Colors.black12),
                                  Existencias(
                                      existencias: existencias,
                                      registrar: () {},
                                      actualizar: () {}),
                                ],
                              )
                            : const SizedBox(height: 3),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
