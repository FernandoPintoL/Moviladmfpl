class IntParametro {
  int? inpId, inpContadorArticulo;

  IntParametro({inpId = 0, inpContadorArticulo = 0});

  IntParametro.fromMap(Map<dynamic, dynamic> map) {
    inpId = int.tryParse(map['inpId'].toString());
    inpContadorArticulo = int.tryParse(map['inpContadorArticulo'].toString());
  }

  factory IntParametro.fromJson(Map<dynamic, dynamic> json) => IntParametro(
    inpId : int.tryParse(json['inpId'].toString()),
    inpContadorArticulo: int.tryParse(json['inpContadorArticulo'].toString()),
  );

  Map<String, dynamic> toMap() => {
    "inpId": inpId.toString(),
    "inpContadorArticulo": inpContadorArticulo.toString(),
  };

  int get getInpId => inpId!;
  int get getInpContadorArticulo => inpContadorArticulo!;

  set setInpId(int value) => inpId = value;
  set setInpContadorArticulo(int value)=> inpContadorArticulo = value;
}
