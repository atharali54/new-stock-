

// Get DATA USING DROPDOWN IN API

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:stock/Model/BranchmasModel.dart';

// import 'dart:async';

// import 'package:stock/Widgets.dart';

// import 'Home.dart';
// import 'Model/CategoryModel.dart';
// import 'Model/OfficemasModel.dart';

// String officeid;
// String branchid;

// class OfficeBranchApiData extends StatefulWidget {
//   @override
//   _ApiMapEx04State createState() => _ApiMapEx04State();
// }

// class _ApiMapEx04State extends State<OfficeBranchApiData> {
//   // List<dynamic> mapResponse;
//   // List listResponse;

//   List<OfficeMas> convertedJsonDataOffic;
//   List<BranchMas> convertedJsonBranch;

//   Future<List<OfficeMas>> fetchOfficeData() async {
//     try {
//       http.Response response =
//           await http.get('http://103.87.24.57/stockapi/officemas');
//       if (response.statusCode == 200) {
//         convertedJsonDataOffic = officeMasFromJson(response.body);
//         return convertedJsonDataOffic;
//       } else {
//         return throw Exception('Failed to load ...');
//       }
//     } catch (e) {
//       return throw Exception('Failed to load ...');
//     }
//   }

//   Future<List<BranchMas>> fetchBranchMas(String officeid) async {
//     try {
//       http.Response response = await http
//           .get('http://103.87.24.57/stockapi/branchmas/' + officeid.toString());
//       if (response.statusCode == 200) {
//         convertedJsonBranch = branchMasFromJson(response.body);
//         return convertedJsonBranch;
//       } else {
//         return throw Exception('Failed to load ...');
//       }
//     } catch (e) {
//       return throw Exception('Failed to load ...');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchOfficeData().then((users) {
//       setState(() {
//         convertedJsonDataOffic = users;
//         //debugPrint(convertedJsonDataOffic.length.toString());
//       });
//     });
//   }

//   //var indexRadio;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Get Office/Branch'),
//       ),
//       body: Column(
//         children: [
//           Text('data')
//           // DropdownButton(
//           //     hint: Text('Select Office '),
//           //     value: officeid,
//           //     icon: Icon(Icons.keyboard_arrow_down),
//           //     items: convertedJsonDataOffic.map((OfficeMas items) {
//           //       return DropdownMenuItem(
//           //           value: items.officeid.toString(),
//           //           child: Text(items.officeName));
//           //     }).toList(),
//           //     onChanged: (dynamic newValue) {
//           //       setState(() {
//           //         officeid = newValue;
//           //         fetchBranchMas(officeid);
//           //       });
//           //     }),
//           // DropdownButton(
//           //     hint: Text('Select Branch '),
//           //     value: branchid,
//           //     icon: Icon(Icons.keyboard_arrow_down),
//           //     items: convertedJsonBranch != null
//           //         ? convertedJsonBranch.map((BranchMas items) {
//           //             return DropdownMenuItem(
//           //                 value: items.branchid, child: Text(items.branchName));
//           //           }).toList()
//           //         : null,
//           //     onChanged: (dynamic newValue) {
//           //       setState(() {
//           //         branchid = newValue;
//           //       });
//           //     }),
//           Expanded(
//             child: FutureBuilder(
//                 future: fetchOfficeData(),
//                 builder: (context, AsyncSnapshot<dynamic> snapshot) {
//                   return snapshot.hasData
//                       ? GridView.builder(
//                           gridDelegate:
//                               new SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 3),

//                           // current the spelling of length here
//                           itemCount: snapshot.data.length,
//                           itemBuilder: (context, index) {
//                             return Card(
//                               color: Colors.grey[350],
//                               elevation: 10,
//                               child: Center(
//                                 child: Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Text(
//                                       convertedJsonDataOffic[index]
//                                           .officeid
//                                           .toString(), //+ convertedJsonDataOffic[index],
//                                       style: TextStyle(
//                                         color: Colors.brown,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                     Text(
//                                       convertedJsonDataOffic[index]
//                                           .officeName
//                                           .toString(), //+ convertedJsonDataOffic[index],
//                                       style: TextStyle(
//                                         color: Colors.brown,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         )
//                       : Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Please wait.......',
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 38.0),
//                               child: Center(
//                                   child: const CircularProgressIndicator(
//                                 backgroundColor: Colors.brown,
//                                 valueColor:
//                                     AlwaysStoppedAnimation(Colors.green),
//                                 strokeWidth: 5,
//                               )),
//                             ),
//                           ],
//                         );
//                 }),
//           )
//         ],
//       ),
//     );
//   }
// }
