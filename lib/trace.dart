import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text('Face Shape',
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                //this is where list items has to be added
                _buildListItem(
                  'assets/face.jpg',
                ),
                _buildListItem(
                  'assets/face.jpg',
                ),
                _buildListItem(
                  'assets/face.jpg',
                ),
              ],
            ),
          ),
          //Eyebrows
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text('EyeBrows',
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                //this is where list items has to be added
                _buildListItem(
                  'assets/eyebrows.jpg',
                ),
                _buildListItem(
                  'assets/eyebrows.jpg',
                ),
                _buildListItem(
                  'assets/eyebrows.jpg',
                ),
              ],
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
                Text('Eyes',
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                //this is where list items has to be added
                _buildListItem(
                  'assets/eye.jpg',
                ),
                _buildListItem(
                  'assets/eye.jpg',
                ),
                _buildListItem(
                  'assets/eye.jpg',
                ),
              ],
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
                Text('Nose',
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                //this is where list items has to be added
                //Image Path Inside ''
                _buildListItem(
                  'assets/nose.jpg',
                ),
                _buildListItem(
                  'assets/nose.jpg',
                ),
                _buildListItem(
                  'assets/nose.jpg',
                )
              ],
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
                Text('Lips',
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                //this is where list items has to be added
                _buildListItem(
                  'assets/lips.jpg',
                ),
                _buildListItem(
                  'assets/lips.jpg',
                ),
                _buildListItem(
                  'assets/lips.jpg',
                ),
              ],
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
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.contain),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0))),
                        )),
                  ],
                ))));
  }
}