import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';

class Dash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashState();
  }
}

class DashState extends State<Dash> {
  String text;
  List<String> response;

   void post() async {
     var obj = {"text": text};
     print(text);
     http.Response res = await http.post('http://19e8da072c96.ngrok.io/add',headers: {"Content-Type":"application/json"},body: json.encode(obj));
     print(res.body);
   } 

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 100),
        height: MediaQuery.of(context).size.height*0.7,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 50),
            height: MediaQuery.of(context).size.height*0.6,
            width : MediaQuery.of(context).size.width*0.8,
            child: TextFormField(
              maxLines: 30,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Enter the description',
                labelStyle: TextStyle(
                  fontSize: 24
                ),
                helperText: 'Note :  Enter the description vaguely or eloborately describing the facial features of the criminal(eyes,nose,mouth,jaw,face shape)',
                helperStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
                helperMaxLines: 5,
              ),
              onChanged: (val)=>{
                text = val
              },
            ),
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(text == null || text.length == 0 || text == "") {
            Flushbar(
              messageText: RichText(text: 
              TextSpan(
                text: 'Enter Something !!!',
                style: TextStyle(fontStyle: FontStyle.normal,color: Colors.black,fontSize: 18)
              )
              ),
              backgroundColor: Colors.yellow[200],
              icon: Icon(Icons.info_outline),
              shouldIconPulse: true,
              duration: Duration(seconds: 3),
            )..show(context);
          }
          else {
            post();
          }
        },
        child: Icon(Icons.done),
        tooltip: 'Submit to progress',
        splashColor: Colors.green,
        elevation: 10,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}