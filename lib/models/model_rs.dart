class RumahSakit {
  List<ModelRS> rs;

  RumahSakit({this.rs});

  RumahSakit.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      rs = new List<ModelRS>();
      json['data'].forEach((dt) {
        rs.add(new ModelRS.fromJson(dt));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dt = new Map<String, dynamic>();
    if (this.rs != null) {
      dt['data'] = this.rs.map((d) => d.toJson()).toList();
    }
    return dt;
  }
}

class ModelRS {
  String id;
  String namars;
  String fotors;
  String deskripsi;

  ModelRS({this.id, this.namars, this.fotors,this.deskripsi});

  ModelRS.fromJson(Map<String, dynamic> json) {
    this.id = json['id_rs'];
    this.namars = json['nama_rs'];
    this.fotors = json['foto_rs'];
    this.deskripsi = json['deskripsi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dt = new Map<String, dynamic>();
    dt['id_rs'] = this.id;
    dt['nama_rs'] = this.namars;
    dt['foto_rs'] = this.fotors;
    dt['deskripsi'] = this.deskripsi;
    return dt;
  }
}
