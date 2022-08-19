import 'package:proyectoadmfpl/Model/Empresa.dart';

import 'DataBaseHelper.dart';

class EmpresaLocalController{
  String tblId = "id", tblNombre = "nombre", tblUrl = "url", table = "empresa";
  final dbHelper = DatabaseHelper.instance;

  void insert(Empresa empresa) async{
    final id = await dbHelper.insert(table, empresa.toMap());
    print('inserted row id: $id');
  }

  Future<void> update(Empresa empresa) async{
    String where = "$tblId = ?";
    List whereArgs = [ empresa.getId ];
    final rowAffected = await dbHelper.update(table, empresa.toMap(), where, whereArgs);
    print('inserted row id: $rowAffected');
  }

  Future<String> getUrl() async{
    final allRows = await dbHelper.queryAllRows(table);
    var first = allRows.first;
    return first['url'].toString();
  }

  void query() async {
    final allRows = await dbHelper.queryAllRows(table);
    print('query all rows: ');
    allRows.forEach(print);
    var first = allRows.first;
    print(first['url']);
  }

  Future<Empresa> getFirstEmpresa() async{
    final allRows = await dbHelper.queryAllRows(table);
    dynamic first = allRows.first;
    print(first);
    Empresa empresa = Empresa.fromMap(first);
    return empresa;
  }
}