import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:jadwaldokter/models/model_catatan.dart';
import 'package:jadwaldokter/models/model_dokter.dart';
import 'package:jadwaldokter/models/model_jadwal.dart';
import 'package:jadwaldokter/models/model_rs.dart';
import 'package:jadwaldokter/models/model_teritori.dart';

class Api {
  Client http = Client();
  static final String url = "https://jadwaldokter.sultancoding.com/api/";
  // static final String url = "http://10.0.2.2/jadwaldokter/api/";

  Future<ModelTeritori> getTeritori() async {
    final res = await http.get(url + "getTeritori.php");
    if (res.statusCode == 200) {
      final dt = json.decode(res.body);
      return ModelTeritori.fromJson(dt);
    } else {
      throw Exception("Failed to Load");
    }
  }

  Future<RumahSakit> getRs(String id) async {
    final res = await http.get(url + "getRs.php?id=$id");
    if (res.statusCode == 200) {
      final dt = json.decode(res.body);
      return RumahSakit.fromJson(dt);
    } else {
      throw Exception("Failed to Load");
    }
  }

  Future<ModelDokter> getDokter(String id) async {
    final res = await http.get(url + "getDokter.php?id=$id");
    if (res.statusCode == 200) {
      final dt = json.decode(res.body);
      return ModelDokter.fromJson(dt);
    } else {
      throw Exception("Failed to Load");
    }
  }

  Future<ModelJadwal> getJadwal(String id) async {
    final res = await http.get(url + "getJadwal.php?id=$id");
    if (res.statusCode == 200) {
      final dt = json.decode(res.body);
      return ModelJadwal.fromJson(dt);
    } else {
      throw Exception("Failed to Load");
    }
  }

  Future<int> addNote(ModelCatatan data) async {
    final res = await http.post(
      url + "addNote.php",
      body: {"id_dokter": data.idDokter, "catatan": data.note},
    );
    if (res.statusCode == 200) {
      final dt = json.decode(res.body);
      int val = dt['val'];
      return val;
    } else {
      return 0;
    }
  }

  Future<Catatan> getCatatan(String iddokter) async {
    final res = await http.get(url + "getCatatan.php?id_dokter=$iddokter");
    if (res.statusCode == 200) {
      final dt = json.decode(res.body);
      return Catatan.fromJson(dt);
    } else {
      throw Exception("Failed to Load");
    }
  }

  delCatatan(String id) async {
    final res = await http.get(url + "delNote.php?id=$id");
    if (res.statusCode == 200) {
      final dt = json.decode(res.body);
      int val = dt['val'];
      return val;
    } else {
      return 0;
    }
  }

  Future<dynamic> searchRs(String nama) async {
    final res = await http.get(url + "searchRs.php?s=$nama");
    if (res.statusCode == 200) {
      final dt = json.decode(res.body);
      var rs = dt['data'];
      return rs;
    } else {
      throw Exception("Failed to Load");
    }
  }

  Future<dynamic> searchDokter(String nama) async {
    final res = await http.get(url + "searchDokter.php?s=$nama");
    if (res.statusCode == 200) {
      final dt = json.decode(res.body);
      var rs = dt['data'];
      return rs;
    } else {
      throw Exception("Failed to Load");
    }
  }
}
