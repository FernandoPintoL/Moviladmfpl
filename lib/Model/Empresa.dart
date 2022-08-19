class Empresa{
  int? id;
  String? nombre, url;

  Empresa({
    this.id = 0,
    this.nombre = "AdmFpl",
    this.url = "http://192.168.1.14:8000/"
  });

  Empresa.fromMap(Map<dynamic, dynamic> map){
    id = int.tryParse(map['id'].toString());
    nombre = map['nombre'];
    url = map['url'];
  }

  factory Empresa.fromJson(Map<dynamic, dynamic> json) => Empresa(
      id: int.tryParse(json['id'].toString()),
      nombre: json['nombre'],
      url: json['url']);

  Map<String, dynamic> toMap() =>{
    "id" : id.toString(),
    "nombre" : nombre,
    "url" : url
  };

  int get getId => id!;
  String get getNombre => nombre!;
  String get getUrl => url!;

  set setId(int value) => id = value;
  set setNombre(String value) => nombre = value;
  set setUrl(String value) => url = value;
}