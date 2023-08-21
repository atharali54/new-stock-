import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

import 'package:stock/Widgets.dart';

import 'Model/BranchmasModel.dart';
import 'Model/CategoryModel.dart';
import 'Model/OfficemasModel.dart';

String statusValue;
String officeid;
int branchid;
var dropdownTextDesign =
    TextStyle(fontSize: 20, color: Colors.brown, fontWeight: FontWeight.bold);

class CatPage extends StatefulWidget {
  @override
  _ApiMapEx04State createState() => _ApiMapEx04State();
}

class _ApiMapEx04State extends State<CatPage> {
  List<StockCat> convertedJsonData;
  List<StockCat> convertedJsonData1;
  List<OfficeMas> convertedJsonDataOffic;
  List<BranchMas> convertedJsonBranch;

  Future<List<StockCat>> fetchData() async {
    try {
      http.Response response =
          await http.get(Uri.parse('http://103.87.24.57/stockapi/catwise'));
      if (response.statusCode == 200) {
        convertedJsonData = stockCatFromJson(response.body);
        return convertedJsonData;
      } else {
        return throw Exception('Failed to load ...');
      }
    } catch (e) {
      return throw Exception('Failed to load ...');
    }
  }

  Future<List<StockCat>> fetchbyidData(String id) async {
    try {
      http.Response response = await http
          .get(Uri.parse('http://103.87.24.57/stockapi/catwise/' + id));
      if (response.statusCode == 200) {
        var d = stockCatFromJson(response.body);
        return d;
      } else {
        return throw Exception('Failed to load ...');
      }
    } catch (e) {
      return throw Exception('Failed to load ...');
    }
  }

  Future<List<OfficeMas>> fetchOfficeData() async {
    try {
      http.Response response =
          await http.get(Uri.parse('http://103.87.24.57/stockapi/officemas'));
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
      http.Response response = await http.get(Uri.parse(
          'http://103.87.24.57/stockapi/branchmas/' + officeid.toString()));
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

  @override
  void initState() {
    super.initState();

    fetchOfficeData().then((users) {
      setState(() {
        convertedJsonDataOffic = users;
        convertedJsonDataOffic.insert(
            0, OfficeMas(officeName: 'Select All', officeid: 0));
        //debugPrint(convertedJsonDataOffic.length.toString());
      });
    });
    fetchData().then((users) {
      setState(() {
        convertedJsonData = users;
        convertedJsonData1 = convertedJsonData;
      });
    });
  }

  Future<void> setBranch(String id) async {
    branchid = null;
    var d = await fetchBranchMas(id);
    setState(() {});
  }

  var itemStatus = [
    'Select All ',
    'I Ball Splendo',
    'Air Blower',
    'Air Conditioner',
    'Almirah',
    'Battery',
    'Bio Matric Device',
    'Cabinet',
    'Camera',
    'Card Cutter',
    'CCTV Cameras',
    'Chair',
    'Computer',
    'Cooffee Machine',
    'Cooler',
    'Digital Camera',
    'Display & Disit Set',
    'Duplex Unit Printer',
    'DVR',
    'Easy Cleaner',
    'EPABX',
    'Exaust Fan',
    'Eye Scaning Machine',
    'Fire Bucket With Stand',
    'Fire Extingusher',
    'Genrator',
    'Geyser',
    'GPS Device',
    'Handy Cam',
    'Hard Disk',
    'Head Phone',
    'I Ball',
    'I Phone',
    'Invertor',
    'I-Pad',
    'Laptop',
    'MAC Book',
    'Mike',
    'Mike & Sound System',
    'Mobile',
    'Motor Cycle',
    'N-Computing',
    'Networking Switch',
    'Paper-Shhedder',
    'Pen Digitizer',
    'Photo Frame',
    'USB HUB' 'Wall Fan',
    'Web Cam',
  ];
  Future<void> filterdate() async {
    if (branchid != null) {
      await fetchbyidData(branchid.toString()).then((users) {
        convertedJsonData = users;
        //debugPrint(convertedJsonDataOffic.length.toString());
      });
    } else {
      await fetchData().then((users) {
        convertedJsonData = users;
        //  debugPrint(convertedJsonData.length.toString());
      });
    }
    if (statusValue != null && statusValue != 'Select All') {
      setState(() {
        convertedJsonData1 = convertedJsonData
            .where((element) => element.category
                .toString()
                .toLowerCase()
                .contains(statusValue.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        convertedJsonData1 = convertedJsonData;
      });
    }
  }

  var indexRadio;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 0),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2.0, style: BorderStyle.solid),
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
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  items.officeName.toUpperCase(),
                                  style: dropdownTextDesign,
                                ),
                              ));
                        }).toList()
                      : null,
                  onChanged: (dynamic newValue) {
                    officeid = newValue;
                    setBranch(officeid);
                  })),
          Container(
              margin: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 0),
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
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  items.branchName.toUpperCase(),
                                  style: dropdownTextDesign,
                                ),
                              ));
                        }).toList()
                      : null,
                  onChanged: (dynamic newValue) {
                    setState(() {
                      branchid = newValue;
                    });
                  })),
          DropdownButton(
              //isExpanded: true,
              hint: Text('Category '),
              value: statusValue,
              icon: Icon(Icons.keyboard_arrow_down),
              items: itemStatus.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                    style: dropdownTextDesign,
                  ),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  statusValue = newValue;
                });
              }),
          ElevatedButton(
              onPressed: () {
                filterdate();
              },
              child: Text('SEARCH')),
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
                          itemCount: convertedJsonData1.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => Itempage(
                                            id: convertedJsonData1[index]
                                                .category
                                                .toString(),
                                            branchid: branchid,
                                          )
                                      //Cart(_cartList),
                                      ),
                                );
                              },
                              child: Card(
                                color: Colors.grey[350],
                                elevation: 20,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      convertedJsonData1[index]
                                          .category
                                          .toString(), //+ convertedJsonData[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      convertedJsonData1[index]
                                          .total
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
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
          )
        ],
      ),
    );
  }
}
