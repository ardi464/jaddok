import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwaldokter/pages/rs.dart';
import 'package:jadwaldokter/services/api.dart';
import 'package:jadwaldokter/services/constant.dart';

class Teritori extends StatefulWidget {
  @override
  _TeritoriState createState() => _TeritoriState();
}

class _TeritoriState extends State<Teritori> {
  Api api = new Api();

  var url = imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10),
      child: FutureBuilder(
        future: api.getTeritori(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              shrinkWrap: true,
              itemCount: snapshot == null ? 0 : snapshot.data.data.length,
              itemBuilder: (context, int i) {
                var dt = snapshot.data.data[i];
                List gbr = dt.gambar;
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.of(context).push(
                          new CupertinoPageRoute(
                            builder: (context) => RS(
                              id: dt.idTeritori,
                              teritori: dt.teritori,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: <Widget>[
                          Carousel(
                            images: [0, 1, 2].map((index) {
                              return Builder(
                                builder: (context) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage(
                                      image: NetworkImage(
                                        url + gbr[index],
                                      ),
                                      placeholder:
                                          AssetImage("assets/img/loading.gif"),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                            borderRadius: true,
                            dotSize: 5.0,
                            autoplayDuration: Duration(seconds:3),
                            dotSpacing: 10.0,
                            dotColor: Colors.black26,
                            dotPosition: DotPosition.bottomCenter,
                            indicatorBgPadding: 5.0,
                            moveIndicatorFromBottom: 180.0,
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                                color: Colors.black.withOpacity(0.7),
                              ),
                              width: MediaQuery.of(context).size.width / 2.5,
                              padding: EdgeInsets.all(5),
                              child: Text(
                                dt.teritori,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
