import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock/Transfer.dart';
import 'dart:async';

import 'Home.dart';
import 'Model/AllDataModel.dart';
import 'SingleProdScreen.dart';

String tehsilvalue;
String statusValue;
String yearValue;
String companyValue;
List<AllStock> convertedJsonData;
List<AllStock> convertedJsonData1;

// ignore: must_be_immutable
class Itempage extends StatefulWidget {
  String id;
  Itempage({Key key, this.id}) : super(key: key);

  @override
  _ItempageState createState() => _ItempageState();
}

class _ItempageState extends State<Itempage> {
  Future<List<AllStock>> fetchData() async {
    try {
      http.Response response =
          await http.get('http://103.87.24.57/stockapi/stock/${widget.id}');
      if (response.statusCode == 200) {
        // final List<User> user = userFromJson(response.body);
        // return user;
        //debugPrint(response.body);

        return allStockFromJson(response.body);
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
    fetchData().then((users) {
      setState(() {
        convertedJsonData = users;
      });
    });
  }

  void filterdate() {
    if (tehsilvalue != null) {
      convertedJsonData1 = convertedJsonData
          .where((element) => element.tehsil
              .toString()
              .toLowerCase()
              .contains(tehsilvalue.toLowerCase()))
          .toList();
    }
    if (statusValue != null && statusValue != 'Please Select') {
      convertedJsonData1 = convertedJsonData1
          .where((element) => element.status
              .toString()
              .toLowerCase()
              .contains(statusValue.toLowerCase()))
          .toList();
    }
    if (yearValue != null) {
      convertedJsonData1 = convertedJsonData1
          .where((element) => element.dop
              .toString()
              .toLowerCase()
              .contains(yearValue.toLowerCase()))
          .toList();
    }
    if (companyValue != null) {
      convertedJsonData1 = convertedJsonData
          .where((element) => element.make
              .toString()
              .toLowerCase()
              .contains(companyValue.toLowerCase()))
          .toList();
    }
  }

  // var dropdownvalue = 'Please Select ';
  var itemsTehsil = [
    'Please Select ',
    'Thanesar',
    'Ladwa',
    'Shahabad',
    'Babain',
    'Pehowa',
  ];
  var itemStatus = [
    'Select Status ',
    'Working',
    'Not Working',
  ];
  var companyName = [
    'Select Company',
    'Dell ',
    'hp',
    'I-Ball',
    'Apple I-MAC',
    'SAMSUNG',
  ];
  var itemYear = [
    'Please Select  Year ',
    '2001',
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
    '2009',
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of ' + widget.id),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),
                  child: DropdownButton(
                      style: TextStyle(
                          color: Colors.brown,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      isExpanded: true,
                      hint: Text('Please Select Tehsil'),
                      value: tehsilvalue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: itemsTehsil.map((String items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          tehsilvalue = newValue;
                        });
                      }),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),
                  child: DropdownButton(
                      isExpanded: true,
                      hint: Text('Select Status'),
                      value: statusValue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: itemStatus.map((String items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          statusValue = newValue;
                        });
                      }),
                ),
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
                      hint: Text('Please Select  Year'),
                      value: yearValue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: itemYear.map((String items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          yearValue = newValue;
                        });
                      }),
                ),
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
                      hint: Text('Select Company '),
                      value: companyValue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: companyName.map((String items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          companyValue = newValue;
                        });
                      }),
                ),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          filterdate();
                        });
                      },
                      child: Text('SEARCH')),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(

                // shrinkWrap: true,
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
                              propresentlocation: convertedJsonData1[index]
                                  .presentlocation
                                  .toString(),
                              protehsil:
                                  convertedJsonData1[index].tehsil.toString(),
                              prosrno:
                                  convertedJsonData1[index].srno.toString(),
                              proprice:
                                  convertedJsonData1[index].price.toString(),
                              prodealer:
                                  convertedJsonData1[index].dealer.toString(),
                              promodelno:
                                  convertedJsonData1[index].modelno.toString(),
                              promodelid: convertedJsonData1[index].serialno),

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
                        title: Row(
                          children: [
                            Text(
                              'Purchase : ' + convertedJsonData1[index].dop,
                              style: TextStyle(color: Colors.red),
                            ),
                            // Text(convertedJsonData1[index].tehsil.toString()),
                          ],
                        ),
                        leading: Icon(Icons.arrow_back),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TransferProduct(
                                    probranchide: convertedJsonData1[index]
                                        .branchid
                                        .toString(),
                                    promake: convertedJsonData1[index]
                                        .make
                                        .toString(),
                                    proremarks: convertedJsonData1[index]
                                        .remarks
                                        .toString(),
                                    prostatus: convertedJsonData1[index]
                                        .status
                                        .toString(),
                                    procategory: convertedJsonData1[index]
                                        .category
                                        .toString(),
                                    prostockRegister: convertedJsonData1[index]
                                        .stockRegister
                                        .toString(),
                                    prowarrantyPeriod: convertedJsonData1[index]
                                        .warrantyPeriod
                                        .toString(),
                                    protehsil: convertedJsonData1[index]
                                        .tehsil
                                        .toString(),
                                    prosrno: convertedJsonData1[index]
                                        .srno
                                        .toString(),
                                    proprice: convertedJsonData1[index]
                                        .price
                                        .toString(),
                                    prodealer: convertedJsonData1[index]
                                        .dealer
                                        .toString(),
                                    promodelno: convertedJsonData1[index]
                                        .modelno
                                        .toString(),
                                    promodelid:
                                        convertedJsonData1[index].serialno),

                                //Cart(_cartList),
                              ),
                            );
                          },
                          child: Text('TR'),
                        ),
                        // Text(
                        //   '₹' + convertedJsonData1[index].price.toString(),
                        //   style: TextStyle(color: Colors.green),
                        // ),
                        subtitle: Column(
                          children: [
                            // Text(convertedJsonData1[index]
                            //     .warrantyPeriod
                            //     .toString()),
                            Text('S.No: ' + convertedJsonData1[index].serialno),
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
