class Dok {
  List<ModelDok> dok;

  Dok({this.dok});

  Dok.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      dok = new List<ModelDok>();
      json['data'].forEach((dt) {
        dok.add(new ModelDok.fromJson(dt));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dt = new Map<String, dynamic>();
    if (this.dok != null) {
      dt['data'] = this.dok.map((d) => d.toJson()).toList();
    }
    return dt;
  }
}

class ModelDok {
  String id;
  String nama;
  String fotoDok;
  String spesialis;

  ModelDok({this.id, this.nama, this.fotoDok,this.spesialis});

  ModelDok.fromJson(Map<String, dynamic> json) {
    this.id = json['id_dokter'];
    this.nama = json['nama'];
    this.fotoDok = json['foto_dokter'];
    this.spesialis = json['spesialis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dt = new Map<String, dynamic>();
    dt['id_dokter'] = this.id;
    dt['nama'] = this.nama;
    dt['foto_dokter'] = this.fotoDok;
    dt['spesialis'] = this.spesialis;
    return dt;
  }
}
