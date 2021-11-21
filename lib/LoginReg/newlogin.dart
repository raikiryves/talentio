import 'package:flutter/material.dart';
import 'package:talentio/LoginReg/Login.dart';
import 'package:talentio/homepage.dart';

import '../main.dart';
import 'Register.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({Key? key}) : super(key: key);

  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red,
      child: Stack(
        children: <Widget>[

          Container(
            height: MediaQuery.of(context).size.width * 1.1,
            decoration: BoxDecoration(
              image: DecorationImage(
              image : AssetImage('assets/log.jpg'),
                fit: BoxFit.cover,
              )
            ),
          ),




          Align(
            alignment: Alignment.bottomCenter,
            child:
              Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(60)
                            )
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 30,),

                            Text("Bienvenue!", style: TextStyle(fontSize: 30),),

                            Padding(
                              padding: const EdgeInsets.all(33.0),
                              child: GestureDetector(
                                child: Container(
                                    padding: EdgeInsets.only( left: 18, right:18,top: 18,bottom: 18 ),

                                    //Button Follow
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            end:   Alignment.bottomLeft,
                                            colors: [Color(0xFFFC77FB),
                                              Color(0xFFEE9944),]), borderRadius: BorderRadius.circular(30.0)),
                                    child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [Text('Connexion', style : TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white,decoration: TextDecoration.none) , )],)),
                                  onTap: () => Navigator.push( context,
                                    MaterialPageRoute(builder: (context) => LoginScreen() ),
                                  )
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: GestureDetector(
                                child: Container(
                                    padding: EdgeInsets.only( left: 18, right:18,top: 18,bottom: 18 ),

                                    //Button Follow
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            end:   Alignment.bottomLeft,
                                            colors: [Color(0xFFFC77FB),
                                              Color(0xFFEE9944),]), borderRadius: BorderRadius.circular(30.0)),
                                    child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [Text('Inscription', style : TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white,decoration: TextDecoration.none) , )],)),
                                  onTap: () => Navigator.push( context,
                                    MaterialPageRoute(builder: (context) => RegisterScreen() ),
                                  )
                              ),

                            ),

                            SizedBox(height: 30,),
                            GestureDetector(
                              child: Container(
                              child:
                              Text('Vous n etes qu un visiteur? Clicker ici', style : TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.blueGrey,decoration: TextDecoration.none))
                              ),
                                onTap: () => Navigator.push( context,
                                  MaterialPageRoute(builder: (context) => HomePage() ),
                                )
                            )


                          ],
                        ),
                      ),









                      //Text("hello", style: TextStyle(color: Colors.black),)


                    ],

                  ),
                ],
              )
          )

        ],




      ),
    );
  }
}
