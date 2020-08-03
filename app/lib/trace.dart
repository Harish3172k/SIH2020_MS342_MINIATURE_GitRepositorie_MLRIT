import 'dart:convert';
import 'package:e_spy/auth.dart';
import 'package:e_spy/modals/EvalModal.dart';
import 'package:e_spy/output.dart';
import 'package:e_spy/samp.dart';
import 'package:flushbar/flushbar.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './modals/customradio.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ModalRadio> righteye,
      lefteye,
      lefteyebrow,
      rightbrow,
      mouth,
      nose,
      face,
      outline;
  List<EvalModal> list = new List();
  Map object;
  Map<String, String> toSend = new Map();
  bool isLoading = true;
  bool isSwitch = false;
  List<ModalRadio> getModalList(List<dynamic> ref) {
    List<ModalRadio> lst = new List<ModalRadio>();
    ref.forEach((element) => {lst.add(new ModalRadio(false, element))});
    return lst;
  }

  void getData(http.Response res) {
    if (res.statusCode != 200) {
      Flushbar(
        messageText: Text(
          'Session expired',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 5),
      )..show(context);
      Future.delayed(Duration(seconds: 5), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => loginPage()));
      });
      return;
    }
    object = json.decode(res.body);
    print(object.keys);
    righteye = getModalList(object['righteye']);
    rightbrow = getModalList(object['righteyebrow']);
    lefteyebrow = getModalList(object['lefteyebrow']);
    mouth = getModalList(object['mouth']);
    lefteye = getModalList(object['lefteye']);
    nose = getModalList(object['nose']);
    outline = getModalList(object['outline']);
    list.add(new EvalModal('assets/One.jpeg', false));
    list.add(new EvalModal('assets/Two.jpeg', false));
    list.add(new EvalModal('assets/Three.jpeg', false));
    list.add(new EvalModal('assets/Four.jpeg', false));
    list.add(new EvalModal('assets/Five.jpeg', false));
    setState(() {
      isLoading = false;
    });
  }

  void addToMap(String val, String key) {
    toSend[key] = val;
    return;
  }

  @override
  void initState() {
    super.initState();
    print('Initalising');
    http
        .get('https://sih-api07.herokuapp.com/all')
        .then((val) => getData(val))
        .catchError((err) => print(err));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
                child: JumpingDotsProgressIndicator(
            fontSize: 30,
            numberOfDots: 3,
            dotSpacing: 4,
          )))
        :isSwitch?SwitchOn(): Scaffold(
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
                      Switch(
                          value: isSwitch,
                          onChanged: (val) => {
                                setState(() => {isSwitch = val})
                              }), //Face Shape
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
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          child: _buildListItem(nose[i]),
                          onTapDown: (_) => {
                            setState(() => {
                                  addToMap(nose[i].img, 'nose'),
                                  nose.forEach((element) {
                                    element.isSelected = false;
                                  }),
                                  nose[i].isSelected = true
                                })
                          },
                        );
                      },
                    )),
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
                      itemBuilder: (context, i) {
                        return GestureDetector(
                            onTapDown: (_) => {
                                  (lefteyebrow[i].isSelected)
                                      ? setState(() => {
                                            lefteyebrow[i].isSelected = false,
                                            toSend.remove('lefteyebrow')
                                          })
                                      : setState(() => {
                                            addToMap(lefteyebrow[i].img,
                                                'lefteyebrow'),
                                            lefteyebrow.forEach((element) {
                                              element.isSelected = false;
                                            }),
                                            lefteyebrow[i].isSelected = true
                                          })
                                },
                            child: _buildListItem(lefteyebrow[i]));
                      }),
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
                      itemBuilder: (context, i) {
                        return GestureDetector(
                            onTapDown: (_) => {
                                  setState(() => {
                                        addToMap(lefteye[i].img, 'lefteye'),
                                        lefteye.forEach((element) {
                                          element.isSelected = false;
                                        }),
                                        lefteye[i].isSelected = true
                                      })
                                },
                            child: _buildListItem(lefteye[i]));
                      }),
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
                      itemBuilder: (context, i) {
                        return GestureDetector(
                            onTapDown: (_) => {
                                  setState(() => {
                                        addToMap(
                                            rightbrow[i].img, 'righteyebrow'),
                                        rightbrow.forEach((element) {
                                          element.isSelected = false;
                                        }),
                                        rightbrow[i].isSelected = true
                                      })
                                },
                            child: _buildListItem(rightbrow[i]));
                      }),
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
                      itemBuilder: (context, i) {
                        return GestureDetector(
                            onTapDown: (_) => {
                                  setState(() => {
                                        addToMap(righteye[i].img, 'righteye'),
                                        righteye.forEach((element) {
                                          element.isSelected = false;
                                        }),
                                        righteye[i].isSelected = true,
                                      })
                                },
                            child: _buildListItem(righteye[i]));
                      }),
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
                      itemBuilder: (context, i) {
                        return GestureDetector(
                            onTapDown: (_) => {
                                  setState(() => {
                                        addToMap(mouth[i].img, 'mouth'),
                                        mouth.forEach((element) {
                                          element.isSelected = false;
                                        }),
                                        mouth[i].isSelected = true,
                                      })
                                },
                            child: _buildListItem(mouth[i]));
                      }),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Text('Face outline',
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
                      itemCount: outline.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                            onTapDown: (_) => {
                                  setState(() => {
                                        addToMap(outline[i].img, 'outline'),
                                        outline.forEach((element) {
                                          element.isSelected = false;
                                        }),
                                        outline[i].isSelected = true,
                                      })
                                },
                            child: _buildListItem(outline[i]));
                      }),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green[400],
              onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Sample(toSend)))
              },
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
  }

  Widget _buildListItem(ModalRadio imgPath) {
    return InkWell(
        onTap: () {},
        child: Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.10,
                width: 150.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: imgPath.isSelected ? Colors.blue : Colors.white,
                        width: 2),
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
                                  image: MemoryImage(base64Decode(imgPath.img)),
                                  fit: BoxFit.contain),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0))),
                        )),
                  ],
                ))));
  }

  Widget SwitchOn()
  {
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
                      Switch(
                          value: isSwitch,
                          onChanged: (val) => {
                                setState(() => {isSwitch = val})
                              }), //Face Shape
                      Text('Nose Shape',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 17.0))
                    ],
                  ),
                ),
                SizedBox(height: 7,),
                Container(
                  height: 250,
                  child: GestureDetector(
                    onTapDown: (_)=>{
                      setState(()=>{
                        list.forEach((element) {element.isSelected = false; }),
                        list[0].isSelected = true
                      })
                    },
                    child: _buildListItemEval(list[0])),
                ),
                SizedBox(height: 7,),
                Container(
                  height: 250,
                  child: GestureDetector(
                    onTapDown: (_)=>{
                      setState(()=>{
                        list.forEach((element) {element.isSelected = false; }),
                        list[1].isSelected = true
                      })
                    },
                    child: _buildListItemEval(list[1])),
                ),
                SizedBox(height: 7,),
                Container(
                  height: 250,
                  child: GestureDetector(
                    onTapDown: (_)=>{
                      setState(()=>{
                        list.forEach((element) {element.isSelected = false; }),
                        list[2].isSelected = true
                      })
                    },
                    child: _buildListItemEval(list[2])),
                ),
                SizedBox(height: 7,),
                Container(
                  height: 250,
                  child: GestureDetector(
                    onTapDown: (_)=>{
                      setState(()=>{
                        list.forEach((element) {element.isSelected = false; }),
                        list[3].isSelected = true
                      })
                    },
                    child: _buildListItemEval(list[3])),
                ),
                SizedBox(height: 7,),
                Container(
                  height: 250,
                  child: GestureDetector(
                    onTapDown: (_)=>{
                      setState(()=>{
                        list.forEach((element) {element.isSelected = false; }),
                        list[4].isSelected = true
                      })
                    },
                    child: _buildListItemEval(list[4])),
                ),
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: ()=>{},child: Icon(Icons.check),backgroundColor: Colors.blue,),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
  Widget _buildListItemEval(EvalModal ref) {
    return InkWell(
        onTap: () {},
        child: Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.10,
                width: 150.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: ref.isSelected ? Colors.blue : Colors.white,
                        width: 2),
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
                        tag: ref.path,
                        child: Container(
                          height: 200.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ref.path),
                                  fit: BoxFit.contain),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0))),
                        )),
                  ],
                ))));
  }

}
