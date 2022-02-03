import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:stock/Home.dart';

class ItemEntries extends StatefulWidget {
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<ItemEntries> {
  // final name = TextEditingController();
  // final phoneNumber = TextEditingController();
  // final studentClass = TextEditingController();

  final prodName = TextEditingController();
  final prodId = TextEditingController();
  final rfNo = TextEditingController();
  final warrentyPeriod = TextEditingController();
  final amcPeriod = TextEditingController();
  final purFrom = TextEditingController();
  final price = TextEditingController();
  final epcification = TextEditingController();

  getItemAndNavigate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SecondScreen(
                // nameHolder: name.text,
                // classHolder: studentClass.text,
                // numberHolder: phoneNumber.text
                prodName: prodName.text,
                prodId: prodId.text,
                rfNo: rfNo.text,
                warrentyPeriod: warrentyPeriod.text,
                amcPeriod: amcPeriod.text,
                purFrom: purFrom.text,
                price: price.text,
                epcification: epcification.text)));
  }

  //final hintFont = TextStyle(fontSize: 14);
  String dropdownvalue = 'Select Category';
  var itemsCat = [
    'Select Category',
    'Laptop',
    'Printer',
    'Mouse',
    'Keyboard',
    'Scanner',
    'LED'
  ];
  String dropdownvalue2 = 'Stock Register';
  var stockReg = [
    'Stock Register',
    'Consumable',
    'Non Consumable',
    'Both',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            //  mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(4),
                  color: Colors.brown,
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    'Enter Stock',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
              Container(
                width: 420,
                padding: EdgeInsets.all(2),
                // height: 30,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        child: Text(' Category:'),
                        padding: EdgeInsets.only(right: 5),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      decoration: new BoxDecoration(),
                      height: 60,
                      child: DropdownButton(
                        value: dropdownvalue,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.brown,
                        ),
                        items: itemsCat.map((String items) {
                          return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(fontSize: 14),
                              ));
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownvalue = newValue;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      decoration: new BoxDecoration(
                          // borderRadius: BorderRadius.circular(20.0),
                          // color: Colors.brown[100],
                          // boxShadow: [
                          //   BoxShadow(
                          //     blurRadius: 10,
                          //     color: Colors.black26,
                          //   )
                          // ],
                          ),

                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(2.0),
                      //   border: Border.all(
                      //     color: Colors.red,
                      //     style: BorderStyle.solid,
                      //   ),
                      // ),
                      child: DropdownButton(
                        value: dropdownvalue2,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.brown,
                        ),
                        items: stockReg.map((String items) {
                          return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(fontSize: 14),
                              ));
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownvalue2 = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 420,
                padding: EdgeInsets.all(2),
                height: 30,
                child: Row(
                  children: [
                    Padding(
                      child: Text('Product Name:'),
                      padding: EdgeInsets.only(right: 5),
                    ),
                    Expanded(
                      child: TextField(
                        controller: prodName,
                        autocorrect: true,
                        decoration: InputDecoration(
                            //hintText: 'Product Name',
                            //hintStyle: hintFont,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4))),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 420,
                padding: EdgeInsets.all(2),
                height: 30,
                child: Row(
                  children: [
                    Padding(
                      child: Text('Ref. No. in Stock Register:'),
                      padding: EdgeInsets.only(right: 5),
                    ),
                    Expanded(
                        child: TextField(
                      controller: rfNo,
                      autocorrect: true,
                      decoration: InputDecoration(
                          //hintText: 'Product Name',
                          // hintStyle: hintFont,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4))),
                    )),
                  ],
                ),
              ),
              Container(
                width: 420,
                padding: EdgeInsets.all(2),
                height: 30,
                child: Row(
                  children: [
                    Padding(
                      child: Text('Product id:'),
                      padding: EdgeInsets.only(right: 5),
                    ),
                    Expanded(
                        child: TextField(
                      controller: prodId,
                      autocorrect: true,
                      decoration: InputDecoration(
                          //hintText: 'Product Name',
                          // hintStyle: hintFont,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4))),
                    )),
                  ],
                ),
              ),
              Container(
                width: 420,
                padding: EdgeInsets.all(2),
                height: 30,
                child: Row(
                  children: [
                    Padding(
                      child: Text('Date of Purchase :'),
                      padding: EdgeInsets.only(right: 5),
                    ),
                    Expanded(
                      child: DateTimePicker(
                        initialValue: '',
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        //dateHintText: 'Select Date', style: TextStyle(fontSize: 10),
                        // dateLabelText: 'Date',
                        onChanged: (val) => print(val),
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) => print(val),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 420,
                padding: EdgeInsets.all(2),
                height: 30,
                child: Row(
                  children: [
                    Padding(
                      child: Text('Warranty Period:'),
                      padding: EdgeInsets.only(right: 5),
                    ),
                    Expanded(
                        child: TextField(
                      controller: warrentyPeriod,
                      autocorrect: true,
                      decoration: InputDecoration(
                          //hintText: 'Product Name',
                          // hintStyle: hintFont,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4))),
                    )),
                  ],
                ),
              ),
              Container(
                width: 420,
                padding: EdgeInsets.all(2),
                height: 30,
                child: Row(
                  children: [
                    Padding(
                      child: Text('Purchased From:'),
                      padding: EdgeInsets.only(right: 5),
                    ),
                    Expanded(
                        child: TextField(
                      controller: purFrom,
                      autocorrect: true,
                      decoration: InputDecoration(
                          //hintText: 'Product Name',
                          // hintStyle: hintFont,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4))),
                    )),
                  ],
                ),
              ),
              Container(
                width: 420,
                padding: EdgeInsets.all(2),
                height: 30,
                child: Row(
                  children: [
                    Padding(
                      child: Text('AMC Period:'),
                      padding: EdgeInsets.only(right: 5),
                    ),
                    Expanded(
                        child: TextField(
                      controller: amcPeriod,
                      autocorrect: true,
                      decoration: InputDecoration(
                          //hintText: 'Product Name',
                          // hintStyle: hintFont,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4))),
                    )),
                  ],
                ),
              ),
              Container(
                width: 420,
                padding: EdgeInsets.all(2),
                height: 30,
                child: Row(
                  children: [
                    Padding(
                      child: Text('Price:'),
                      padding: EdgeInsets.only(right: 5),
                    ),
                    Expanded(
                        child: TextField(
                      controller: price,
                      autocorrect: true,
                      decoration: InputDecoration(
                          //hintText: 'Product Name',
                          // hintStyle: hintFont,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4))),
                    )),
                  ],
                ),
              ),
              Container(
                width: 420,
                padding: EdgeInsets.all(2),
                height: 30,
                child: Row(
                  children: [
                    Padding(
                      child: Text('Price:'),
                      padding: EdgeInsets.only(right: 5),
                    ),
                    Expanded(
                        child: TextField(
                      controller: epcification,
                      autocorrect: true,
                      decoration: InputDecoration(
                          //hintText: 'Product Name',
                          // hintStyle: hintFont,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4))),
                    )),
                  ],
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () => getItemAndNavigate(context),
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ));
  }
}

class SecondScreen extends StatelessWidget {
  // final nameHolder;
  // final classHolder;
  // final numberHolder;

  final prodName;
  final prodId;
  final rfNo;
  final warrentyPeriod;
  final amcPeriod;
  final purFrom;
  final price;
  final epcification;

  SecondScreen(
      {
      //   @required this.nameHolder,
      // this.classHolder,
      // this.numberHolder,
      this.amcPeriod,
      this.epcification,
      this.price,
      this.prodId,
      this.prodName,
      this.purFrom,
      this.rfNo,
      this.warrentyPeriod});

  goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Text(
                'Product Name = ' + prodName,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              )),
              Center(
                  child: Text(
                'Product id = ' + prodId,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              )),
              Center(
                  child: Text(
                'rfNo = ' + rfNo,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              )),

              Center(
                  child: Text(
                'Warrenty Period = ' + warrentyPeriod,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              )),
              Center(
                  child: Text(
                'AMC Period = ' + amcPeriod,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              )),

              Center(
                  child: Text(
                'Product id = ' + purFrom,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              )),
              Center(
                  child: Text(
                'Product id = ' + price,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              )),

              Center(
                  child: Text(
                'Product id = ' + epcification,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              )),
              // Center(
              //     child: Text(
              //   'Student Phone Number = ' + numberHolder,
              //   style: TextStyle(fontSize: 22),
              //   textAlign: TextAlign.center,
              // )),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text(''),
              )
            ]));
  }
}
