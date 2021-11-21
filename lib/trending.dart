import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:talentio/postview.dart';

 List<String> urls = [];
 bool refreshed = false;

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({Key? key}) : super(key: key);



  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {

  @override
  void initState() {
    super.initState();
    getFirebaseImages();
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
      FutureBuilder
      (
        future: Future.delayed(Duration(seconds: 1)),
        builder: (c, s) =>
        s.connectionState == ConnectionState.done
            ? GridView.builder(
            itemCount: urls.length,
            physics: ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,

            ),
            itemBuilder: (context,index)=> GestureDetector(
              onTap: () {
                Navigator.push( context,
                  MaterialPageRoute(builder: (context) => PostView( PostID: urls[index].toString())),
                );
              },
              child: Image.network(urls[index].toString()),
            ))
            : Center( child: CircularProgressIndicator(),)
    ),
        Align(
          alignment: Alignment(0.7, 0.7),
          child:
          GestureDetector(
    onTap: () {
    setState(() {

      _onAlertButtonPressed(this.context);

    });
    },
              child: CircleAvatar(
                radius: 30.0,
                child:Icon(
                    Icons.search

                ),

              )

          )

        )
    ]

    );
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
}

_onAlertButtonPressed(context) {
  Alert(
      context: context,
      title: "Categories",
      content: Column(
        children: <Widget>[
          GestureDetector(
          onTap: () {
  Navigator.pushNamed(context, "myRoute");
  },
    child: new Text("Pixel"),
  ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "myRoute");
            },
            child: new Text("Art"),
          ),


        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

Widget Category(BuildContext context) => GestureDetector(



  child: Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading:Icon(Icons.album),
          title: Text("pixel"),
        ),

      ],
    ),
  ),

);
