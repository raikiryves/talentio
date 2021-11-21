import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talentio/Models/artist.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:talentio/postview.dart';


  Artist lartist = Artist("loading...", "loading...", "loading...","");
  String URL = "";
  bool refreshed = false;
  List<String> urls = [];


class Profils extends StatefulWidget {
  const Profils({Key? key, required this.UserID}) : super(key: key);

  final String UserID;



  @override
  _ProfilsState createState() => _ProfilsState();
}

class _ProfilsState extends State<Profils> {



  @override
  void initState()  {
    super.initState();
    CreateArtist(widget.UserID);


    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // do what you want here
      urls.clear();
      if(refreshed == false)
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => super.widget));
          refreshed = true;

  });
    LoadPicture(widget.UserID);
        }



    @override
  Widget build(BuildContext context) {

    return FutureBuilder
      (
        future: Future.delayed(Duration(milliseconds: 500)),
        builder: (c, s) =>
        s.connectionState == ConnectionState.done
            ? Stack(

          children: <Widget>[
            Container(
                color: Colors.black,
                child: Column(


                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: <Widget>[


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[ SizedBox(height: 100,),

                        Text( lartist.name, style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w600 ,decoration: TextDecoration.none),
                        )





                      ],

                    ),





                    Row(
                      mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Container(


                            child: CircleAvatar(
                              backgroundImage: NetworkImage(URL),
                              minRadius: 50,
                              maxRadius: 55,
                            )
                        ),
                      ],
                    ),

                    SizedBox(height: 30,),

                    Container(child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Posts \n" + urls.length.toString() , textAlign: TextAlign.center ,style: TextStyle(color: Colors.white,fontSize: 15,decoration: TextDecoration.none )  ),
                          Text("Followers \n " + lartist.Followers , textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 15,decoration: TextDecoration.none)  ),
                          Text("Following \n "+ lartist.following, textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 15,decoration: TextDecoration.none) )
                        ]
                    ),)

                  ],
                )



            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 380,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)

                    )
                ),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 130, vertical: 20),
                      child: Row(
                        children: <Widget>[
                          Text("Les Arts", style: TextStyle(color: Colors.black87,fontSize: 30, fontWeight: FontWeight.w600 ,decoration: TextDecoration.none) ),
                          SizedBox(height: 40,),




                        ],


                      ),

                    ),
                    Container(
                      height: 300,


                      child:
                      GridView.builder(
                          itemCount: urls.length,
                          physics: ScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,

                          ),
                          itemBuilder: (context,index) => GestureDetector(
                            onTap: () {
                              Navigator.push( context,
                                MaterialPageRoute(builder: (context) => PostView( PostID: urls[index].toString())),
                              );
                            },
                            child: Image.network(urls[index].toString()),
                          )
                      ),




                    ),




                  ],
                ),
              ),

            ),



          ],

        )






            : Center( child: CircularProgressIndicator(),)
    );


  }
}

Widget Cards() => Container(
  height: 500,
  width: 150,

  decoration: const BoxDecoration(

    image: DecorationImage(
      fit: BoxFit.fill,
      image: NetworkImage("https://yt3.ggpht.com/A0Akk6wV22cRafLC9oJnd_BaWq4W1t2xBW__8PRcque1c5eUHeE_NSL-4pLknqjvZ3la6C8ObQ=s900-c-k-c0x00ffffff-no-rj"),
    ),
  ),

);


Future getCurrentUserData(String uid) async{

  try {
    FirebaseFirestore FF = FirebaseFirestore.instance;
    DocumentSnapshot ds =  await FF.collection('artists').doc(uid).get();
    String  firstname = ds.get('Name');
    String lastname = ds.get('LastName');
    return firstname;
  }catch(e){
    print(e.toString());
    return null;
  }
}

Future CreateArtist(String uid) async
{
  try {
    FirebaseFirestore FF = FirebaseFirestore.instance;
    DocumentSnapshot ds = await FF.collection('artists').doc(uid).get();
    lartist = Artist(ds.get('name'),ds.get('following') ,ds.get('followers'),ds.id);
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
      if(!urls.contains(val))
        urls.add(val);
    });
  });


  //var url = await ref.getDownloadURL();
  //URL = url.toString();


}


