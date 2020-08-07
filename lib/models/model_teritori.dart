
import 'dart:convert';

ModelTeritori teritoriFromJson(String str) => ModelTeritori.fromJson(json.decode(str));

String teritoriToJson(ModelTeritori data) => json.encode(data.toJson());

class ModelTeritori {
    List<Datum> data;

    ModelTeritori({
        this.data,
    });

    factory ModelTeritori.fromJson(Map<String, dynamic> json) => ModelTeritori(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String idTeritori;
    String teritori;
    List<String> gambar;

    Datum({
        this.idTeritori,
        this.teritori,
        this.gambar,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idTeritori: json["id_teritori"],
        teritori: json["teritori"],
        gambar: List<String>.from(json["gambar"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id_teritori": idTeritori,
        "teritori": teritori,
        "gambar": List<dynamic>.from(gambar.map((x) => x)),
    };
}
