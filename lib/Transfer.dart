import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock/Model/BranchmasModel.dart';
import 'Model/OfficemasModel.dart';

String officeid;
int branchid;

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
  final String selectBranch;
  //final String selectOffice;
  final String issuedto;
  final String mobile;

  Album(
      {this.selectBranch,
      //this.selectOffice,
      this.issuedto,
      this.mobile});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      selectBranch: json['branchid'],
      //selectOffice: json['selectOffice'],
      issuedto: json['issuedto'],
      mobile: json['mobile'],
    );
  }
  Map<String, dynamic> toJson() => _$UsersToJson(this);

  Map<String, dynamic> _$UsersToJson(Album instance) => <String, dynamic>{
        'branchid': instance.selectBranch,
        // 'selectOffice': instance.selectOffice,
        'Issuedto': instance.issuedto,
        'mobile': instance.mobile,
      };
}

// ignore: must_be_immutable
class TransferProduct extends StatefulWidget {
  String srno;
  String office;
  String branchid;
  String issued;
  String mobile;

  // String prodealer;
  TransferProduct({
    Key key,
    this.srno,
    this.office,
    this.branchid,
    this.issued,
    this.mobile,
  }) : super(key: key);

  @override
  State<TransferProduct> createState() => _TransferProductState();
}

class _TransferProductState extends State<TransferProduct> {
  TextEditingController mybranchid = TextEditingController();
  //TextEditingController myid = TextEditingController();
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

  Future<void> setBranch(String id) async {
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
            Container(
              child: Image.asset(
                'assets/homeBg.jpg',
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            DropdownButton(
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: mymobile,
                decoration: InputDecoration(
                  hintText: 'Enter Mobile Number ...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Update Data'),
              onPressed: () async {
                Album user = new Album(
                  mobile: mymobile.text,
                  issuedto: myissuedto.text,
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
