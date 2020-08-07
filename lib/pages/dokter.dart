import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwaldokter/pages/jadwal.dart';
import 'package:jadwaldokter/services/api.dart';
import 'package:jadwaldokter/services/constant.dart';

class DokterPage extends StatefulWidget {
  final String id;
  final String namars;
  final String fotoRs;

  DokterPage({this.id, this.namars, this.fotoRs});

  @override
  _DokterPageState createState() => _DokterPageState();
}

class _DokterPageState extends State<DokterPage> {
  Api api = new Api();

  var url = imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 2),
              margin: EdgeInsets.only(right: 5, top: 0),
              width: 60,
              height: 70,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image(
                    image: widget.fotoRs == null || widget.fotoRs == ""
                        ? AssetImage("assets/img/hospital.png")
                        : NetworkImage(url + widget.fotoRs),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              "${widget.namars}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: api.getDokter(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.data.length,
                itemBuilder: (context, i) {
                  var dt = snapshot.data.data[i];
                  return Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: ExpandablePanel(
                            header: Padding(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 60),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            dt.nama,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Divider(),
                                          Text(
                                            dt.spesialis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: dt.spesialis ==
                                                      "Orthopedic"
                                                  ? Colors.blue
                                                  : dt.spesialis == "Rehabmedic"
                                                      ? Colors.red
                                                      : dt.spesialis == "Saraf"
                                                          ? Colors.green
                                                          : Colors.purple,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            expanded: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: dt.datahari.length,
                                    itemBuilder: (context, x) {
                                      var hr = dt.datahari[x];
                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  hr.hari,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: hr.waktu.length,
                                                  itemBuilder: (context, y) {
                                                    var jm = hr.waktu[y];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Text(
                                                        "${jm.jam}",
                                                        style: TextStyle(
                                                          color: jm.status ==
                                                                  'Reguler'
                                                              ? Colors.black54
                                                              : jm.status ==
                                                                      'Eksekutif'
                                                                  ? Colors.green
                                                                  : Colors.red,
                                                        ),
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black87,
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => JadwalPage(
                              id: dt.idDokter,
                              nama: dt.nama,
                              foto: dt.fotoDokter,
                              spesialis: dt.spesialis,
                            ),
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 15, bottom: 15),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Container(
                              width: 70,
                              height: 70,
                              padding: EdgeInsets.all(3),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child:
                                    dt.fotoDokter == "" || dt.fotoDokter == null
                                        ? Image.asset("assets/img/doctor.png")
                                        : Image.network(
                                            url + dt.fotoDokter,
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
