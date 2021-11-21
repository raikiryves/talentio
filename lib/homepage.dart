import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:talentio/Navigations/newsearch.dart';
import 'package:talentio/setting.dart';
import 'package:talentio/trending.dart';
import 'searchscreen.dart';

int currentIndex = 0;
int _page = 0;
GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  List<Widget> Widgets = <Widget>[ ArtistSearch() ,TrendingScreen(), Settings()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,

        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          height: 50,
          index: _page,
        key: _bottomNavigationKey,
        items: <Widget>[
        Icon(Icons.zoom_in_outlined , size: 30),
    Icon(Icons.palette, size: 30),
    Icon(Icons.person_pin_rounded , size: 30),
    ],
    onTap: (index) {
    setState(() {
    _page = index;
    });
    },
    ),
      body: Widgets[_page],
    );


  }
}
