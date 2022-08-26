import 'package:flutter/cupertino.dart';
import 'package:proyectoadmfpl/Model/empresa.dart';

import 'data_base_helper.dart';

class EmpresaLocalController{
  String tblId = "id", tblNombre = "nombre", tblUrl = "url", table = "empresa";
  final dbHelper = DatabaseHelper.instance;

  void insert(Empresa empresa) async{
    final id = await dbHelper.insert(table, empresa.toMap());
    debugPrint('inserted row id: ${id.toString()}');
  }

  Future<void> update(Empresa empresa) async{
    String where = "$tblId = ?";
    List whereArgs = [ empresa.getId ];
    final rowAffected = await dbHelper.update(table, empresa.toMap(), where, whereArgs);
    debugPrint('inserted row id: $rowAffected');
  }

  Future<String> getUrl() async{
    final allRows = await dbHelper.queryAllRows(table);
    if(allRows.isEmpty){
      Empresa empresa = Empresa();
      insert(empresa);
      return empresa.getUrl;
    }
    var first = allRows.first;
    return first['url'].toString();
  }

  /*void query() async {
    final allRows = await dbHelper.queryAllRows(table);
    if(allRows.isEmpty){
      return [];
    }
    var first = allRows.first;
    print(first['url']);
  }*/

  Future<Empresa> getFirstEmpresa() async{
    final allRows = await dbHelper.queryAllRows(table);
    dynamic first = allRows.first;
    Empresa empresa = Empresa.fromMap(first);
    return empresa;
  }
}