import 'package:flutter/material.dart';
import 'package:stock/Home.dart';
import 'package:stock/Login.dart';

import 'CatPage.dart';
import 'Search.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Colors.white, Colors.brown],
                stops: [0.3, 1],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 90.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/homeBg.jpg',
                          ))),
                ),
                // Text(
                //   'STOCK',
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.category,
              color: Colors.brown,
              size: 30,
            ),
            title: Text(
              'Categories',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CatPage()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.search,
              color: Colors.brown,
              size: 30,
            ),
            title: Text(
              'Search',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              color: Colors.brown,
              size: 30,
            ),
            title: Text(
              'Share',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.login_outlined,
              color: Colors.brown,
              size: 30,
            ),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Signin()));
            },
          ),
        ],
      ),
    );
  }
}
