import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VentanasEmergentes {
  showSnackBarGral(String mensaje, Icon icon, Color color, BuildContext context,
      GlobalKey<ScaffoldState> key) {
    final snackBar = SnackBar(
      content: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            icon,
            Expanded(child: Text(mensaje)),
          ],
        ),
      ),
      duration: const Duration(seconds: 7),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showSnackBar(String mensaje, int estado, BuildContext context,
      GlobalKey<ScaffoldState> key) {
    final snackBar = SnackBar(
      content: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(estado != 200 ? Icons.warning : Icons.check_circle,
                  color: Colors.white),
            ),
            Expanded(child: Text(mensaje, style: const TextStyle(color: Colors.white))),
          ],
        ),
      ),
      duration: const Duration(seconds: 7),
      backgroundColor: estado != 200 ? Colors.redAccent : Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // key.currentState.showSnackBar(snackbar);
  }

  showSnackBarInfo(String mensaje, int estado, BuildContext context,
      GlobalKey<ScaffoldState> key) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(estado != 1 ? Icons.warning : Icons.check_circle,
              color: Colors.white),
          Expanded(child: Text(mensaje)),
        ],
      ),
      duration: const Duration(seconds: 7),
      backgroundColor: Colors.blueAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // key.currentState.showSnackBar(snackbar);
  }

  mostrarMensajeEmergente(BuildContext context, Function callBack,
      Function ejecutar, String respuesta, int tipo) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Row(
                children: const <Widget>[
                  Icon(Icons.info, size: 40, color: Colors.blueAccent),
                  SizedBox(width: 20),
                  Text("ALERTA!",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 18)),
                ],
              ),
              content: Text(respuesta),
              actions: <Widget>[
                IconButton(
                    icon: const Icon(Icons.clear,
                        size: 28, color: Colors.redAccent),
                    onPressed: () => callBack),
                const SizedBox(width: 20),
                IconButton(
                    icon: const Icon(Icons.done_outline,
                        size: 28, color: Colors.green),
                    onPressed: () => ejecutar)
              ],
            ));
  }

  mostrarMensajeEmergenteSinF(
      BuildContext context, Function callBack, String respuesta) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Row(
                children: const <Widget>[
                  Icon(Icons.info_outline, size: 40, color: Colors.blueAccent),
                  SizedBox(width: 20),
                  Text("ALERTA!",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 18)),
                ],
              ),
              content: Text(respuesta),
              actions: <Widget>[
                IconButton(
                    icon: const Icon(Icons.done_all_outlined,
                        size: 28, color: Colors.green),
                    onPressed: () => callBack)
              ],
            ));
  }

  Widget cardMenu(BuildContext context, String title, String subtitle,
      Icon icon, Function onTap) {
    return InkWell(
      splashColor: Colors.amberAccent,
      onTap: () => onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            // color: Palette.darkBlue.withOpacity(0.55),
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600))),
                Text(subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            color: Colors.white38,
                            fontSize: 11,
                            fontWeight: FontWeight.w600))),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
