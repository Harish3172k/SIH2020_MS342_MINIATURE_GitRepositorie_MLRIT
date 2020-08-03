import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Sample extends StatefulWidget
{
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height*0.8,
        width: MediaQuery.of(context).size.width*0.8,
        padding: EdgeInsets.only(left: 80,top: 100),
        child: PhotoView(imageProvider: AssetImage('assets/face.jpg'),filterQuality: FilterQuality.high,backgroundDecoration: BoxDecoration(color: Colors.white,)),
      ),
    );
  }
}