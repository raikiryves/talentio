import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:talentio/Models/artist.dart';
import 'package:talentio/loginscreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talentio/newprofil.dart';
import 'package:talentio/profils.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  @override
  void initState() {
    super.initState();
    getFirebaseImages();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        body:

        Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end:   Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF398AE5)
                ],
              ),
            ),

            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),


            child:
            SingleChildScrollView(
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children:  <Widget>[


                  Text("Rechercher \nParmi nos Talentieux Artists", style: TextStyle(color: Colors.white,fontSize: 35, fontWeight: FontWeight.w600 ) ),
                  SizedBox(height: 30,),

                  TextField(
                    obscureText: true,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: 'Enter le nom d un Artist',
                    ),
                  ),SizedBox(height: 30,),

                  Text("Les Oeuvres", style: TextStyle(color: Colors.white,fontSize: 35, fontWeight: FontWeight.w600 ) ),
                  SizedBox(height: 5,),

                  FutureBuilder
                    (
                      future: Future.delayed(Duration(seconds: 1)),
                      builder: (c, s) =>
                      s.connectionState == ConnectionState.done
                          ? Container(
                          height: 200,

                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                              scrollDirection: Axis.horizontal,
                              itemCount: urls.length,
                              separatorBuilder: (context,_) => SizedBox(width: 10,),
                              itemBuilder: (context,index) => Cards(  urls[index].toString() )
                          )
                      )
                          : Center( child: CircularProgressIndicator(),)
                  ),



                  Text("Les Artists", style: TextStyle(color: Colors.white,fontSize: 35, fontWeight: FontWeight.w600 )),


                  Container(
                    height: 500,
                    child:

                    StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('artists').snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(!snapshot.hasData){
                            return Center(
                              child: CircularProgressIndicator(),

                            );
                          }

                          return ListView(

                            children: snapshot.data!.docs.map((document) {
                              return GestureDetector(



                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),

                                  child: Container(
                                  decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(15.0),
                                  gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF73AEF5),
                                    Color(0xFF61A4F1),
                                    Color(0xFF398AE5)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                              ),
                                  ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading:Icon(Icons.album),
                                          title: Text(document['name']),
                                          subtitle: Text("1st Artist"),

                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () => Navigator.push( context,
                                  MaterialPageRoute(builder: (context) => ArtistProfil( UserID: document.id)),
                                ),

                              );
                            }).toList(),
                          );
                        }
                    ),



                  )



                ],


              ),

            )
        )

    );


  }
}



Future<void> getFirebaseImages() async {
  final result = await FirebaseStorage.instance.ref().listAll();

  result.items.forEach((Reference ref) async {
    await ref.getDownloadURL().then((value) {
      String val = value.toString();
      if (!urls.contains(val))
        urls.add(val);
    });
  });
}


Widget Cards(String url) => Container(
  height: 500,
  width: 150,
  decoration: BoxDecoration(

    image: DecorationImage(
      fit: BoxFit.fill,
      image: NetworkImage(url),
    ),
  ),

);

Widget ArtistScroll(BuildContext context,String S) => GestureDetector(



  child: Card(
 child: Column(
   mainAxisSize: MainAxisSize.min,
   children: <Widget>[
      ListTile(
       leading:Icon(Icons.album),
       title: Text("$S"),
       subtitle: Text("1st Artist"),

     ),

   ],
 ),
  ),

);







