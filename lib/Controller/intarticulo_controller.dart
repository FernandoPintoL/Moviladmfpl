import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:proyectoadmfpl/Controller/request_controller.dart';
import 'package:proyectoadmfpl/Model/intarticulo.dart';

class IntArticuloController{
  RequestController requestController = RequestController();
  dynamic respuesta = {'status': 111, 'data': 'Sucedio algun error'};

  static List<IntArticulo> parseArticulos(String responseBody){
    final parsed = convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<IntArticulo> list = parsed.map<IntArticulo>((json) => IntArticulo.fromMap(json)).toList();
    return list;
  }

  Future<IntArticulo> show(int artId) async {
    IntArticulo intArticulo = IntArticulo();
    try{
      dynamic response = await requestController.requestPost("api/articulo/show", {'artId' :  artId.toString()});
      if(response.statusCode == 200){
        final parsed = convert.jsonDecode(response.body);
        intArticulo = IntArticulo.fromMap(parsed);
        return intArticulo;
      }
      return intArticulo;
    }catch(error){
      return intArticulo;
    }
  }

  Future<dynamic> registrar(IntArticulo articulo) async {
    IntArticulo intArticulo = IntArticulo();
    try{
      dynamic response = await requestController.requestPost("api/articulo/registar", articulo.toMap());
      respuesta['status'] = response.statusCode;
      final parsed = convert.jsonDecode(response.body);
      if(response.statusCode == 200){
        intArticulo = IntArticulo.fromMap(parsed);
        respuesta['data'] = intArticulo;
        return respuesta;
      }
      respuesta['data'] = parsed;
      return respuesta;
    }catch(error){
      debugPrint(error.toString());
      return intArticulo;
    }
  }

  Future<dynamic> actualizar(IntArticulo articulo) async {
    IntArticulo intArticulo = IntArticulo();
    try{
      dynamic response = await requestController.requestPost("api/articulo/update", articulo.toMap());
      debugPrint(response.body);
      respuesta['status'] = response.statusCode;
      final parsed = convert.jsonDecode(response.body);
      if(response.statusCode == 200){
        intArticulo = IntArticulo.fromMap(parsed);
        respuesta['data'] = intArticulo;
        return respuesta;
      }
      respuesta['data'] = parsed;
      return respuesta;
    }catch(error){
      debugPrint(error.toString());
      return intArticulo;
    }
  }

  Future<dynamic> getQueryArticulo(String query) async {
    List<IntArticulo> listArticulo = [];
    try{
      dynamic response = await requestController.requestPost("api/articulo/query", {'query' :  query});
      debugPrint(response.body);
      respuesta['status'] = response.statusCode;
      final parsed = convert.jsonDecode(response.body);
      if(response.statusCode == 200){
        listArticulo = parseArticulos(response.body);
        respuesta['data'] = listArticulo;
        return respuesta;
      }
      respuesta['data'] = parsed;
      return respuesta;
    }catch(error){
      respuesta['data'] = error;
      return respuesta;
    }
  }
}