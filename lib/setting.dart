import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talentio/loginscreen.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: <Widget>[


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: <Widget>[
                      Container(


                          child: CircleAvatar(
                            radius: 30.0,
                            child:Icon(
                                Icons.perm_identity_outlined

                            ),

                          )
                      ),

                    ],

                  ),
                  SizedBox(height: 30,),





                  Row(
                    mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Container(

                        width: 300,
                        height: 50,

                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(30.0), border: Border.all(color: Colors.blueAccent)),
                      child:
GestureDetector( child:
                       Center(child: Text('Log out', style : TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue),)),
    onTap: () => SignOut(this.context) ),

                      )
                    ],

                  ),





                ],
              )
          )


    );
  }
}

Future SignOut(BuildContext context) async{
  await FirebaseAuth.instance.signOut();
  Navigator.push( context,
      MaterialPageRoute(builder: (context) => LoginReg() ));
}
