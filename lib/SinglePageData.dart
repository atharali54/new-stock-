import 'package:flutter/material.dart';

import 'Home.dart';

// ignore: must_be_immutable
class SingleProductPage extends StatefulWidget {
  String promodelid;
  String prostatus;
  String proprice;
  String prosrno;
  String promodelno;
  String propresentlocation;

  SingleProductPage(
      {Key key,
      this.promodelid,
      this.promodelno,
      this.proprice,
      this.prosrno,
      this.propresentlocation,
      this.prostatus})
      : super(key: key);

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.promodelid),
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
          Text(widget.promodelid),
          Text(widget.prosrno),
          Text(widget.proprice),
          Text(widget.propresentlocation),
          Text(widget.promodelno.toString()),
          Text(widget.prostatus.toString()),
        ],
      ),
    );
  }
}
