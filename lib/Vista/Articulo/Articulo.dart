import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoadmfpl/Controller/EmpresaLocalController.dart';
import 'package:proyectoadmfpl/Controller/IntArticuloController.dart';

import '../../Model/Empresa.dart';
class Articulo extends StatefulWidget {
  const Articulo({Key? key}) : super(key: key);

  @override
  State<Articulo> createState() => _ArticuloState();
}

class _ArticuloState extends State<Articulo> {
  EmpresaLocalController empresaLocalController = EmpresaLocalController();
  Empresa empresa = Empresa(id: 1, nombre: "AdmFpl", url: "http://192.168.1.4:8000");
  IntArticuloController intArticuloController = IntArticuloController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Articulos")),
      body: SafeArea(
        child: Padding(
          padding:  const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hola"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
