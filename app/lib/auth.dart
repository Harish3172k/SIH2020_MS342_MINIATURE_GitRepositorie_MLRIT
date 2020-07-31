import 'dart:convert';

import 'package:e_spy/trace.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String email, password;
  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Text(
            "Hello,",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailRow() {
    const mainColor = Color(0xff2470c7);
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: mainColor,
          ),
          labelText: "Username",
        ),
      ),
    );
  }

  Widget _buildPasswordRow() {
    const mainColor = Color(0xff2470c7);
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: "Password",
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          onPressed:null,
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            "- Or -",
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  //Useful Widget
  //Suspended Due To Improper Alignment Error
/*
  Widget _buildSocialButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mainColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ]),
            child: Icon(
              FontAwesomeIcons.google,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
*/
  Widget _buildLoginButton() {
    const mainColor = Color(0xff2470c7);

    void authenticate(http.Response res){
        if(res.statusCode == 200) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>MyHomePage()));
        }
        else if(res.statusCode == 500){
          Flushbar(messageText: Text('Invalid credentials or account doesnt exist',style: TextStyle(color: Colors.white)),duration: Duration(seconds: 5),)..show(context);
        }
        else {
          Flushbar(messageText: Text('Internal server error',style: TextStyle(color: Colors.white)),duration: Duration(seconds: 5),)..show(context);
        }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 10.0,
            color: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () => {
                http.post('https://sih-api07.herokuapp.com/login',headers: {'Content-Type':'application/json'},body: json.encode({'username':email,'password':password}))
                .then((value) => authenticate(value))
                .catchError((err)=>{
                    Flushbar(messageText: Text('Unable to authenticate',style: TextStyle(color:Colors.white),),duration: Duration(seconds: 5),)..show(context)
                })
            },
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUp() {
    const mainColor = Color(0xff2470c7);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: FlatButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>_signup())),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: ('Dont have an account? '),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height / 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: ('Sign Up'),
                    style: TextStyle(
                      color: mainColor,
                      fontSize: MediaQuery.of(context).size.height / 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                _buildEmailRow(),
                _buildPasswordRow(),
                _buildForgotPassword(),
                _buildLoginButton(),
                _buildOrRow(),
                // _buildSocialButton(),---Suspended Widget
                _buildSignUp(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xff2470c7);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xfff2f3f7),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                    bottomRight: const Radius.circular(70),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                _buildContainer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _signup extends StatefulWidget{
  @override
  _signupstate createState() => _signupstate();
}

class _signupstate extends State<_signup>
{
  String email, password;
  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Text(
            "Hello,",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailRow() {
    const mainColor = Color(0xff2470c7);
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: mainColor,
          ),
          labelText: "Username",
        ),
      ),
    );
  }

  Widget _buildPasswordRow() {
    const mainColor = Color(0xff2470c7);
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: "Password",
        ),
      ),
    );
  }


  //Useful Widget
  //Suspended Due To Improper Alignment Error
/*
  Widget _buildSocialButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mainColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ]),
            child: Icon(
              FontAwesomeIcons.google,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
*/
  void authenticate(http.Response res) {
    if(res.statusCode == 200)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>MyHomePage()));
    }
    else if(res.statusCode == 500){
      Flushbar(messageText: Text('User already exists',style: TextStyle(color: Colors.white)),duration: Duration(seconds: 5),)..show(context);
      Future.delayed(Duration(seconds: 5),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>loginPage()));
      });
    }
    else {
        Flushbar(messageText: Text('Internal server error',style: TextStyle(color: Colors.white)),duration: Duration(seconds: 5),)..show(context);
      }
  }

  Widget _buildLoginButton() {
    const mainColor = Color(0xff2470c7);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20,top: 20),
          child: RaisedButton(
            elevation: 10.0,
            color: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () => {
              http.post('https://sih-api07.herokuapp.com/register',headers: {'Content-Type':'application/json'},body: json.encode({'username': email,'password': password}))
              .then((value) => authenticate(value))
              .catchError((err)=>{
                  Flushbar(messageText: Text('Sorry unable to authenticate'),duration: Duration(seconds: 5),)
              })
            },
            child: Text(
              'Signup',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        ),
      ],
    );
  }

 

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                _buildEmailRow(),
                _buildPasswordRow(),
                // _buildForgotPassword(),
                _buildLoginButton(),
                // _buildOrRow(),
                // _buildSocialButton(),---Suspended Widget
                // _buildSignUp(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
      const mainColor = Color(0xff2470c7);

    return SafeArea(
          child : Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Color(0xfff2f3f7),
          body: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(70),
                      bottomRight: const Radius.circular(70),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildLogo(),
                  _buildContainer(),
                ],
              ),
            ],
          ),
        ),
    );
  }
}