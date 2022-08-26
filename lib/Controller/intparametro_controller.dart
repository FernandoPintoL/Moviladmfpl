import 'package:proyectoadmfpl/Controller/request_controller.dart';
import 'package:proyectoadmfpl/Model/intparametro.dart';
import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';

class IntParametroController {
  RequestController requestController = RequestController();
  dynamic respuesta = {'status': 111, 'data': 'Sucedio algun error'};

  static List<IntParametro> parseArticulos(String responseBody){
    final parsed = convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<IntParametro> list = parsed.map<IntParametro>((json) => IntParametro.fromMap(json)).toList();
    return list;
  }

  Future<IntParametro> getIdArticulo() async {
    IntParametro intArticulo = IntParametro();
    dynamic response = await requestController.requestGet("api/parametro/idArticulo");
    if(response.statusCode == 200){
      final parsed = convert.jsonDecode(response.body);
      intArticulo = IntParametro.fromMap(parsed);
      return intArticulo;
    }
    return intArticulo;
  }

  Future<dynamic> actualizarId(IntParametro parametro) async {
    IntParametro intArticulo = IntParametro();
    dynamic response = await requestController.requestPost("api/parametro/update", parametro);
    if(response.statusCode == 200){
      final parsed = convert.jsonDecode(response.body);
      intArticulo = IntParametro.fromMap(parsed);
      return intArticulo;
    }
    return intArticulo;
  }
}