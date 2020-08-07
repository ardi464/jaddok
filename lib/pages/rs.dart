import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwaldokter/pages/dokter.dart';
import 'package:jadwaldokter/pages/photo_view.dart';
import 'package:jadwaldokter/services/api.dart';
import 'package:jadwaldokter/services/constant.dart';

class RS extends StatefulWidget {
  final String id;
  final String teritori;

  RS({this.id, this.teritori});

  @override
  _RSState createState() => _RSState();
}

class _RSState extends State<RS> {
  Api api = new Api();

  var url = imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:Text(widget.teritori)
      ),
      body: FutureBuilder(
        future: api.getRs(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot == null ? 0 : snapshot.data.rs.length,
              itemBuilder: (context, i) {
                var dt = snapshot.data.rs[i];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              Navigator.of(context).push(
                                new CupertinoPageRoute(
                                  builder: (context) => DokterPage(
                                    id: dt.id,
                                    namars: dt.namars,
                                    fotoRs: dt.fotors,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width *
                                    19 /
                                    100,
                              ),
                              padding: EdgeInsets.all(20),
                              height:
                                  MediaQuery.of(context).size.height * 15 / 100,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          dt.namars,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.black,
                                          height: 20,
                                        ),
                                        Text(
                                          dt.deskripsi != ""
                                              ? dt.deskripsi
                                              : "Belum ada Deskripsi",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: GestureDetector(
                          onTap: () {
                            var poto = "";
                            if (dt.fotors == null || dt.fotors == "") {
                              poto = "";
                            } else {
                              poto = url + dt.fotors;
                            }
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ImgView(poto),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                              image: dt.fotors == null || dt.fotors == ""
                                  ? AssetImage("assets/img/hospital.png")
                                  : NetworkImage(url + dt.fotors),
                              placeholder: AssetImage('assets/img/loading.gif'),
                              fit: BoxFit.cover,
                              width:
                                  MediaQuery.of(context).size.width * 20 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 15 / 100,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
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
