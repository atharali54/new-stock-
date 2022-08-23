import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:stock/Model/AllDataModel.dart';

import 'dart:async';

import 'SingleProdScreen.dart';
import 'Transfer.dart';

String statusValue;

class SearchScreen extends StatefulWidget {
  String utype;
  String Mob;
  SearchScreen({
    Key key,
    this.utype,
    this.Mob,
  }) : super(key: key);

  @override
  _ApiMapEx04State createState() => _ApiMapEx04State();
}

class _ApiMapEx04State extends State<SearchScreen> {
  List<dynamic> mapResponse;
  List listResponse;
  String _scanBarcode = 'Unknown';

  List<AllStock> convertedJsonData;
  List<AllStock> convertedJsonData1;
  TextEditingController textEditingController = new TextEditingController();

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

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
//barcode scanner flutter ant
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      textEditingController.text = barcodeScanRes;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData().then((users) {
      setState(() {
        convertedJsonData = users;
      });
    });

    textEditingController.text = widget.Mob;
    print(widget.utype);
  }

  void filterdate() {
    if (textEditingController.text != null &&
        textEditingController.text.trim().length != 0) {
      convertedJsonData1 = convertedJsonData
          .where((element) => (element.serialno.toString() +
                  element.issuedto.toString() +
                  element.mobile.toString())
              .toLowerCase()
              .contains((textEditingController.text.toLowerCase())))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search by Name/Mobile/Serial No'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              enabled: widget.utype == "U" ? false : true,
              controller: textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Sr/Name/Mobile',
                hintText: 'Sr/Name/Mobile',
                suffixIcon: IconButton(
                  onPressed: () {
                    scanBarcodeNormal();
                  },
                  icon: Icon(Icons.remove_red_eye_outlined),
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  filterdate();
                });
              },
              child: Text('SEARCH')),
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
                              proprice:
                                  convertedJsonData1[index].price.toString(),
                              prodealer:
                                  convertedJsonData1[index].dealer.toString(),
                              promodelno:
                                  convertedJsonData1[index].modelno.toString(),
                              prodevicesrno:
                                  convertedJsonData1[index].serialno.toString(),
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
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              size: 34,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                        trailing: widget.utype == "A"
                            ? ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TransferProduct(
                                        srno: convertedJsonData1[index]
                                            .srno
                                            .toString(),
                                        office: convertedJsonData1[index]
                                            .office
                                            .toString(),
                                        branchid: convertedJsonData1[index]
                                            .branchid
                                            .toString(),
                                        issued: convertedJsonData1[index]
                                            .issuedto
                                            .toString(),
                                        mobile: convertedJsonData1[index]
                                            .mobile
                                            .toString(),
                                      ),

                                      //Cart(_cartList),
                                    ),
                                  );
                                },
                                child: Text('TR'),
                              )
                            : null,
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
                            Text(convertedJsonData1[index].category,
                                style: TextStyle(color: Colors.green)),
                            Text(
                              'Office: ' +
                                  convertedJsonData1[index].office +
                                  ' -> ' +
                                  convertedJsonData1[index].branch,
                            ),
                            Text('S.No: ' + convertedJsonData1[index].serialno),
                            Text('Issued: ' +
                                convertedJsonData1[index].issuedto.toString()),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
      //----------------
    );
  }
}
