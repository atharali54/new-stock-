import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock/Model/BranchmasModel.dart';
import 'CatPage.dart';
import 'Model/OfficemasModel.dart';

String officeid;
int branchid;

Future postUsers(String id, Album users) async {
  Map<String, String> header = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  var myUsers = users.toJson();
  var usersBody = json.encode(myUsers);
  var res = await http.put(
      Uri.parse('http://103.87.24.57/stockapi/transfer/${id}'),
      headers: header,
      body: usersBody);
  print(res.statusCode);
  return res.statusCode;
}

class Album {
  final String selectBranch;
  //final String selectOffice;
  final String issuedto;
  final String mobile;
  final String remarks;

  Album(
      {this.selectBranch,
      //this.selectOffice,
      this.issuedto,
      this.mobile,
      this.remarks});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      selectBranch: json['branchid'],
      //selectOffice: json['selectOffice'],
      issuedto: json['issuedto'],
      mobile: json['mobile'],
      remarks: json['remarks'],
    );
  }
  Map<String, dynamic> toJson() => _$UsersToJson(this);

  Map<String, dynamic> _$UsersToJson(Album instance) => <String, dynamic>{
        'branchid': instance.selectBranch,
        // 'selectOffice': instance.selectOffice,
        'Issuedto': instance.issuedto,
        'mobile': instance.mobile,
        'remarks': instance.remarks,
      };
}

// ignore: must_be_immutable
class TransferProduct extends StatefulWidget {
  
  String srno;
  String office;
  String branchid;
  String issued;
  String mobile;
  String remarks;
  String procategory;
  String proOffice;

  // String prodealer;
  TransferProduct(
      {Key key,
      this.srno,
      this.office,
      this.branchid,
      this.issued,
      this.mobile,
      this.procategory,
      this.proOffice,
      this.remarks})
      : super(key: key);

  @override
  State<TransferProduct> createState() => _TransferProductState();
}

class _TransferProductState extends State<TransferProduct> {
  TextEditingController mybranchid = TextEditingController();
  //TextEditingController myid = TextEditingController();
  TextEditingController myissuedto = TextEditingController();
  TextEditingController mymobile = TextEditingController();
  TextEditingController myremarks = TextEditingController();

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

  Future<void> setBranch(String id) async {
    branchid = null;
    var d = await fetchBranchMas(id);
    setState(() {});
  }

  void initState() {
    super.initState();
    fetchOfficeData().then((users) {
      setState(() {
        convertedJsonDataOffic = users;
        myissuedto.text = widget.issued;
        mymobile.text = widget.mobile;
        officeid = convertedJsonDataOffic
            .where((element) => element.officeName == widget.office)
            .first
            .officeid
            .toString();
        setBranch(officeid);
        branchid = int.parse(widget.branchid);
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
          children: <Widget>[
            // Container(
            //   child: Image.asset(
            //     'assets/homeBg.jpg',
            //     fit: BoxFit.cover,
            //     height: 200,
            //     width: double.infinity,
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(left: 14, right: 14),
              child: DropdownButton(
                  isExpanded: true,
                  hint: Text('Select Office '),
                  value: officeid,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: convertedJsonDataOffic != null
                      ? convertedJsonDataOffic.map((OfficeMas items) {
                          return DropdownMenuItem(
                              value: items.officeid.toString(),
                              child: Text(
                                items.officeName,
                                style: dropdownTextDesign,
                              ));
                        }).toList()
                      : null,
                  onChanged: (dynamic newValue) {
                    officeid = newValue;
                    setBranch(officeid);
                  }),
            ),
            Container(
              margin: EdgeInsets.only(left: 14, right: 14),
              child: DropdownButton(
                  hint: Text('Select Branch '),
                  value: branchid,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: convertedJsonBranch != null
                      ? convertedJsonBranch.map((BranchMas items) {
                          return DropdownMenuItem(
                              value: items.branchid,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  items.branchName,
                                  style: dropdownTextDesign,
                                ),
                              ));
                        }).toList()
                      : null,
                  onChanged: (dynamic newValue) {
                    setState(() {
                      branchid = newValue;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: myissuedto,
                decoration: InputDecoration(
                  labelText: 'Enter Name',
                  hintText: 'Issued to',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Color(0xffF02E65)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                  ),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: mymobile,
                decoration: InputDecoration(
                  labelText: 'Enter Mobile',
                  hintText: '+91',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Color(0xffF02E65)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                  ),
                  prefixIcon: const Icon(
                    Icons.call,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: myremarks,
                decoration: InputDecoration(
                  labelText: 'Enter Remarks',
                  hintText: 'Remarks..',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Color(0xffF02E65)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                  ),
                  prefixIcon: const Icon(
                    Icons.comment,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Update Data'),
              onPressed: () async {
                Album user = new Album(
                  mobile: mymobile.text,
                  issuedto: myissuedto.text,
                  remarks: myremarks.text,
                  selectBranch: branchid.toString(),
                );

                //setState(() async {
                var res = await postUsers(widget.srno, user).whenComplete(() {
                  showDialog(
                    context: context,
                    useRootNavigator: false,
                    builder: (ctx) => AlertDialog(
                      title: Text("Alert"),
                      content: Text("Record Updated Successfully"),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                });
                //print(res.toString());
                // });
              },
            ),
          ],
        )),
      ),
    );
  }
}
