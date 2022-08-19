class IntArticuloCodBarra {
  int? artId, tadId;
  String? codBarra;

  IntArticuloCodBarra({tadId, artId, codBarra});

  IntArticuloCodBarra.fromMap(Map<dynamic, dynamic> map) {
    tadId = map['tadId'] == null ? 0 : int.tryParse(map['tadId'].toString());
    artId = map['artId'] == null ? 0 : int.tryParse(map['artId'].toString());
    codBarra = map['codBarra'] ?? "";
  }

  factory IntArticuloCodBarra.fromJson(Map<dynamic, dynamic> json) =>
      IntArticuloCodBarra(
          tadId: json['tadId'] == null
              ? 0
              : int.tryParse(json['tadId'].toString()),
          artId: json['artId'] == null
              ? 0
              : int.tryParse(json['artId'].toString()),
          codBarra: json['codBarra'] ?? "");

  Map<String, dynamic> toMap() => {
        "tadId": tadId.toString(),
        "artId": artId.toString(),
        "codBarra": codBarra
      };

  int get getArtId => artId!;

  String get getCodBarra => codBarra!;

  set setArtId(int value) => artId = value;

  set setCodBarra(String value) => codBarra = value;
}
