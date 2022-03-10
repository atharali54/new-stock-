import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock/Model/BranchmasModel.dart';
import 'Model/AllDataModel.dart';
import 'Model/OfficemasModel.dart';
import 'SingleProdScreen.dart';
import 'Transfer.dart';

String officeid;
int branchid;
List<AllStock> convertedJsonData;
List<AllStock> convertedJsonData1;
String officvalue;

class TestPage extends StatefulWidget {
  String id;
  String promodelid;
  String proprice;
  String prosrno;
  String prostockRegister;
  String promodelno;
  String promake;
  String proremarks;
  String procategory;
  String protehsil;
  String prostatus;
  String probranchide;
  String prowarrantyPeriod;
  String prodealer;
  String propresentlocation;
  // String prodealer;
  TestPage(
      {Key key,
      this.promake,
      this.promodelid,
      this.procategory,
      this.proprice,
      this.prodealer,
      this.promodelno,
      this.probranchide,
      this.proremarks,
      this.prosrno,
      this.prostatus,
      this.prostockRegister,
      this.protehsil,
      this.propresentlocation,
      this.prowarrantyPeriod})
      : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  List<OfficeMas> convertedJsonDataOffic;
  List<BranchMas> convertedJsonBranch;

  Future<List<OfficeMas>> fetchOfficeData() async {
    try {
      http.Response response =
          await http.get('http://103.87.24.57/stockapi/officemas');
      if (response.statusCode == 200) {
        convertedJsonDataOffic = officeMasFromJson(response.body);
        return convertedJsonDataOffic;
      } else {
        return throw Exception('Failed to load ...');
      }
    } catch (e) {
      return throw Exception('Failed to load ...');
    }
  }

  Future<List<BranchMas>> fetchBranchMas(String officeid) async {
    try {
      http.Response response = await http
          .get('http://103.87.24.57/stockapi/branchmas/' + officeid.toString());
      if (response.statusCode == 200) {
        convertedJsonBranch = branchMasFromJson(response.body);
        return convertedJsonBranch;
      } else {
        return throw Exception('Failed to load ...');
      }
    } catch (e) {
      return throw Exception('Failed to load ...');
    }
  }

  Future<void> setBranch(String id) async {
    var d = await fetchBranchMas(id);
    setState(() {});
  }

  void initState() {
    super.initState();
    fetchOfficeData().then((users) {
      setState(() {
        convertedJsonDataOffic = users;
      });
    });
  }

  Future<List<AllStock>> fetchData() async {
    try {
      http.Response response =
          await http.get('http://103.87.24.57/stockapi/stock');
      if (response.statusCode == 200) {
        // final List<User> user = userFromJson(response.body);
        // return user;
        debugPrint(response.body);

        return allStockFromJson(response.body);
      } else {
        return throw Exception('Failed to load ...');
      }
    } catch (e) {
      return throw Exception('Failed to load ...');
    }
  }

  void getStock() {
    fetchData().then((users) {
      setState(() {
        convertedJsonData =
            users.where((element) => element.branchid == branchid).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page '),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'assets/homeBg.jpg',
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                DropdownButton(
                    //_value1.isNotEmpty ? _value1 : null,
                    hint: Text('Select Office '),
                    //value: officeid.isNotEmpty ? officeid : null,
                    value: officeid,
                    items: convertedJsonDataOffic != null
                        ? convertedJsonDataOffic.map((OfficeMas items) {
                            return DropdownMenuItem(
                                value: items.officeid.toString(),
                                child: Text(items.officeName));
                          }).toList()
                        : null,
                    onChanged: (dynamic newValue) {
                      officeid = newValue;
                      setState(() {
                        branchid = null;
                      });
                      setBranch(officeid);
                    }),
                DropdownButton(
                    hint: Text('branch' + branchid.toString()),
                    // value: null,
                    value: branchid,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: convertedJsonBranch != null
                        ? convertedJsonBranch.map((BranchMas items) {
                            return DropdownMenuItem(
                                value: items.branchid,
                                child: Text(items.branchName));
                          }).toList()
                        : null,
                    onChanged: (dynamic newValue) {
                      setState(() {
                        branchid = newValue;
                      });
                    }),
                ElevatedButton(
                  child: Text('Search Data'),
                  onPressed: () {
                    // setState(() {
                    getStock();
                    // });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: fetchData(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  return snapshot.hasData
                      ? GridView.builder(
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),

                          // current the spelling of length here
                          //convertedJsonData == null ? 0 : convertedJsonData.length,
                          //   itemCount: convertedJsonData.length,
                          itemCount: convertedJsonData?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.grey[350],
                              elevation: 20,
                              child: Center(
                                child: Stack(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      convertedJsonData[index]
                                          .dop
                                          .toString(), //+ convertedJsonData[index],
                                      style: TextStyle(
                                        color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Text(
                                        convertedJsonData[index]
                                            .category
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Please wait.......',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 38.0),
                              child: Center(
                                  child: const CircularProgressIndicator(
                                backgroundColor: Colors.brown,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.green),
                                strokeWidth: 5,
                              )),
                            ),
                          ],
                        );
                }),
          ),
        ],
      ),
    );
  }
}
