import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

import 'package:stock/Widgets.dart';

import 'Home.dart';
import 'Model/CategoryModel.dart';

String statusValue;

class CatPage extends StatefulWidget {
  @override
  _ApiMapEx04State createState() => _ApiMapEx04State();
}

class _ApiMapEx04State extends State<CatPage> {
  List<StockCat> convertedJsonData;
  List<StockCat> convertedJsonData1;

  Future<List<StockCat>> fetchData() async {
    try {
      http.Response response =
          await http.get('http://103.87.24.57/stockapi/catwise');
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

  @override
  void initState() {
    super.initState();
    fetchData().then((users) {
      setState(() {
        convertedJsonData = users;
        //  debugPrint(convertedJsonData.length.toString());
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

  var indexRadio;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
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
          indexRadio == statusValue
              ? Expanded(
                  child: FutureBuilder(
                      future: fetchData(),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        return snapshot.hasData
                            ? GridView.builder(
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),

                                // current the spelling of length here
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Itempage(
                                                id: convertedJsonData[index]
                                                    .category
                                                    .toString())
                                            //Cart(_cartList),
                                            ),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.grey[350],
                                      elevation: 20,
                                      child: Center(
                                        child: Stack(
                                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              convertedJsonData[index]
                                                  .category
                                                  .toString(), //+ convertedJsonData[index],
                                              style: TextStyle(
                                                color: Colors.brown,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Text(
                                                convertedJsonData[index]
                                                    .total
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.brown,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
              : GridView.builder(
                  shrinkWrap: true,
                  itemCount: convertedJsonData1 == null
                      ? 0
                      : convertedJsonData1.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 10,
                    crossAxisCount: 1,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // if (convertedJsonData1 == null) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Itempage(
                                  id: convertedJsonData1[index]
                                      .category
                                      .toString())
                              //Cart(_cartList),
                              ),
                        );
                      },
                      child: ListTile(
                        leading:
                            Icon(Icons.code, size: 30, color: Colors.brown),
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
                )
        ],
      ),
    );
  }
}
