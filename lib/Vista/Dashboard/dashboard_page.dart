import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectoadmfpl/Vista/Account/account_page.dart';
import 'package:proyectoadmfpl/Vista/Dashboard/dashboard_controller.dart';
import 'package:proyectoadmfpl/Vista/Home/home_page.dart';
import 'package:proyectoadmfpl/Vista/Themes/Components/buscador.dart';
import 'package:proyectoadmfpl/Vista/Themes/config.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool buscar = false;
  String _scanBarcode = 'Unknown';
  void changeBuscar(){
    setState(() {
      buscar = !buscar;
    });
  }
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<String> scanBarcodeNormal() async {
    String barcodeScanRes = "";
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      return barcodeScanRes;
    } on PlatformException {
      barcodeScanRes = "";
      return barcodeScanRes;
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    /*if (!mounted) return barcodeScanRes;
    return barcodeScanRes;*/
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Palette().kPrimaryColor,
              elevation: 0,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Adm Fpl',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16)),
                  buscar ? Expanded(child: Buscador(dashboardController: controller, function: changeBuscar, scaffoldKey: scaffoldKey)) :
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: const Icon(CupertinoIcons.search), onPressed: changeBuscar),
                      IconButton(icon: const Icon(CupertinoIcons.barcode), onPressed: () async{
                        _scanBarcode = await scanBarcodeNormal();
                        controller.query = "Conincidencias con : $_scanBarcode";
                        controller.consultarArticulosCodBarra(_scanBarcode);
                      }),
                    ],
                  ),
                ],
              ),
            ),
            // drawer: MenuDraw(function: controller.changeTabIndex),
            body: SafeArea(
                child: Center(
                    child: IndexedStack(
                        index: controller.tabIndex,
                        children: [
                          HomePage(dashboardController: controller),
                          AccountPage(dashboardController: controller)
                        ]
                    ))),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              selectedItemColor: Colors.teal,
              onTap: controller.changeTabIndex,
              currentIndex: controller.tabIndex,
              type: BottomNavigationBarType.fixed,
              items: [
                _bottomNavigationBarItem(CupertinoIcons.home, "Inicio"),
                _bottomNavigationBarItem(
                    CupertinoIcons.person_alt_circle,
                    /*controller.usuario != null && controller.usuario.getId > 0
                        ? controller.usuario.getName :*/
                    'Inicia o Registrate'),
              ],
            ),
          );
        });
  }
  _bottomNavigationBarItem(IconData iconData, String labelData) {
    return BottomNavigationBarItem(icon: Icon(iconData), label: labelData);
  }
}
