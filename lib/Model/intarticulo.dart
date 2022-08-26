class IntArticulo {
  int? artId;
  String? artNombre, artFraccionado, artDescripcion, artDirFoto;
  double? artPrecioVenta, artPrecioVentaDos, artPrecioVentaTres;
  bool? artIsShop;

  IntArticulo({
    artId = 0,
    artNombre = "",
    artPrecioVenta = 0,
    artFraccionado = "N",
    artPrecioVentaDos = 0,
    artPrecioVentaTres = 0,
    artDescripcion = "",
    artDirFoto = "assets/images/dashboard/folder.png",
    artIsShop = false});

  IntArticulo.fromMap(Map<dynamic, dynamic> map){
    artId = map['artId'] == null ? 0 : int.tryParse(map['artId'].toString());
    artNombre = map['artNombre'] ?? "";
    artPrecioVenta = map['artPrecioVenta'] == null ? 0 :double.tryParse(map['artPrecioVenta'].toString());
    artPrecioVentaDos = map['artPrecioVentaDos'] == null ? 0 : double.tryParse(map['artPrecioVentaDos'].toString());
    artPrecioVentaTres = map['artPrecioVentaTres'] == null ? 0 :double.tryParse(map['artPrecioVentaTres'].toString());
    artFraccionado = map['artFraccionado'] ?? "";
    artDescripcion = map['artDescripcion'] ?? "";
    artDirFoto = "assets/images/dashboard/folder.png";
    artIsShop = false;
  }
  factory IntArticulo.fromJson(Map<dynamic, dynamic> json) => IntArticulo(
      artId : json['artId'] == null ? 0 : int.tryParse(json['artId'].toString()),
      artNombre: json['artNombre'] ?? "",
      artPrecioVenta: json['artPrecioVenta'] == null ? 0 : double.tryParse(json['artPrecioVenta'].toString())!,
      artPrecioVentaDos: json['artPrecioVentaDos'] == null ? 0 : double.tryParse(json['artPrecioVentaDos'].toString()),
      artPrecioVentaTres: json['artPrecioVentaTres'] == null ? 0 : double.tryParse(json['artPrecioVentaTres'].toString()),
      artDescripcion: json['artDescripcion'] ?? "",
      artFraccionado: json['artFraccionado'] ?? "N",
      artDirFoto: "assets/images/dashboard/folder.png",
      artIsShop: false
  );

  Map<String, dynamic> toMap() => {
    "artId": artId.toString(),
    "artNombre": artNombre,
    "artPrecioVenta": artPrecioVenta == null ? "0" : artPrecioVenta.toString(),
    "artPrecioVentaDos": artPrecioVentaDos == null ? "0" : artPrecioVentaDos.toString(),
    "artPrecioVentaTres": artPrecioVentaTres == null ? "0" : artPrecioVentaTres.toString(),
    "artDescripcion": artDescripcion ?? "",
    "artDirFoto": artDirFoto ?? "assets/images/dashboard/folder.png",
    "artFraccionado" : artFraccionado ?? "N",
    "artIsShop" : "0"
  };


  int get getArticuloId => artId!;
  String get getArticuloNombre => artNombre!;
  String get getArticuloDescripcion => artDescripcion!;
  double get getArticuloPrecioVenta => artPrecioVenta!;
  double get getArticuloPrecioVentaDos => artPrecioVentaDos!;
  double get getArticuloPrecioVentaTres => artPrecioVentaTres!;
  String get getArticuloDirFoto => artDirFoto!;
  String get getArticuloFraccionado => artFraccionado!;
  bool get getArticuloIsShop => artIsShop!;

  set setId(int value) => artId = value;
  set setNombre(String value)=> artNombre = value;
  set setDescripcion(String value)=> artDescripcion = value;
  set setPrecioVenta(double value)=> artPrecioVenta = value;
  set setPrecioVentaDos(double value)=> artPrecioVentaDos = value;
  set setPrecioVentaTres(double value)=> artPrecioVentaTres = value;
  set setFoto(String value)=> artDirFoto = value;
  set setFraccionado(String value)=> artFraccionado = value;
  set setIsShop(bool value) => artIsShop = value;
}