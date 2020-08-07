import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jadwaldokter/models/model_rs.dart';
import 'package:jadwaldokter/pages/dokter.dart';
import 'package:jadwaldokter/pages/photo_view.dart';
import 'package:jadwaldokter/services/api.dart';
import 'package:jadwaldokter/services/constant.dart';

class SearchRS extends StatefulWidget {
  @override
  _SearchRSState createState() => _SearchRSState();
}

class _SearchRSState extends State<SearchRS> {
  Api api = new Api();
  bool _isLoading = false;
  bool drink = false;
  int val;

  var url = imgUrl;
  final newData = new List<ModelRS>();
  TextEditingController _searchController = TextEditingController();

  search() {
    newData.clear();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    String _searchtext = _searchController.text.toString();
    setState(() {
      _isLoading = true;
    });
    if (_searchtext != '') {
      api.searchRs(_searchtext).then((res) {
        setState(() {
          _isLoading = false;
          drink = true;
        });
        if (res != null) {
          res.forEach((data) {
            final dt = new ModelRS(
              id: data['id_rs'],
              namars: data['nama_rs'],
              fotors: data['foto_rs'],
              deskripsi: data['deskripsi'],
            );
            newData.add(dt);
          });
          setState(() {
            val = 1;
          });
        } else {
          setState(() {
            val = 0;
          });
        }
      });
    } else {
      setState(() {
        val = 2;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Material(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: EdgeInsets.only(left: 20),
            child: Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent),
              child: TextField(
                autofocus: true,
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Cari Rumah Sakit",
                  hintStyle: TextStyle(
                    color: Colors.black45,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();
                    },
                    focusColor: Colors.grey,
                    icon: Icon(Icons.close),
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4.3, bottom: 4.3, right: 10),
            child: SizedBox(
              width: 50,
              child: IconButton(
                color: Colors.white,
                onPressed: () {
                  search();
                },
                icon: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: _isLoading == false
                      ? Icon(
                          Icons.search,
                          size: 25,
                          color: Colors.white,
                        )
                      : SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            backgroundColor: Colors.white,
                          ),
                        ),
                ),
                padding: EdgeInsets.only(right: 10),
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: _isLoading
            ? _isLoad(context)
            : val == 1
                ? _searchResult(context)
                : val == 0 ? _notFound(context) : _noSearch(context),
      ),
    );
  }

  Widget _isLoad(context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Loading Data',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _searchResult(context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: newData == null ? 0 : newData.length,
        itemBuilder: (context, i) {
          var dt = newData[i];
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
                          left: MediaQuery.of(context).size.width * 19 / 100,
                        ),
                        padding: EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.height * 20 / 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                        width: MediaQuery.of(context).size.width * 25 / 100,
                        height: MediaQuery.of(context).size.height * 20 / 100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _notFound(context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tidak Ditemukan',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
    );
  }

  Widget _noSearch(context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/img/rs.png',
              width: 350,
            ),
            Text(
              'Temukan disini',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
