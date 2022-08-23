import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'Model/AllDataModel.dart';
import 'SingleProdScreen.dart';
import 'Transfer.dart';

List<AllStock> initialData;
Color dd = Color(0xFFFF9700);

class Namewise extends StatefulWidget {
  @override
  _ApiMapEx04State createState() => _ApiMapEx04State();
}

class _ApiMapEx04State extends State<Namewise> {
  List<AllStock> convertedJsonData; //baad m 1
  List<AllStock> convertedJsonDataFull;
  String dropdownValue;
  List<AllStock> filteredData;

  Future<List<AllStock>> fetchData() async {
    try {
      http.Response response =
          await http.get('http://103.87.24.57/stockapi/stock');
      if (response.statusCode == 200) {
        var student = allStockFromJson(response.body);

        convertedJsonDataFull = student; //baad m 2

        // Uniqe data showing in dropdown (values not repeat  in dropdown)
        //refrence: https://www.fluttercampus.com/guide/175/how-to-unique-list-of-objects-by-property-value-in-dart-flutter/
        var seenData = Set<String>();
        List<AllStock> uniquelist =
            student.where((e) => seenData.add(e.issuedto)).toList();
        convertedJsonData = uniquelist;
        //
        return convertedJsonData;
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
    fetchData().then((users) {
      setState(() {
        convertedJsonData = users;
      });
    });
  }

  // var mycount;
  Future<void> filterdate(String value) async {
    filteredData = convertedJsonDataFull
        .where((element) => element.issuedto == value)
        .toList();
  }

  var indexRadio;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search by Name',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
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
                hint: Text(
                  'Select Name',
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                value: dropdownValue,
                icon: Icon(Icons.keyboard_arrow_down),
                items: convertedJsonData != null
                    ? convertedJsonData.map((items) {
                        return DropdownMenuItem(
                            value: items.issuedto.toString(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                items.issuedto.toString().toUpperCase(),
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold),
                              ),
                            ));
                      }).toList()
                    : null,
                onChanged: (dynamic newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    filterdate(dropdownValue);
                  });
                }),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     'Total Record: ' + filteredData.length.toString(),
          //     style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.green),
          //   ),
          // ),
          //  if (filteredData == null) Text(filteredData.length.toString()),

          // ElevatedButton(
          //     onPressed: () {
          //       filterdate();
          //     },
          //     child: Text('SEARCH')),
          //  Text(dropdownValue.toString()),
          filteredData == null
              ? Center(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      'Data not Select',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ))
              : Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Total: ' + filteredData.length.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: dd),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                filteredData == null ? 0 : filteredData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MySingleProduct(
                                          probranchid: filteredData[index]
                                              .branchid
                                              .toString(),
                                          prooffice: filteredData[index]
                                              .office
                                              .toString(),
                                          probranch: filteredData[index]
                                              .branch
                                              .toString(),
                                          probissue: filteredData[index]
                                              .issuedto
                                              .toString(),
                                          probmobile: filteredData[index]
                                              .mobile
                                              .toString(),
                                          promake: filteredData[index]
                                              .make
                                              .toString(),
                                          proremarks: filteredData[index]
                                              .remarks
                                              .toString(),
                                          prostatus: filteredData[index]
                                              .status
                                              .toString(),
                                          procategory: filteredData[index]
                                              .category
                                              .toString(),
                                          prostockRegister: filteredData[index]
                                              .stockRegister
                                              .toString(),
                                          prowarrantyPeriod: filteredData[index]
                                              .warrantyPeriod
                                              .toString(),
                                          protehsil: filteredData[index]
                                              .tehsil
                                              .toString(),
                                          prosrno: filteredData[index]
                                              .srno
                                              .toString(),
                                          proprice: filteredData[index]
                                              .price
                                              .toString(),
                                          prodealer: filteredData[index]
                                              .dealer
                                              .toString(),
                                          promodelno: filteredData[index]
                                              .modelno
                                              .toString(),
                                          prodevicesrno: filteredData[index]
                                              .serialno
                                              .toString(),
                                          promodelid: filteredData[index]
                                              .project
                                              .toString()),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    selected: true,
                                    selectedTileColor: Colors.grey[300],
                                    title: Text(
                                      filteredData[index].make +
                                          " " +
                                          filteredData[index].modelno,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    leading: Icon(Icons.arrow_back),
                                    trailing: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TransferProduct(
                                              procategory:
                                                  filteredData[index].category,
                                              srno: filteredData[index]
                                                  .srno
                                                  .toString(),
                                              office: filteredData[index]
                                                  .office
                                                  .toString(),
                                              branchid: filteredData[index]
                                                  .branchid
                                                  .toString(),
                                              issued: filteredData[index]
                                                  .issuedto
                                                  .toString(),
                                              mobile: filteredData[index]
                                                  .mobile
                                                  .toString(),
                                            ),

                                            //Cart(_cartList),
                                          ),
                                        );
                                      },
                                      child: Text('Transfer'),
                                    ),
                                    // Text(
                                    //   '₹' + convertedJsonData1[index].price.toString(),
                                    //   style: TextStyle(color: Colors.green),
                                    // ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(convertedJsonData1[index]
                                        //     .warrantyPeriod

                                        //  Text('S.No: ' +
                                        //     filteredData[index].presentlocation),
                                        //     .toString()),
                                        Text(filteredData[index].category,
                                            style:
                                                TextStyle(color: Colors.green)),
                                        Text(
                                          'Office: ' +
                                              filteredData[index].office +
                                              ', Branch: ' +
                                              filteredData[index].branch,
                                        ),
                                        Text('S.No: ' +
                                            filteredData[index].serialno),
                                        Text('Issued: ' +
                                            filteredData[index]
                                                .issuedto
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
