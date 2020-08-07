class Catatan {
  List<ModelCatatan> catatan;

  Catatan({this.catatan});

  Catatan.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      catatan = new List<ModelCatatan>();
      json['data'].forEach((dt) {
        catatan.add(new ModelCatatan.fromJson(dt));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dt = new Map<String, dynamic>();
    if (this.catatan != null) {
      dt['data'] = this.catatan.map((d) => d.toJson()).toList();
    }
    return dt;
  }
}

class ModelCatatan {
  int id;
  String idDokter;
  String idRs;
  String note;
  String tgl;

  ModelCatatan(
      {this.id = 0, this.idDokter, this.idRs, this.note, this.tgl = ''});

  ModelCatatan.fromJson(Map<String, dynamic> json) {
    this.id = int.parse(json['id_catatan']);
    this.idDokter = json['id_dokter'];
    this.idRs = json['id_rs'];
    this.note = json['catatan'];
    this.tgl = json['tgl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dt = new Map<String, dynamic>();
    dt['id_catatan'] = this.id;
    dt['id_dokter'] = this.idDokter;
    dt['id_rs'] = this.idRs;
    dt['catatan'] = this.note;
    dt['tgl'] = this.tgl;

    return dt;
  }
}
