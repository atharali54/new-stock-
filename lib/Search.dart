import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

import 'package:stock/Widgets.dart';

import 'Model/CategoryModel.dart';

String statusValue;

class SearchScreen extends StatefulWidget {
  @override
  _ApiMapEx04State createState() => _ApiMapEx04State();
}

class _ApiMapEx04State extends State<SearchScreen> {
  List<dynamic> mapResponse;
  List listResponse;

  List<StockCat> convertedJsonData;
  List<StockCat> convertedJsonData1;

  Future<List<StockCat>> fetchData() async {
    try {
      http.Response response =
          await http.get('http://103.87.24.57/stockapi/catwise');
      if (response.statusCode == 200) {
        // final List<User> user = userFromJson(response.body);
        // return user;

        return stockCatFromJson(response.body);
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
        debugPrint(convertedJsonData.length.toString());
      });
    });
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
    'USB HUB' 'Wall Fan',
    'Web Cam',
  ];
  void filterdate() {
    if (statusValue != null && statusValue != 'Select All') {
      convertedJsonData1 = convertedJsonData
          .where((element) => element.category
              .toString()
              .toLowerCase()
              .contains(statusValue.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search '),
      ),
      body: Column(
        children: [
          DropdownButton(
              //isExpanded: true,
              hint: Text('Category '),
              value: statusValue,
              icon: Icon(Icons.keyboard_arrow_down),
              items: itemStatus.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  statusValue = newValue;
                });
              }),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  filterdate();
                });
              },
              child: Text('SEARCH')),
          GridView.builder(
            shrinkWrap: true,
            itemCount:
                convertedJsonData1 == null ? 0 : convertedJsonData1.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 10,
              crossAxisCount: 1,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => Itempage(
                            id: convertedJsonData1[index].category.toString())
                        //Cart(_cartList),
                        ),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.code, size: 30, color: Colors.brown),
                  trailing: Text(
                    convertedJsonData1[index]
                        .total
                        .toString(), //+ convertedJsonData[index],
                    style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  title: Text(
                    convertedJsonData1[index]
                        .category
                        .toString(), //+ convertedJsonData[index],
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      //----------------
    );
  }
}
