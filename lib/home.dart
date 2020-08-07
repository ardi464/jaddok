import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwaldokter/pages/s_dokter.dart';
import 'package:jadwaldokter/pages/s_rs.dart';
import 'package:jadwaldokter/widgets/teritori.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/img/icon.png",
                  width: 40,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text("Jadwal Dokter")
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                height: MediaQuery.of(context).size.height * 5 / 100,
              ),
              Container(
                padding: EdgeInsets.all(7),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    _search(context),
                    Teritori()
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _search(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 90 / 100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: InkWell(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                onTap: () {
                  Navigator.of(context).push(
                      CupertinoPageRoute(builder: (context) => SearchRS()));
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Rumah Sakit",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 35,
              color: Colors.grey,
            ),
            Flexible(
              flex: 2,
              child: InkWell(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15)),
                onTap: () {
                  Navigator.of(context).push(
                      CupertinoPageRoute(builder: (context) => SearchDokter()));
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Dokter",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
