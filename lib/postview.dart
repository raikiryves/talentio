import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

   String? Url;

class PostView extends StatefulWidget {
  const PostView({Key? key, required this.PostID}) : super(key: key);

  final String PostID;

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {


  @override
  Widget build(BuildContext context) {
    return Material(
      child:
        //Text(widget.PostID)
      //Image.network(widget.PostID),
      Container(
        height: MediaQuery.of(context).size.width * 1.1,
        decoration: BoxDecoration(
            image: DecorationImage(
              image : NetworkImage(widget.PostID),
              fit: BoxFit.cover,
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[



            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width * 0.9,
                        width: MediaQuery.of(context).size.width * 0.2,

                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),

                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(60)
                            )
                        )
                        ,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            GestureDetector(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 30.0,
                                    child:Icon(
                                        Icons.favorite,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text("1.3k",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),)
                                ],
                              ),

                              onTap: () {
                                setState(() {

                                  _onAlertButtonPressed(this.context);

                                });
                              },
                            ),


                            GestureDetector(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 30.0,
                                    child:Icon(
                                      Icons.chat,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text("34",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),)
                                ],
                              ),

                              onTap: () {
                                setState(() {

                                  _onAlertButtonPressed(this.context);

                                });
                              },
                            ),


                            GestureDetector(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 30.0,
                                    child:Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text("345",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),)
                                ],
                              ),

                              onTap: () {
                                setState(() {

                                  _onAlertButtonPressed(this.context);

                                });
                              },
                            ),


                          ],
                        ),
                      )

                    ],
                  )

                ],
              ),
            ),
            SizedBox(height: 30,)
            ,Padding(
              padding: const EdgeInsets.all(28.0),
              child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(205, 203, 220,1),
                  borderRadius: BorderRadius.circular(29.5)
              ),
              child: TextField(
                //controller: monMotdePass,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.chat_bubble),
                  border: InputBorder.none,
                  hintText: "Laissez un commentaire",

                ),
              ),
          ),
            ),

            SizedBox(height: 30,)

          ],
        ),
      ),




    );
  }
}

_onAlertButtonPressed(context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "Erreur",
    desc: "Vous Avez pas Accés à cette fonction.",
    buttons: [
      DialogButton(
        child: Text(
          "Ah Okay!",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}


