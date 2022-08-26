import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoadmfpl/Model/intarticulocodbarra.dart';

//ignore: must_be_immutable
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
                                  style: const TextStyle(color: Colors.black45, fontSize: 18, fontWeight: FontWeight.w500),
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
