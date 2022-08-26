import 'package:flutter/cupertino.dart';
import 'package:proyectoadmfpl/Controller/request_controller.dart';
import 'package:proyectoadmfpl/Model/intalmacen.dart';
import 'dart:convert' as convert;

class IntAlmacenController {
  static RequestController requestController = RequestController();
  dynamic respuesta = {'status': 111, 'data': 'Sucedio algun error'};

  static List<IntAlmacen> parseArticulos(String responseBody){
    final parsed = convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<IntAlmacen> list = parsed.map<IntAlmacen>((json) => IntAlmacen.fromMap(json)).toList();
    return list;
  }

  Future<dynamic> getAlmacenes(String query) async{
    List<IntAlmacen> listAlmacenes = [];
    dynamic response = await requestController.requestPost("api/almacen/query", {'query' :  query});
    respuesta['status'] = response.statusCode;
    final parsed = convert.jsonDecode(response.body);
    if(response.statusCode == 200){
      listAlmacenes = parseArticulos(response.body);
      respuesta['data'] = listAlmacenes;
      return respuesta;
    }
    respuesta['data'] = parsed;
    return respuesta;
  }
}