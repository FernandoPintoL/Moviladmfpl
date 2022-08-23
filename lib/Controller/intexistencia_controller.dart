import 'package:proyectoadmfpl/Controller/request_controller.dart';
import 'dart:convert' as convert;

import 'package:proyectoadmfpl/Model/intexistencia.dart';

class IntExistenciaController{
  RequestController requestController = RequestController();
  dynamic respuesta = {'status': 111, 'data': 'Sucedio algun error'};

  static List<IntExistencia> parseArticuloExistencias(String responseBody){
    final parsed = convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<IntExistencia> list = parsed.map<IntExistencia>((json) => IntExistencia.fromMap(json)).toList();
    return list;
  }

  Future<dynamic> getExistenciasArticulos(int artId) async {
    try{
      dynamic response = await requestController.requestPost("api/articulo/existencia", {'artId' :  artId.toString()});
      if(response.statusCode == 200){
        List<IntExistencia> existencias = parseArticuloExistencias(response.body);
        respuesta['status'] = response.statusCode;
        respuesta['data'] = existencias;
        return respuesta;
      }
      return respuesta;
    }catch(error){
      respuesta['data'] = error;
      return respuesta;
    }
  }
}