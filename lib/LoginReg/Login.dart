import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:talentio/LoginReg/Register.dart';

import '../homepage.dart';

final monEmail= TextEditingController();
final monMotdePass = TextEditingController();


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,

          children: <Widget>[



            Text('Connexion', style : TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.black,decoration: TextDecoration.none) , ),



            Container(
              height: 300,
              width: 300,

              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/connect.jpg',),
                      fit: BoxFit.fill
                  )
              ),

            ),


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 28),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(205, 203, 220,1),
                    borderRadius: BorderRadius.circular(29.5)
                ),
                child: TextField(
                  controller: monEmail,
                  decoration: InputDecoration(
                      icon: Icon(Icons.mail_outline),
                      border: InputBorder.none,

                      hintText: "Email"
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 28),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(205, 203, 220,1),
                    borderRadius: BorderRadius.circular(29.5)
                ),
                child: TextField(
                  controller: monMotdePass,
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock_outline),
                      border: InputBorder.none,
                      hintText: "Mot de passe",

                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 28),
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
                  onTap: () => connect(context, monEmail.text,monMotdePass.text)
              ),
            ),
            SizedBox(height: 70,),

            Align(
              alignment: Alignment.bottomCenter,
              child:Column(
                children: <Widget>[ Container(
                    height: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(205, 203, 220,1),
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(60)
                        )

                    ),
                  child: GestureDetector(
                    child: Center(child:
                      Container(
                        child: Text("Vous n'avez pas de compte?", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),

                      ),


                    ),
                      onTap: () =>  Navigator.push( context,
                          MaterialPageRoute(builder: (context) => RegisterScreen() )
                  )

                )
                )


                ],

              ) ,
            )





          ],



        ),


      ),
    );
  }

  Future connect(BuildContext context,String e,String mdp) async
  {

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: e,
          password: mdp
      );
      Navigator.push( context,
        MaterialPageRoute(builder: (context) => HomePage() ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _onAlertButtonPressed(context);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        _onAlertButtonPressed(context);
      }
    }
  }

}

_onAlertButtonPressed(context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "Erreur",
    desc: "Mot de Pass ou Nom Utilisateur incorrect",
    buttons: [
      DialogButton(
        child: Text(
          "Réésayer!",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}
