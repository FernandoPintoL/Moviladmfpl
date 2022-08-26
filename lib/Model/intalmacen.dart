class IntAlmacen{
  String? almId, almNombre, dirId, lprId, galId, almFechaCambio, almHabilitado, sucId;

  IntAlmacen({
    almId = "",
    almNombre = "",
    dirId = "",
    lprId = "",
    galId = "",
    almFechaCambio = "",
    almHabilitado = "",
    sucId = ""
  });

  IntAlmacen.fromMap(Map<dynamic, dynamic> map) {
    almId = map['almId'] ?? "";
    almNombre = map['almNombre'] ?? "";
    dirId = map['dirId'] ?? "";
    lprId = map['lprId'] ?? "";
    galId = map['galId'] ?? "";
    almFechaCambio = map['almFechaCambio'] ?? "";
    almHabilitado = map['almHabilitado'] ?? "";
    sucId = map['sucId'] ?? "";
  }

  factory IntAlmacen.fromJson(Map<dynamic, dynamic> json) => IntAlmacen(
      almId: json['almId'] ?? "",
      almNombre: json['almNombre'] ?? "",
      dirId: json['dirId'] ?? "",
      lprId: json['lprId'] ?? "",
      galId: json['galId'] ?? "",
      almFechaCambio: json['almFechaCambio'] ?? "",
      almHabilitado: json['almHabilitado'] ?? "",
      sucId: json['sucId'] ?? "",
  );

  Map<String, dynamic> toMap() => {
    "almId" : almId,
    "almNombre" : almNombre,
    "dirId" : dirId ?? "",
    "lprId" : lprId ?? "",
    "galId" : galId ?? "",
    "almFechaCambio" : almFechaCambio ?? "",
    "almHabilitado" : almHabilitado ?? "",
    "sucId" : sucId ?? ""
  };

  String get getAlmId => almId!;
  String get getAlmNombre => almNombre!;
  String get getDirId => dirId!;
  String get getLprId => lprId!;
  String get getGalId => galId!;
  String get getAlmFechaCambio => almFechaCambio!;
  String get getAlmHabilitado => almHabilitado!;
  String get getSucId => sucId!;

  set setAlmId(String value) => almId = value;
  set setAlmNombre(String value) => almNombre = value;
  set setDirId(String value) => dirId = value;
  set setLprId(String value) => lprId = value;
  set setGalId(String value) => galId = value;
  set setAlmFechaCambio(String value) => almFechaCambio = value;
  set setAlmHabilitado(String value) => almHabilitado = value;
  set setSucId(String value) => sucId = value;
}