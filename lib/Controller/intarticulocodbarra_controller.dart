import 'package:flutter/cupertino.dart';
import 'package:proyectoadmfpl/Controller/intarticulo_controller.dart';
import 'package:proyectoadmfpl/Controller/request_controller.dart';
import 'package:proyectoadmfpl/Model/intarticulo.dart';
import 'package:proyectoadmfpl/Model/intarticulocodbarra.dart';
import 'dart:convert' as convert;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

class IntArticuloCodBarraController{
  RequestController requestController = RequestController();
  dynamic respuesta = {'status': 111, 'data': 'Sucedio algun error'};

  static List<IntArticuloCodBarra> parseArticulosCodBarra(String responseBody){
    final parsed = convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<IntArticuloCodBarra> list = parsed.map<IntArticuloCodBarra>((json) => IntArticuloCodBarra.fromMap(json)).toList();
    return list;
  }

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
  }

  Future<dynamic> getCodsBarrasArticulos(int artId) async {
    dynamic response = await requestController.requestPost("api/articulo/codbarras", {'artId' :  artId.toString()});
    respuesta['status'] = response.statusCode;
    if(response.statusCode == 200){
      List<IntArticuloCodBarra> codsBarras = parseArticulosCodBarra(response.body);
      respuesta['data'] = codsBarras;
      return respuesta;
    }
    respuesta['data'] = convert.jsonDecode(response.body);
    return respuesta;
  }

  Future<dynamic> getCodBarraArticulo(String codBarra) async {
    List<IntArticulo> listArticulo = [];
    dynamic response = await requestController.requestPost("api/articulo/codbarra", {'codBarra' :  codBarra});
    respuesta['status'] = response.statusCode;
    final parsed = convert.jsonDecode(response.body);
    if(response.statusCode == 200){
      final IntArticuloCodBarra codBarra = IntArticuloCodBarra.fromMap(parsed);
      IntArticulo articulo = await IntArticuloController().show(codBarra.artId!);
      listArticulo.add(articulo);
      respuesta['data'] = listArticulo;
      return respuesta;
    }
    respuesta['data'] = parsed;
    return respuesta;
  }

  Future<dynamic> registrar(int artId) async {
    String codBarra = await scanBarcodeNormal();
    dynamic response = await requestController.requestPost("api/articulo/register/codbarra", {
      "artId" :  artId.toString(),
      "codBarra" : codBarra});
    debugPrint(response.body);
    respuesta['status'] = response.statusCode;
    final parsed = convert.jsonDecode(response.body);
    if(response.statusCode == 200){
      IntArticuloCodBarra articuloCodBarra = IntArticuloCodBarra.fromMap(parsed);
      respuesta['data'] = articuloCodBarra;
      return respuesta;
    }
    respuesta['data'] = parsed;
    return respuesta;
  }

  Future<dynamic> actualizar(int tadId) async {
    String codBarra = await scanBarcodeNormal();
    dynamic response = await requestController.requestPost("api/articulo/update/codbarra", {
      "artId" :  tadId.toString(),
      "codBarra" : codBarra});
    debugPrint(response.body);
    respuesta['status'] = response.statusCode;
    final parsed = convert.jsonDecode(response.body);
    if(response.statusCode == 200){
      IntArticuloCodBarra articuloCodBarra = IntArticuloCodBarra.fromMap(parsed);
      respuesta['data'] = articuloCodBarra;
      return respuesta;
    }
    respuesta['data'] = parsed;
    return respuesta;
  }

}