import 'package:flutter/material.dart';
import 'package:jadwaldokter/home.dart';

void main()=>runApp(JadwalApp());

class JadwalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jadwal Dokter",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.orange
      ),
      home: HomePage(),
    );
  }
}