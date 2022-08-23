import 'package:flutter/material.dart';
import 'package:stock/Drawer.dart';
import 'package:stock/FilterStock.dart';

import 'Search.dart';

class HomeUser extends StatelessWidget {
  String utype;
  String mob;
  String branchid;
  HomeUser({
    Key key,
    this.utype,
    this.mob,
    this.branchid,
  }) : super(key: key);
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
                    height: 170,
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
                                myicon: Icons.search, tittle: 'Userwise'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(
                                    Mob: mob,
                                    utype: utype,
                                  ),
                                ),
                              );
                            },
                          ),
                          InkWell(
                            child: MyContainer(
                                myicon: Icons.supervised_user_circle,
                                tittle: 'Office wise'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TestPage(
                                    Mob: mob,
                                    utype: utype,
                                    bid: branchid,
                                  ),
                                ),
                              );
                            },
                          ),
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
          Icon(myicon, size: 40, color: Colors.green[900]),
          SizedBox(
            height: 5,
          ),
          Text(tittle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown))
        ],
      ),
    );
  }
}
