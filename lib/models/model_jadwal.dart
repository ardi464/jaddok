import 'dart:convert';

ModelJadwal modelJadwalFromJson(String str) =>
    ModelJadwal.fromJson(json.decode(str));

String modelJadwalToJson(ModelJadwal data) => json.encode(data.toJson());

class ModelJadwal {
  List<Datum> data;

  ModelJadwal({
    this.data,
  });

  factory ModelJadwal.fromJson(Map<String, dynamic> json) => ModelJadwal(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String idRs;
  String namaRs;
  String fotoRs;
  List<Datahari> datahari;

  Datum({
    this.idRs,
    this.namaRs,
    this.fotoRs,
    this.datahari,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idRs: json["id_rs"],
        namaRs: json["nama_rs"],
        fotoRs: json["foto_rs"],
        datahari: List<Datahari>.from(
            json["datahari"].map((x) => Datahari.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_rs": idRs,
        "nama_rs": namaRs,
        "foto_rs":fotoRs,
        "datahari": List<dynamic>.from(datahari.map((x) => x.toJson())),
      };
}

class Datahari {
  String hariKd;
  String hari;
  List<Waktu> waktu;

  Datahari({
    this.hariKd,
    this.hari,
    this.waktu,
  });

  factory Datahari.fromJson(Map<String, dynamic> json) => Datahari(
        hariKd: json["hari_kd"],
        hari: json["hari"],
        waktu: List<Waktu>.from(json["waktu"].map((x) => Waktu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "hari_kd": hariKd,
        "hari": hari,
        "waktu": List<dynamic>.from(waktu.map((x) => x.toJson())),
      };
}

class Waktu {
  String jam;
  String status;

  Waktu({
    this.jam,
    this.status,
  });

  factory Waktu.fromJson(Map<String, dynamic> json) => Waktu(
        jam: json["jam"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "jam": jam,
        "status": status,
      };
}
