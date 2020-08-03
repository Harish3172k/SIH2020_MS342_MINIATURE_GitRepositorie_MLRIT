import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Sample extends StatefulWidget
{
  Map<String,String> obj;
  Sample(this.obj);
  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample>
{
  Offset lefteye,righteye,rightbrow,leftbrow,nose,mouth,face;
  Map<String,String> supObj;
  @override
  void initState()
  {
    super.initState();
    lefteye = Offset(130, 250);
    righteye = Offset(210, 250);
    leftbrow = Offset(130, 240);
    rightbrow = Offset(210, 240);
    nose = Offset(300, 170);
    mouth = Offset(350, 165);
    face = Offset(50, 150);
    supObj = widget.obj;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: Text('Do you wish to proceed',style: TextStyle(color: Colors.black),)),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.cloud_done,color: Colors.green,), onPressed: ()=>{}),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: face.dx,
            top: face.dy,
            child: Draggable(
              feedback: Container(
                height: 300,
                width: 300,
                child: PhotoView(imageProvider: AssetImage('assets/face.jpg'),backgroundDecoration: BoxDecoration(color: Colors.white),)),
              child: Container(
                height: 300,
                width: 300,
                child: PhotoView(imageProvider: AssetImage('assets/face.jpg'),backgroundDecoration: BoxDecoration(color: Colors.white),)),
              childWhenDragging: Container(color: Colors.white,),
              onDraggableCanceled: (velocity, offset) => {
                setState(()=>{
                  face = offset
                })
              },
            ) 
          ),
          Positioned(
            left: 130,
            top: 250,
            child: Container(
              height: 70,
              width: 70,
              child: PhotoView(imageProvider: AssetImage('assets/eye.jpg'),backgroundDecoration: BoxDecoration(color:Colors.white),),
            )
          ),
          Positioned(
            left: 210,
            top: 250,
            child: Container(
              height: 70,
              width: 70,
              child: PhotoView(imageProvider: AssetImage('assets/eye.jpg'),backgroundDecoration: BoxDecoration(color:Colors.white),),
            )
          ),
          Positioned(
            top: 300,
            left: 170,
            child: Container(
              height: 50,
              width: 70,
              child: PhotoView(imageProvider: AssetImage('assets/nose.jpg'),backgroundDecoration: BoxDecoration(color: Colors.white),))
          ),
          Positioned(
            top: 350,
            left: 165,
            child: Container(
              height: 50,
              width: 80,
              child: PhotoView(imageProvider: AssetImage('assets/lips.jpg'),backgroundDecoration: BoxDecoration(color: Colors.white),),
            )
          )
        ],
      )
    );
  }
}