import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:talentio/postview.dart';

import 'Models/artist.dart';



Artist lartist = Artist("loading...", "loading...", "loading...","Loading"); //Initialisation d'un Artist
String _URL = ""; //Initialisation d'une URL placeholder
bool refreshed = false; //bool rarement utiliser pour les téléphone qui galère a charger


//List des Url pour afficher les posts,story & profile pic
List<String> _urls = [];
List<String> _stories = [];
String _profilPic = "";



class ArtistProfil extends StatefulWidget {
  const ArtistProfil({Key? key,required this.UserID}) : super(key: key);

  final String UserID;

  @override
  _ArtistProfilState createState() => _ArtistProfilState();
}

class _ArtistProfilState extends State<ArtistProfil> {

  //Function qui s'exécute en priorité
  @override
  void initState()  {
    super.initState();
    CreateArtist(widget.UserID);


    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // function qui dois s'exécutez
      _urls.clear();
      if(refreshed == false)
        //si firebase est trop long ça refresh la page pour que firebase affiche ce qu'il voulais afficher
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => super.widget));
      refreshed = true;

    });
    LoadPicture(widget.UserID);
    LoadStories(widget.UserID);
    LoadProfilePic(widget.UserID);
  }




  @override
  Widget build(BuildContext context) {

    //Stackers les toutes les contenues
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 1.1 ,//changer la taille par rapport à l'écran
              decoration: BoxDecoration(
                //background
                image: DecorationImage(
                  fit: BoxFit.fill,//remplir le background avec la photo
                  image: NetworkImage(_profilPic),
                ),

              ),
    //mettre le background en flou
    child: new BackdropFilter(
    filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
    child: new Container(
    decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
    ),
            ),
            ),


          ],
        ),
          Align(
          alignment: Alignment.bottomCenter,
    child:


// 2eme Stack qui rassembles les stories et posts
    Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
    Container(
      height: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
      color: Colors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(80)
          )
      ),
    ),

        //mettres les choses bien séparer et centrer
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              //les 4 stories(highlight que l'artist a
              CircleAvatar(
                backgroundImage: NetworkImage( _stories[0].toString() ),
                minRadius: 29,
                maxRadius: 29,
              ),

              CircleAvatar(
                backgroundImage: NetworkImage( _stories[1].toString() ),
                minRadius: 29,
                maxRadius: 29,
              ),


              CircleAvatar(
                backgroundImage: NetworkImage( _stories[2].toString()),
                minRadius: 29,
                maxRadius: 29,
              ),

              CircleAvatar(
                backgroundImage: NetworkImage( _stories[3].toString() ),
                minRadius: 29,
                maxRadius: 29,
              ),


            ],

          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top:100,bottom: 10,left: 8,right: 8),
          child: Container(
            height: 300,


            child:
            GridView.builder(
                itemCount: _urls.length,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,


                ),
                itemBuilder: (context,index) => GestureDetector(
                  onTap: () {
                    Navigator.push( context,
                      MaterialPageRoute(builder: (context) => PostView( PostID: _urls[index].toString())),
                    );
                  },
                  child: Image.network(_urls[index].toString()),
                )
            ),




          ),
        )

      ]
    )



          ),





        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Profession de l'artist
    SizedBox(width: MediaQuery.of(context).size.width * 0.35),
    Text("Painter", style: TextStyle(color: Colors.black87,fontSize: 30, fontWeight: FontWeight.bold ,decoration: TextDecoration.none) ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.15,),
              Icon(Icons.favorite),SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
              Icon(Icons.audiotrack), SizedBox(height: MediaQuery.of(context).size.width * 0.02,),





            ],
          ),




        ),
        Padding( padding: const EdgeInsets.all(65.0),
        child:
            Row(
              children: [
                Container(

                   //Photo de profil de l'artist
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(_profilPic),
                      minRadius: 50,
                      maxRadius: 55,
                    )
                ),SizedBox(width: 30,),

                //Username de l'artist
                Text(lartist.name, style: TextStyle(color: Colors.black87,fontSize: 30, fontWeight: FontWeight.bold ,decoration: TextDecoration.none) ),






              ],
            ),

          
        ),

        Padding(
          padding: EdgeInsets.only(top:230),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Information popularité, nombres de posts et button follow de l'artist
              Column(
                children: [
                  Text(lartist.Followers, style: TextStyle(color: Colors.black87,fontSize: 20, fontWeight: FontWeight.bold ,decoration: TextDecoration.none) ),
                  Text("follower", style: TextStyle(color: Colors.black87,fontSize: 20, fontWeight: FontWeight.bold ,decoration: TextDecoration.none) ),
                ],
              ),

              Column(
                children: [
                  Text( _urls.length.toString(), style: TextStyle(color: Colors.black87,fontSize: 20, fontWeight: FontWeight.bold ,decoration: TextDecoration.none) ),
                  Text("Post", style: TextStyle(color: Colors.black87,fontSize: 20, fontWeight: FontWeight.bold ,decoration: TextDecoration.none) ),
                ],
              ),


              Column(
                children: [
                  Container(
                      padding: EdgeInsets.only( left: 18, right:18,top: 8,bottom: 8 ),

    //Button Follow
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.bottomRight,
    end:   Alignment.bottomLeft,
    colors: [Color(0xFFFC77FB),
      Color(0xFFEE9944),]), borderRadius: BorderRadius.circular(30.0)),
                      child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [Text('Follow', style : TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white,decoration: TextDecoration.none) , )],)),
                ],
              ),

            ],
          ),
        ),












      ],
    );
  }
}


Future CreateArtist(String uid) async
{
  try {
    FirebaseFirestore FF = FirebaseFirestore.instance;
    DocumentSnapshot ds = await FF.collection('artists').doc(uid).get();
    lartist = Artist(ds.get('name'),ds.get('followers') ,ds.get('following'),ds.id);
  } catch (e) {
    lartist = Artist("Yv","","","");
  }
}

Future LoadPicture(String uid) async
{

  //Reference ref = FirebaseStorage.instance.ref().child('/testimage.png');

  final result = await FirebaseStorage.instance.ref().child(uid).listAll();

  result.items.forEach((Reference ref) async {
    await ref.getDownloadURL().then((value) {
      String val = value.toString();
      if(!_urls.contains(val))
        _urls.add(val);
    });
  });


  //var url = await ref.getDownloadURL();
  //URL = url.toString();


}


//Load les Story qui sont dans la base de donnés
Future LoadStories(String uid) async
{

  final result = await FirebaseStorage.instance.ref().child(uid).child("Story").listAll();

  result.items.forEach((Reference ref) async {
    await ref.getDownloadURL().then((value) {
      String val = value.toString();
      if(!_stories.contains(val))
        _stories.add(val);
    });
  });

}

Future LoadProfilePic(String uid) async
{

  //Reference ref = FirebaseStorage.instance.ref().child('/testimage.png');

  final result = await FirebaseStorage.instance.ref().child(uid).child(("Profil")).listAll();

  result.items.forEach((Reference ref) async {
    await ref.getDownloadURL().then((value) {
      String val = value.toString();
      if(_profilPic != val)
        _profilPic = val;
    });
  });


  //var url = await ref.getDownloadURL();
  //URL = url.toString();


}





