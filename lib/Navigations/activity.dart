import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Column(

          children: <Widget>[

            Padding(
              padding: EdgeInsets.all(35.0),
              child: Row(
                children: [
                  Text("Activity", style: TextStyle(color: Colors.black87,fontSize: 30, fontWeight: FontWeight.w600 ,decoration: TextDecoration.none) ),
                  Icon(Icons.favorite),
                ], ),),

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
                        itemCount: 6 ,
                        separatorBuilder: (context,_) => SizedBox(width: 25,),
                        itemBuilder: (context,index) => Recommendations(context, "Hey")
                    )
                )
                    : Center( child: CircularProgressIndicator(),)
            ),





            Padding(
              padding: EdgeInsets.all(35.0),
              child: Row(
                children: [
                  Text("Les Nouveau Post", style: TextStyle(color: Colors.black87,fontSize: 25, fontWeight: FontWeight.w800  ,decoration: TextDecoration.none) ),

                ],

    ),),


    SingleChildScrollView(
      child: Container(
      height: 400,


      ),
    )


          ],

        ),
      ),


    );
  }
}


Widget Recommendations(BuildContext context,String S) => GestureDetector(


child:

   Container(
     width: 150,
  child: new Card(
    child: new Center(
   child: new
      Column(
     children: <Widget>[

       CircleAvatar(
         backgroundImage: NetworkImage("_profilPic"),
         minRadius: 50,
         maxRadius: 55,
       ),

       Text("Yves", style: TextStyle(color: Colors.black87,fontSize: 30, fontWeight: FontWeight.bold ,decoration: TextDecoration.none) ),
       Text("Painter", style: TextStyle(color: Colors.grey,fontSize: 18, fontWeight: FontWeight.bold ,decoration: TextDecoration.none) ),


     ],

   )
      ,),
),
  decoration: new BoxDecoration(
    boxShadow: [ new BoxShadow(
      color: Colors.black,
      blurRadius: 11.0,),
    ],
),
)


);


Widget ArtScroll(BuildContext context) => Container(
  color: Colors.green,
  child: Material(
    child: ListTile(
      title: const Text('ListTile with red background'),
      tileColor: Colors.red,
    ),
  ),
);
