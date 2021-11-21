import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talentio/LoginReg/newlogin.dart';
import 'package:talentio/Navigations/activity.dart';
import 'package:talentio/Navigations/newsearch.dart';
import 'package:talentio/homepage.dart';
import 'package:talentio/loginscreen.dart';
import 'package:talentio/newprofil.dart';
import 'package:talentio/profils.dart';
import 'searchscreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final monEmail= TextEditingController();
final monMotdePass = TextEditingController();

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
FirebaseApp defaultApp = await Firebase.initializeApp();
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: LoginRegister()
    );
  }
}

class Login extends StatelessWidget {
const Login({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  return Scaffold(
    body : Padding(
      padding: const EdgeInsets.all(30.0),

      child:
      Column( mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[Container(
          height: 300,

          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/logo.png',),
                  fit: BoxFit.fill
              )
          ),

        ),
          SizedBox( height: 10),
          TextField (
            controller: monEmail,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Enter Username',
              hintText: 'Enter Your Username',
              filled: true,
              prefixIcon: Icon(Icons.mail_outline),
              enabledBorder:  UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide : BorderSide.none,

              ),
              focusedBorder:  UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide : BorderSide(color: Colors.blue),
              ),
            ),
          ),
          SizedBox( height: 20),
          TextField (
            controller: monMotdePass,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Enter Password',
                hintText: 'Enter Your Password',
                filled: true,
                prefixIcon: Icon(Icons.lock_outline)
            ),

          ),
          SizedBox( height: 10),
          GestureDetector( child:
          Center(

            child: Container(
              height: 100,
              //margin: const EdgeInsets.only(top: 50.0),
              child: Align(
                alignment: Alignment.center, child: Text("Sign in", textAlign: TextAlign.center),

              ),

            ),
          ),
              onTap: () => connect(context, monEmail.text,monMotdePass.text)
          )

        ],


      ),

    ),

  );

}
}


class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Padding(
        padding: const EdgeInsets.all(30.0),

        child:
        Column( mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[Container(
            height: 300,

            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/logo.png',),
                    fit: BoxFit.fill
                )
            ),

          ),
            SizedBox( height: 10),
            TextField (
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Enter Username',
                hintText: 'Enter Your Username',
                filled: true,
                prefixIcon: Icon(Icons.mail_outline),
                enabledBorder:  UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide : BorderSide.none,

                ),
                focusedBorder:  UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide : BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox( height: 20),
            TextField (
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Enter Password',
                  hintText: 'Enter Your Password',
                  filled: true,
                  prefixIcon: Icon(Icons.lock_outline)
              ),

            ),
            SizedBox( height: 10),
            GestureDetector( child:
            Center(

              child: Container(
                height: 100,
                //margin: const EdgeInsets.only(top: 50.0),
                child: Align(
                  alignment: Alignment.center, child: Text("Sign up", textAlign: TextAlign.center),

                ),

              ),
            ),
                onTap: () => connect(context,monEmail.text,monMotdePass.text)
            )

          ],


        ),

      ),

    );

  }
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
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }




}



