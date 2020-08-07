import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jadwaldokter/models/model_dok.dart';
import 'package:jadwaldokter/pages/jadwal.dart';
import 'package:jadwaldokter/services/api.dart';
import 'package:jadwaldokter/services/constant.dart';

class SearchDokter extends StatefulWidget {
  @override
  _SearchDokterState createState() => _SearchDokterState();
}

class _SearchDokterState extends State<SearchDokter> {
  Api api = new Api();
  bool _isLoading = false;
  bool drink = false;
  int val;

  var url = imgUrl;
  final newData = new List<ModelDok>();
  TextEditingController _searchController = TextEditingController();

  search() {
    newData.clear();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    String _searchtext = _searchController.text.toString();
    setState(() {
      _isLoading = true;
    });
    if (_searchtext != '') {
      api.searchDokter(_searchtext).then((res) {
        setState(() {
          _isLoading = false;
          drink = true;
        });
        if (res != null) {
          res.forEach((data) {
            final dt = new ModelDok(
              id: data['id_dokter'],
              nama: data['nama'],
              fotoDok: data['foto_dokter'],
              spesialis: data['spesialis'],
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
                  hintText: "Cari Dokter",
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
      child: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: newData == null ? 0 : newData.length,
          itemBuilder: (context, i) {
            var dt = newData[i];
            return Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => JadwalPage(
                        id: dt.id,
                        nama: dt.nama,
                        foto: dt.fotoDok,
                        spesialis: dt.spesialis,
                      ),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        color: dt.spesialis == "Orthopedic"
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
                    ),
                  ),
                ),
                Container(
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
                        child: dt.fotoDok == "" || dt.fotoDok == null
                            ? Image.asset("assets/img/doctor.png")
                            : Image.network(
                                url + dt.fotoDok,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
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
              'assets/img/search.png',
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
