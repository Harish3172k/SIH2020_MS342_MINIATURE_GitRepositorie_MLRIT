import 'dart:convert';
import 'package:e_spy/auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> righteye,lefteye,lefteyebrow,rightbrow,mouth,nose,face;
  Map object;
  Map<String,String> to_send;
  bool isLoading = true;
  void getData(http.Response res) {
    if(res.statusCode != 200){
        Flushbar(messageText: Text('Session expired',style: TextStyle(color:Colors.white),),duration: Duration(seconds:5),)..show(context);
        Future.delayed(Duration(seconds: 5),(){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>loginPage()));
        });
        return;
    }
      object = json.decode(res.body);
      print(object.keys);
      righteye = object['righteye'];
      rightbrow = object['righteyebrow'];
      lefteyebrow = object['lefteyebrow'];
      mouth = object['mouth'];
      lefteye = object['lefteye'];
      nose = object['nose'];
      setState(() {
        isLoading = false;
      });
  }

  @override
  void initState() {
    super.initState();
    print('Initalising');
    http.get('https://sih-api07.herokuapp.com/all')
    .then((val)=>getData(val))
    .catchError((err)=>print(err));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading?Scaffold(body:Center(child: JumpingDotsProgressIndicator(fontSize: 30,numberOfDots: 3,dotSpacing: 4,))):Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[],
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Start Tracing',
                    style: TextStyle(
                        fontFamily: 'Futur',
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2470c7),
                        fontSize: 30.0)),
                SizedBox(height: 20.0),
                //Face Shape
                Text('Nose Shape',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0))
              ],
            ),
          ),
          //Face Shape
          SizedBox(height: 7.0),
          Container(
            height: 250.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: nose.length,
              itemBuilder: (context,i){
                return GestureDetector(
                  child: Focus(
                    autofocus: true,
                    child:_buildListItem(nose[i])),
                  onTap: () => {
                    to_send['nose'] = nose[i]
                  },
                );
              },
            )
          ),
          //Eyebrows
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text('Left EyeBrows',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0))
              ],
            ),
          ),
          //Eyebrows
          SizedBox(height: 7.0),
          Container(
            height: 250.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: lefteyebrow.length,
              itemBuilder: (context,i){
                return _buildListItem(lefteyebrow[i]);
              }
            
            ),
          ),
          //Eyes
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text('Left Eyes',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0))
              ],
            ),
          ),
          //Eyes
          SizedBox(height: 7.0),
          Container(
            height: 250.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: lefteye.length,
              itemBuilder: (context,i){
                return _buildListItem(lefteye[i]);
              }
            
            ),
          ),
          //Nose
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text('Right Eyebrow',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0))
              ],
            ),
          ),
          //Nose
          SizedBox(height: 7.0),
          Container(
            height: 250.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: rightbrow.length,
              itemBuilder: (context,i){
                return _buildListItem(rightbrow[i]);
              }
            
            ),
          ),
          //Lips
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text('Right eye',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0))
              ],
            ),
          ),
          //Lips
          SizedBox(height: 7.0),
          Container(
            height: 250.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: righteye.length,
              itemBuilder: (context,i){
                return _buildListItem(righteye[i]);
              }
            
            ),
          ),
          //Lips
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text('Mouth',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0))
              ],
            ),
          ),
          //Lips
          SizedBox(height: 7.0),
          Container(
            height: 250.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mouth.length,
              itemBuilder: (context,i){
                return _buildListItem(mouth[i]);
              }
            
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String imgPath) {
    return InkWell(
        onTap: () {},
        child: Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
            child: Container(
                height: MediaQuery.of(context).size.height*0.10,
                width: 150.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 6.0,
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5.0)
                    ]),
                child: Stack(
                  children: <Widget>[
                    Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.white, Color(0xFFACBEA3)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)))),
                    Hero(
                        tag: imgPath,
                        child: Container(
                          height: 200.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: MemoryImage(base64Decode(imgPath)),
                                  fit: BoxFit.contain),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0))),
                        )),
                  ],
                ))));
  }
}