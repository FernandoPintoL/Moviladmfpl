import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:proyectoadmfpl/Controller/empresa_local_controller.dart';

class RequestController {
  EmpresaLocalController empresa = EmpresaLocalController();
  dynamic respuesta = {'status': 111, 'data': "No se ejecuto ninguna funcion"};

  Future<dynamic> requestPost(String urlInc, dynamic data) async {
    try {
      String url = await empresa.getUrl();
      Uri urlUri = Uri.parse("$url/$urlInc");
      debugPrint(urlUri.toString());
      var response = await http.post(urlUri,
          headers: {'Content-Type': 'application/json'},
          body: convert.jsonEncode(data));
      return response;
    } catch (error) {
      respuesta['data'] = error;
      return respuesta;
    }
  }
}
