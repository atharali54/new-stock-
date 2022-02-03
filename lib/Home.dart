import 'package:flutter/material.dart';
import 'package:stock/Drawer.dart';

import 'package:stock/AddItems.dart';

import 'package:stock/Login.dart';
import 'CatPage.dart';

import 'CategoryDrop.dart';
import 'Officemas.dart';
import 'Search.dart';

class HomePage extends StatelessWidget {
  final gridtitle = TextStyle(fontSize: 14, color: Colors.brown);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        title: Text('STOCK'),
      ),
      body: Container(
        color: Colors.brown[100],
        child: Column(children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Image.asset(
                    'assets/homeBg.jpg',
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 10),
                //   child: Text(
                //     'STOCK',
                //     style: TextStyle(
                //         color: Colors.brown,
                //         fontSize: 30,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: GridView.count(
                        childAspectRatio: 3.5,
                        shrinkWrap: true,
                        crossAxisCount: 1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 20,
                        physics: ScrollPhysics(),
                        children: <Widget>[
                          InkWell(
                            child: MyContainer(
                                myicon: Icons.supervised_user_circle,
                                tittle: 'CAREGORIES'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CatPage(),
                                ),
                              );
                            },
                          ),
                          InkWell(
                            child: MyContainer(
                                myicon: Icons.search, tittle: 'SEARCH'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(),
                                ),
                              );
                            },
                          ),

                          InkWell(
                            child: MyContainer(
                                myicon: Icons.add, tittle: 'Stock Entry'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemEntries(),
                                ),
                              );
                            },
                          ),
                          InkWell(
                            child: MyContainer(
                                myicon: Icons.add,
                                tittle: 'OfficeBranchApiData'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OfficeBranchApiData(),
                                ),
                              );
                            },
                          ),
                          // InkWell(
                          //   child: MyContainer(
                          //       myicon: Icons.supervised_user_circle,
                          //       tittle: 'LOGIN'),
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => Signin(),
                          //       ),
                          //     );
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class MyContainer extends StatelessWidget {
  final String tittle;
  final IconData myicon;
  MyContainer({this.myicon, @required this.tittle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(myicon, size: 30, color: Colors.brown),
          SizedBox(
            height: 5,
          ),
          Text(tittle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
