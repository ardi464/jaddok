import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  List items = [
    "gbr1.jpg",
    "gbr2.jpg",
    "gbr3.png",
    "gbr4.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return _slider();
  }

  Widget _slider() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 35 / 100,
        width: MediaQuery.of(context).size.width,
        child: Carousel(
          images: [0, 1, 2, 3].map((i) {
            return Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      image: AssetImage(
                        "assets/img/${items[i]}",
                      ),
                      placeholder: AssetImage("assets/img/loading.gif"),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
          dotSize: 5.0,
          dotSpacing: 10.0,
          dotColor: Colors.black26,
          dotPosition: DotPosition.bottomCenter,
          indicatorBgPadding: 5.0,
          dotBgColor: Theme.of(context).primaryColor.withOpacity(0.3),
          moveIndicatorFromBottom: 180.0,
        ),
      ),
    );
  }
}
