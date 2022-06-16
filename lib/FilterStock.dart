import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock/Model/BranchmasModel.dart';
import 'Model/AllDataModel.dart';
import 'Model/OfficemasModel.dart';
import 'SinglePageData.dart';
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
    getStock();
  }

  Future<List<AllStock>> fetchData() async {
    try {
      http.Response response =
          await http.get('http://103.87.24.57/stockapi/stock');
      if (response.statusCode == 200) {
        // final List<User> user = userFromJson(response.body);
        // return user;

        return allStockFromJson(response.body);
      } else {
        return throw Exception('Failed to load ...');
      }
    } catch (e) {
      return throw Exception('Failed to load ...');
    }
  }

  Future<void> getStock() async {
    await fetchData().then((users) {
      if (this.mounted) {
        setState(() {
          convertedJsonData = users.toList();
        });
      }
    });
  }

  void filter() {
    setState(() {
      convertedJsonData1 = convertedJsonData
          .where((element) => element.branchid == branchid)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Office Wise'),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: <Widget>[
                Container(
                    margin:
                        EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 0),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.0, style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                    child: DropdownButton(
                        isExpanded: true,
                        hint: Text('Select Office '),
                        value: officeid,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: convertedJsonDataOffic != null
                            ? convertedJsonDataOffic.map((OfficeMas items) {
                                return DropdownMenuItem(
                                    value: items.officeid.toString(),
                                    child: Text(items.officeName));
                              }).toList()
                            : null,
                        onChanged: (dynamic newValue) {
                          officeid = newValue;
                          setBranch(officeid);
                        })),
                Container(
                    margin:
                        EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 0),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.0, style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                    child: DropdownButton(
                        isExpanded: true,
                        hint: Text('Select Branch '),
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
                        })),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          filter();
                        });
                      },
                      child: Text('SEARCH')),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    convertedJsonData1 == null ? 0 : convertedJsonData1.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MySingleProduct(
                              probranchid:
                                  convertedJsonData1[index].branchid.toString(),
                              prooffice:
                                  convertedJsonData1[index].office.toString(),
                              probranch:
                                  convertedJsonData1[index].branch.toString(),
                              probissue:
                                  convertedJsonData1[index].issuedto.toString(),
                              probmobile:
                                  convertedJsonData1[index].mobile.toString(),
                              promake:
                                  convertedJsonData1[index].make.toString(),
                              proremarks:
                                  convertedJsonData1[index].remarks.toString(),
                              prostatus:
                                  convertedJsonData1[index].status.toString(),
                              procategory:
                                  convertedJsonData1[index].category.toString(),
                              prostockRegister: convertedJsonData1[index]
                                  .stockRegister
                                  .toString(),
                              prowarrantyPeriod: convertedJsonData1[index]
                                  .warrantyPeriod
                                  .toString(),
                              protehsil:
                                  convertedJsonData1[index].tehsil.toString(),
                              prosrno:
                                  convertedJsonData1[index].srno.toString(),
                              prodevicesrno:
                                  convertedJsonData1[index].serialno.toString(),
                              proprice:
                                  convertedJsonData1[index].price.toString(),
                              prodealer:
                                  convertedJsonData1[index].dealer.toString(),
                              promodelno:
                                  convertedJsonData1[index].modelno.toString(),
                              promodelid:
                                  convertedJsonData1[index].project.toString()),

                          //Cart(_cartList),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        selected: true,
                        selectedTileColor: Colors.grey[300],
                        title: Text(
                          convertedJsonData1[index].make +
                              " " +
                              convertedJsonData1[index].modelno,
                          style: TextStyle(color: Colors.red),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        ),
                        leading: Icon(Icons.arrow_back),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TransferProduct(
                                srno: convertedJsonData1[index].srno.toString(),
                                office:
                                    convertedJsonData1[index].office.toString(),
                                branchid: convertedJsonData1[index]
                                    .branchid
                                    .toString(),
                                issued: convertedJsonData1[index]
                                    .issuedto
                                    .toString(),
                                mobile:
                                    convertedJsonData1[index].mobile.toString(),
                                //Cart(_cartList),
                              ),
                            ));
                          },
                          child: Text('TR'),
                        ),
                        // Text(
                        //   '₹' + convertedJsonData1[index].price.toString(),
                        //   style: TextStyle(color: Colors.green),
                        // ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(convertedJsonData1[index]
                            //     .warrantyPeriod
                            //     .toString()),
                            Text('S.No: ' + convertedJsonData1[index].serialno),
                            Text('Issued: ' +
                                convertedJsonData1[index].issuedto.toString()),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
