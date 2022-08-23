import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoadmfpl/Model/intexistencia.dart';
//ignore: must_be_immutable
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