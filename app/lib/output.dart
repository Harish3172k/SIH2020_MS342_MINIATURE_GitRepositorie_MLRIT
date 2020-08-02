import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Output extends StatelessWidget {
  Map img;
  Output({Key key, @required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Do you wish to proceed?',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cloud_done),
            color: Colors.green,
            onPressed: null,
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.only(left: 70, top: 70),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
              widthFactor: 20,
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: MemoryImage(base64Decode(img['result'])),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0))),
                  ))),
        ),
      ),
    );
  }
}
