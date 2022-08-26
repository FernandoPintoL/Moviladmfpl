import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoadmfpl/Controller/intalmacen_controller.dart';
import 'package:proyectoadmfpl/Model/intalmacen.dart';
import 'package:proyectoadmfpl/Model/intexistencia.dart';
import 'package:proyectoadmfpl/Vista/Themes/Components/form_text_field.dart';

//ignore: must_be_immutable
class Existencias extends StatefulWidget {
  List<IntExistencia> existencias;
  Function registrar;
  Function actualizar;

  Existencias(
      {Key? key,
      required this.existencias,
      required this.registrar,
      required this.actualizar})
      : super(key: key);

  @override
  State<Existencias> createState() => _ExistenciasState();
}

class _ExistenciasState extends State<Existencias> {
  Vistas vistas = Vistas();
  final TextEditingController _existencia = TextEditingController();
  List<IntAlmacen> almacenes = [];
  List<String> almIds = [];
  bool isLoading = true;
  bool isRegister = false;
  bool isEditing = false;
  bool showForm = false;
  String almacenValue = "ALMCEN";
  String modo = "";
  IntAlmacen intAlmacen = IntAlmacen();

  void cargarAlmacenes() async {
    var respuesta = await IntAlmacenController().getAlmacenes("");
    if (respuesta['status'] == 200) {
      almacenes = respuesta['data'];
      if (almacenes.isNotEmpty) {
        intAlmacen = almacenes.first;
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void enableFormRegister() {
    setState(() {
      showForm = !showForm;
      isRegister = true;
      isEditing = false;
      modo = "Registrar Existencias";
    });
  }

  void enableFormEdit() {
    setState(() {
      showForm = !showForm;
      isRegister = false;
      isEditing = true;
      modo = "Actualizar Existencias";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarAlmacenes();
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
            children: [
              const Text("Existencias",
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
                      onPressed: (){
                        enableFormRegister();
                      },
                      icon: const Icon(CupertinoIcons.add_circled,
                          color: Colors.green, size: 35)),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            widget.existencias.length,
                            (index) => Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.existencias[index].almId} : ${widget.existencias[index].exiExistencia}",
                                      style: const TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    IconButton(
                                        onPressed: (){
                                          enableFormEdit();
                                        },
                                        icon: const Icon(
                                            CupertinoIcons
                                                .pencil_ellipsis_rectangle,
                                            color:
                                                CupertinoColors.systemIndigo))
                                  ],
                                )),
                      ),
                    ),
                  ),
                ],
              ),
              showForm
                  ? Column(
                      children: [
                        almacenes.isEmpty
                            ? const Text(
                                "No existe almacenes registrados o consultados",
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400))
                            : isRegister ? DropdownButton<IntAlmacen>(
                                value: intAlmacen,
                                enableFeedback: false,
                                icon: const Icon(Icons.arrow_downward,
                                    color: Colors.black45),
                                elevation: 16,
                                style: const TextStyle(
                                    color: Colors.blueGrey, fontSize: 16),
                                underline: Container(
                                  height: 2,
                                  color: Colors.black12,
                                ),
                                onChanged: (IntAlmacen? newValue) {
                                  setState(() {
                                    intAlmacen = newValue!;
                                    almacenValue = newValue.getAlmId;
                                  });
                                },
                                items: almacenes
                                    .map<DropdownMenuItem<IntAlmacen>>(
                                        (IntAlmacen value) {
                                  return DropdownMenuItem<IntAlmacen>(
                                    value: value,
                                    child: Text(
                                        "Id: ${value.getAlmId} / Descripcion: ${value.getAlmNombre}"),
                                  );
                                }).toList(),
                              ) : const SizedBox(height: 1),
                        vistas.textForm(
                            "Precio Venta",
                            _existencia,
                            false,
                            const Icon(
                              Icons.monetization_on,
                              color: Colors.blueAccent,
                            ),
                            const TextInputType.numberWithOptions(
                                decimal: false),
                            8,
                            const TextStyle(color: Colors.black)),
                        ElevatedButton(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Icon(Icons.update,
                                    color: Colors.white),
                                Expanded(
                                    child: Text(modo,
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                        textAlign: TextAlign.center)),
                              ],
                            ),
                            onPressed: () {
                              // Navigator.push(context, CupertinoPageRoute(builder: (context) => new ActualizarImgArticulo(articulo: widget.articulo)));
                            }),
                      ],
                    )
                  : const SizedBox(height: 1),
            ],
          );
  }
}
