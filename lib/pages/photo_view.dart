import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImgView extends StatelessWidget {
  final String photo;

  ImgView(this.photo);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider: photo == "" || photo == null
            ? AssetImage("assets/img/hospital.png")
            : NetworkImage(photo),
      ),
    );
  }
}
