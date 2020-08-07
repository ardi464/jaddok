import 'dart:convert';

ModelDokter modelJadwalFromJson(String str) =>
    ModelDokter.fromJson(json.decode(str));

String modelJadwalToJson(ModelDokter data) => json.encode(data.toJson());

class ModelDokter {
  List<Datum> data;

  ModelDokter({
    this.data,
  });

  factory ModelDokter.fromJson(Map<String, dynamic> json) => ModelDokter(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String idDokter;
  String nama;
  String fotoDokter;
  String spesialis;
  List<Datahari> datahari;

  Datum({
    this.idDokter,
    this.nama,
    this.spesialis,
    this.fotoDokter,
    this.datahari,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idDokter: json["id_dokter"],
        nama: json["nama"],
        spesialis: json["spesialis"],
        fotoDokter: json["foto_dokter"],
        datahari: List<Datahari>.from(
            json["datahari"].map((x) => Datahari.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_dokter": idDokter,
        "nama": nama,
        "spesialis":spesialis,
        "foto_dokter": fotoDokter,
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
