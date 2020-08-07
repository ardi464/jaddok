import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:expandable/expandable.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jadwaldokter/models/model_catatan.dart';
import 'package:jadwaldokter/services/api.dart';
import 'package:jadwaldokter/services/constant.dart';

class JadwalPage extends StatefulWidget {
  final String id;
  final String nama;
  final String foto;
  final String spesialis;

  JadwalPage({this.id, this.nama, this.foto, this.spesialis});

  @override
  _JadwalPageState createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  Api api = new Api();
  bool _isLoading = false;
  TextEditingController _noteController = TextEditingController();

  var url = imgUrl;

  addNote(id) {
    String _note = _noteController.text.toString();
    if (_note == "" || _note == null) {
      _snackbar(
        'Harap Lengkapi Kolom!',
        Colors.deepOrange,
        Icons.info,
      );
    } else {
      setState(() {
        _isLoading = true;
      });
      ModelCatatan note = ModelCatatan(idDokter: id, note: _note);
      api.addNote(note).then((success) {
        setState(() {
          _isLoading = false;
          _noteController.text = '';
        });
        if (success == 1) {
          _snackbar(
            'Berhasil Menambah Catatan',
            Colors.green,
            Icons.check,
          );
        } else {
          _snackbar(
            'Gagal Menambah Catatan!',
            Colors.deepOrange,
            Icons.info_outline,
          );
        }
      });
      Navigator.pop(context);
    }
  }

  delNote(id) {
    var ids = id.toString();
    api.delCatatan(ids).then((done) {
      if (done == 1) {
        _snackbar("Catatan Telah dihapus", Colors.green, Icons.check);
      } else {
        _snackbar("Catatan Gagal dihapus", Colors.red, Icons.close);
      }
    });
    Navigator.pop(context);
  }

  copy(text) {
    ClipboardManager.copyToClipBoard(text).then((result) {
      Fluttertoast.showToast(
          msg: "Copied to Clipboard",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          textColor: Colors.black,
          fontSize: 16.0);
    });
  }

  void _openNote(id, nama) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 90 / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "Tambah Catatan",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Nama Dokter : $nama",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  maxLines: 8,
                  controller: _noteController,
                  decoration: InputDecoration(
                      hintText: "Masukan Catatan",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RaisedButton(
                  elevation: 5,
                  onPressed: () {
                    addNote(id);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Theme.of(context).primaryColor,
                  child: _isLoading
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          ),
                        )
                      : Text(
                          "Simpan",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _viewNote(id, nama) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 90 / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "List Catatan",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Nama Dokter : $nama",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: FutureBuilder(
                      future: api.getCatatan(id),
                      builder: (context, snap) {
                        if (snap.hasError) {
                          print(snap.error);
                        }
                        if (snap.hasData) {
                          return ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                snap == null ? 0 : snap.data.catatan.length,
                            itemBuilder: (context, i) {
                              var ct = snap.data.catatan[i];
                              DateTime date = DateTime.parse(ct.tgl);
                              String tgl =
                                  DateFormat("dd/MM/yyyy").format(date);
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(ct.note),
                                    subtitle: Text(
                                      tgl,
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {
                                            copy(ct.note);
                                          },
                                          icon: Icon(Icons.content_copy),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            delNote(ct.id);
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.blue,
                                  )
                                ],
                              );
                            },
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    )),
              )
            ],
          ),
        );
      },
    );
  }

  void _showInfo() {
    AwesomeDialog(
      context: context,
      animType: AnimType.BOTTOMSLIDE,
      dialogType: DialogType.INFO,
      body: Container(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Keterangan Jadwal",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Divider(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Reguler",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  Text("Eksekutif",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                          fontWeight: FontWeight.bold)),
                  Text("Appointment",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
      tittle: 'This is Ignored',
      desc: 'This is also Ignored',
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height * 25 / 100;
    var url = imgUrl;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(tinggi),
        child: AppBar(
          flexibleSpace: ClipRRect(
            child: Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: widget.foto != ""
                          ? Image.network(
                              url + widget.foto,
                              width: 100,
                            )
                          : Image.asset(
                              "assets/img/doctor.png",
                              width: 100,
                            ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.nama,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.spesialis,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _openNote(widget.id, widget.nama);
              },
              icon: Icon(
                Icons.note_add,
                size: 25,
              ),
            ),
            IconButton(
              onPressed: () {
                _viewNote(widget.id, widget.nama);
              },
              icon: Icon(
                Icons.featured_play_list,
                size: 25,
              ),
            ),
            IconButton(
              onPressed: () {
                _showInfo();
              },
              icon: Icon(
                Icons.info,
                size: 25,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: FutureBuilder(
          future: api.getJadwal(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            if (snapshot.hasData) {
              return ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot == null ? 0 : snapshot.data.data.length,
                itemBuilder: (context, i) {
                  var dt = snapshot.data.data[i];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ExpandablePanel(
                      header: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 80,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: dt.fotoRs != "" || dt.fotoRs != null
                                    ? Image.network(
                                        url + dt.fotoRs,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset("assets/img/hospital.png"),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              dt.namaRs,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black54,
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
                                          padding: const EdgeInsets.all(8.0),
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
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  "${jm.jam}",
                                                  style: TextStyle(
                                                    color:
                                                        jm.status == 'Reguler'
                                                            ? Colors.black54
                                                            : jm.status ==
                                                                    'Eksekutif'
                                                                ? Colors.green
                                                                : Colors.red,
                                                  ),
                                                  textAlign: TextAlign.right,
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
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _snackbar(title, color, icon) {
    return Flushbar(
      padding: EdgeInsets.all(20),
      icon: Icon(
        icon,
        color: Colors.white,
        size: 35,
      ),
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 5),
      borderRadius: 15,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: color,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        'Swipe untuk menutup',
        style: TextStyle(color: Colors.white),
      ),
    )..show(context);
  }
}
