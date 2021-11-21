import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:talentio/Models/artist.dart';

import '../newprofil.dart';

List<Artist> lesArtists = [];
List<String> _urlProfil = [];


class ArtistSearch extends StatefulWidget {
  const ArtistSearch({Key? key}) : super(key: key);

  @override
  _ArtistSearchState createState() => _ArtistSearchState();
}

class _ArtistSearchState extends State<ArtistSearch> {



  @override
  void initState() {
    super.initState();
    LoadUser();
  }


  @override
  Widget build(BuildContext context)
  {
    var size = MediaQuery.of(context).size;

    return Material(
      child: Stack(
        children:<Widget>[
        Container(
          height: size.height * .45,
          color: Color(0xFFF5CEB8),
        ),

          SafeArea(child:
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Text("Rechercher", style: TextStyle(color: Colors.white,fontSize: 35, fontWeight: FontWeight.w600 ) ),
                    Text("Parmi nos Artists", style: TextStyle(color: Colors.white,fontSize: 35, fontWeight: FontWeight.w600 ) ),
                    SizedBox(height: 18,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29.5)
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          border: InputBorder.none,
                          hintText: "Cherche ici"
                        ),
                      ),
                    ),
                    SizedBox(height: 18,),

                    Container(
                      height: 150,
                      child: GridView.builder(
                          itemCount: 3,

                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 18

                          ),
                          itemBuilder: (context,index)=> GestureDetector(
                            onTap: () {


                            },
                            child: Container(
                              height: 10,


                                child:
                                    Container(
                                      height: 10,
                                //Button Follow
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        end:   Alignment.bottomLeft,
                                        colors: [Color(0xFFFC77FB),
                                          Color(0xFFEE9944),]), borderRadius: BorderRadius.circular(30.0)),
                                child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [Text('Artist', style : TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white,decoration: TextDecoration.none) , )],)),
                            ) )),
                    ),
                    SizedBox(height: 30,),

                    Text("Les Artists", style: TextStyle(color: Colors.black87,fontSize: 25, fontWeight: FontWeight.w800  ,decoration: TextDecoration.none) ),
                    SizedBox(height: 30,),






                    Container(
                      height: 300,
                      child: ListView.builder(
                          itemCount: lesArtists.length,
                          itemBuilder: (context,index){
                          return GestureDetector(
                            child: Card(

                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage( _urlProfil[index] ),
                                    minRadius: 29,
                                    maxRadius: 29,
                                  ),
                                  title: Text(  lesArtists[index].name   ),
                                  subtitle: Text('1st Artists'),
                                ),
                              ),
                            onTap: () => Navigator.push( context,
                              MaterialPageRoute(builder: (context) => ArtistProfil( UserID: lesArtists[index].uid)),
                            ),
                          );

                          }
                    ) )



                  ],
                ),


              )

          ),






          ]



      ),
    );
  }
}

Future LoadUser() async
{

  FirebaseFirestore.instance
      .collection('artists')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      Artist A = Artist( doc["name"],doc["following"],doc["followers"],doc.id);
      if(!lesArtists.contains(A)) {
        lesArtists.add(A);
        print(doc["name"]);
        LoadProfile(A.uid);
      }
    });
  });
  
  


}

Future<String> LoadProfile(String uid) async
{
  String val = "https://paintbynumberscanvas.com/wp-content/uploads/2020/09/pokemon-pikachu-paint-by-number.jpg";
  //Reference ref = FirebaseStorage.instance.ref().child('/testimage.png');

  final result = await FirebaseStorage.instance.ref().child(uid).child(("Profil")).listAll();

  result.items.forEach((Reference ref) async {
    await ref.getDownloadURL().then((value) {
      val = value.toString();
      if(!_urlProfil.contains(val))
        _urlProfil.add(val);
      print(val);
    });
  });

  return val;
}
