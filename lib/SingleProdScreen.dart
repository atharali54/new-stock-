import 'package:flutter/material.dart';

import 'Home.dart';

// ignore: must_be_immutable
class MySingleProduct extends StatefulWidget {
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
  String probranchid;
  String prowarrantyPeriod;
  String prodealer;
  String propresentlocation;

  MySingleProduct(
      {Key key,
      this.promake,
      this.promodelid,
      this.procategory,
      this.proprice,
      this.prodealer,
      this.promodelno,
      this.probranchid,
      this.proremarks,
      this.prosrno,
      this.prostatus,
      this.prostockRegister,
      this.protehsil,
      this.propresentlocation,
      this.prowarrantyPeriod})
      : super(key: key);

  @override
  State<MySingleProduct> createState() => _MySingleProductState();
}

class _MySingleProductState extends State<MySingleProduct> {
  String _chosenValue; //dropdown tranefer
  String _chosenValue2; //dropdown tranefer
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.procategory),
      ),
      body: Column(
        children: [
          Container(
            child: Image.asset(
              'assets/devices.jpg',
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
            ),
          ),
          Center(
            child: Container(
                padding: EdgeInsets.all(5),
                child: Text(widget.procategory,
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 24))),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Model Id: ',
              style: TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              widget.promodelid,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'PresentLocation: ',
              style: TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              widget.propresentlocation,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Price:-  ',
              style: TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              '₹' + widget.proprice,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Sr.No:-  ',
              style: TextStyle(
                  //color: Colors.blue,
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
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Dealer:-  ',
              style: TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              widget.prodealer,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Tehsil:-  ',
              style: TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              widget.protehsil,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Model.No:-  ',
              style: TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              widget.promodelno,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Register:-  ',
              style: TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              widget.prostockRegister,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Warranty:-  ',
              style: TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              widget.prowarrantyPeriod,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'branchide:-  ',
              style: TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              widget.probranchid,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ]),
          Center(
            child: Container(
                child: Text(
              widget.prostatus.substring(7),
              style: TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )),
          ),
          Center(
            child: Container(
                child: Text(
              'Remarks:- ' + widget.proremarks,
              style: TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )),
          ),
          Center(
            child: Container(
                child: Text(
              'Make:- ' + widget.promake,
              style: TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )),
          ),
        ],
      ),
    );
  }
}
