class IntExistencia{
  String? almId;
  int? artId;
  double? exiExistencia;

  IntExistencia({
    almId = "",
    artId = 0,
    exiExistencia = 0
  });

  IntExistencia.fromMap(Map<dynamic, dynamic> map){
    almId = map['almId'];
    artId = int.tryParse(map['artId'].toString());
    exiExistencia = double.tryParse(map['exiExistencia'].toString());
  }

  factory IntExistencia.fromJson(Map<dynamic, dynamic> json) => IntExistencia(
      almId: json['almId'],
      artId: int.tryParse(json['artId'].toString()),
      exiExistencia: double.tryParse(json['exiExistencia'].toString()),
  );

  Map<String, dynamic> toMap() => {
    "almId" : almId,
    "artId" : artId.toString(),
    "exiExistencia" : exiExistencia.toString()
  };

  String get getAlmId => almId!;
  int get getArtId => artId!;
  double get getExiExistencia => exiExistencia!;

  set setAlmId(String value) => almId = value;
  set setArtId(int value) => artId = value;
  set setExiExistencia(double value) => exiExistencia = value;
}