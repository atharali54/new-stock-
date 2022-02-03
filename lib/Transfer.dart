import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock/Model/BranchmasModel.dart';
import 'Model/OfficemasModel.dart';

String officeid;
String branchid;

Future postUsers(String id, Album users) async {
  Map<String, String> header = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  var myUsers = users.toJson();
  var usersBody = json.encode(myUsers);
  var res = await http.put('http://103.87.24.57/stockapi/transfer/${id}',
      headers: header, body: usersBody);
  print(res.statusCode);
  return res.statusCode;
}

class Album {
  //final String project;
  final String branchid;
  final String issuedto;
  final String mobile;
  final String id;

  Album(
      {
//this.project,
      this.branchid,
      this.issuedto,
      this.id,
      this.mobile});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      // project: json['project'],
      branchid: json['branchid'],
      issuedto: json['issuedto'],
      mobile: json['mobile'],
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() => _$UsersToJson(this);

  Map<String, dynamic> _$UsersToJson(Album instance) => <String, dynamic>{
        // 'Project': instance.project,
        'Presentlocation': instance.branchid,
        'Issuedto': instance.issuedto,
        'mobile': instance.mobile,
        'id': instance.id,
      };
}

// ignore: must_be_immutable
class TransferProduct extends StatefulWidget {
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
  TransferProduct(
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
  State<TransferProduct> createState() => _TransferProductState();
}

class _TransferProductState extends State<TransferProduct> {
  TextEditingController mybranchid = TextEditingController();
  TextEditingController myid = TextEditingController();
  TextEditingController myissuedto = TextEditingController();
  TextEditingController mymobile = TextEditingController();

  Future<Album> _futureAlbum;

  List<String> _locations = [
    'DC branchide',
    'SDM branchide Ladwa',
    'SDM branchide Thanesar',
    'SDM branchide Pehowa',
    'SDM branchide Shahabad',
    'Tehsil Ladwa',
    'Tehsil Thanesar',
    'Tehsil Pehowa',
    'Tehsil Shahabad',
    'Saral Kendra Thanesar',
    'Antyodaya'
  ]; // Option 2
  //String _selectedLocation; // Option 2

  @override
  // void initState() {
  //   super.initState();
  //   //_futureAlbum = fetchAlbum();
  // }
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

  void initState() {
    super.initState();
    fetchOfficeData().then((users) {
      setState(() {
        convertedJsonDataOffic = users;
        //debugPrint(convertedJsonDataOffic.length.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/homeBg.jpg',
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Row(
              children: [
                Text(
                  'Serial Number:',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  widget.prosrno,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'branchid Name:',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  widget.probranchide,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
            DropdownButton(
                hint: Text('Select Office '),
                value: officeid,
                icon: Icon(Icons.keyboard_arrow_down),
                items: convertedJsonDataOffic.map((OfficeMas items) {
                  return DropdownMenuItem(
                      value: items.officeid.toString(),
                      child: Text(items.officeName));
                }).toList(),
                onChanged: (dynamic newValue) {
                  setState(() {
                    officeid = newValue;
                    fetchBranchMas(officeid);
                  });
                }),
            DropdownButton(
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
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: myissuedto,
                decoration: InputDecoration(
                  hintText: 'Issued To (Name)',
                  border: OutlineInputBorder(),
                  // hintStyle: TextStyle(
                  //   color: Colors.orange,
                  //   fontWeight: FontWeight.bold,
                  // ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: mymobile,
                decoration: InputDecoration(
                  hintText: 'Enter Mobile Number ...',
                  // hintStyle: TextStyle(
                  //   color: Colors.orange,
                  //   fontWeight: FontWeight.bold,
                  // ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: myid,
                decoration: InputDecoration(
                  hintText: 'Enter id ...',
                  // hintStyle: TextStyle(
                  //   color: Colors.orange,
                  //   fontWeight: FontWeight.bold,
                  // ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: DropdownButton(
            //     icon: Icon(Icons.arrow_downward),
            //     iconSize: 24,
            //     elevation: 16,
            //     isExpanded: true,
            //     hint: Text(
            //         'Please choose a location'), // Not necessary for Option 1
            //     value: _selectedLocation,
            //     onChanged: (newValue) {
            //       setState(() {
            //         _selectedLocation = newValue;
            //       });
            //     },
            //     items: _locations.map((location) {
            //       return DropdownMenuItem(
            //         // child: new Text(location),
            //         child: new Text(location),
            //         value: location,
            //       );
            //     }).toList(),
            //   ),
            // ),

            //     TextField(
            // decoration: InputDecoration(
            //   icon: Icon(Icons.send),
            //   hintText: 'Hint Text',
            //   helperText: 'Helper Text',
            //   counterText: '0 characters',
            //   border: OutlineInputBorder(),
            //     )),
            ElevatedButton(
              child: Text('Update Data'),
              onPressed: () async {
                Album user = new Album(
                  mobile: mymobile.text,
                  issuedto: myissuedto.text,
                  id: myid.text,
                  branchid: branchid,
                );

                //setState(() async {
                var res =
                    await postUsers(widget.prosrno, user).whenComplete(() {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Alert"),
                      content: Text("Record Updated Successfully"),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                });
                print(res.toString());
                // });
              },
            ),
          ],
        )),
      ),
    );
  }
}
