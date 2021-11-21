import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'main.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LoginReg extends StatelessWidget {
  const LoginReg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( child: SafeArea(child: Padding( padding: EdgeInsets.symmetric(horizontal: 23.0, vertical: 70.0),
        child : Column(
          
          
            
            children: <Widget>[ Image.asset('assets/logo.png',height: 150,),
          
          Row( mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tal', style: TextStyle( fontSize: 80, color: Color.fromRGBO(245, 48, 111, 1.0) , decoration: TextDecoration.none) ),
            Text('ent', style: TextStyle( fontSize: 80,color: Colors.white,decoration: TextDecoration.none)) ],
        ) ,Text('Discover Talented Artists', style: TextStyle(fontSize: 20 ,decoration: TextDecoration.none),),
          SizedBox(height: 70,),
          GestureDetector( child:
          Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),

              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
              child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [Text('Login', style : TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue) , )],)),
            onTap: () => Navigator.push( context,
              MaterialPageRoute(builder: (context) => Login() ),
          )
          ),
          SizedBox(height: 40,),

          Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),

              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
              child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [Text('Register', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue) )],)),
          SizedBox(height: 40,),
          Container( child : Text("i'm a visitor", style: TextStyle(fontSize: 10, color: Colors.white) ,) )

        ]))),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end:   Alignment.bottomCenter,
          colors: [ Color(0xFF73AEF5),
            Color(0xFF61A4F1),
            Color(0xFF398AE5) ],
        ),
      ),
    );
  }
}

