import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MySingleProduct extends StatefulWidget {
  String promodelid;
  String proprice;
  String prosrno;
  String prodevicesrno;
  String prostockRegister;
  String promodelno;
  String promake;
  String proremarks;
  String procategory;
  String protehsil;
  String prostatus;
  String probranchid;
  String prooffice;
  String probranch;
  String probissue;
  String probmobile;
  String prowarrantyPeriod;
  String prodealer;

  MySingleProduct(
      {Key key,
      this.promake,
      this.promodelid,
      this.procategory,
      this.proprice,
      this.prodealer,
      this.promodelno,
      this.probranchid,
      this.prooffice,
      this.probranch,
      this.probissue,
      this.probmobile,
      this.proremarks,
      this.prosrno,
      this.prodevicesrno,
      this.prostatus,
      this.prostockRegister,
      this.protehsil,
      this.prowarrantyPeriod})
      : super(key: key);

  @override
  State<MySingleProduct> createState() => _MySingleProductState();
}

class _MySingleProductState extends State<MySingleProduct> {
  String _chosenValue; //dropdown tranefer
  String _chosenValue2; //dropdown tranefer

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.procategory),
        ),
        body: Center(
          child: Card(
            shadowColor: Colors.black,
            color: Colors.greenAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 500,
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Text('Model No:- ' + 'widget.promodelno'),
                    Center(
                      child: Text(
                        widget.procategory,
                        style: TextStyle(
                          fontSize: 18,
                          // color: Colors.green[900],
                          fontWeight: FontWeight.w500,
                        ), //Textstyle
                      ),
                    ),

                    Divider(
                      color: Colors.black,
                    ),

                    Text(
                      'Project:-  ' + widget.promodelid,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ), //Textstyle
                    ),
                    Text(
                      'Make:-   ' + widget.promake,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ), //Textstyle
                    ),
                    Text(
                      'Model:-   ' + widget.promodelno,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ), //Textstyle
                    ),
                    Text(
                      'Serial No:-  ' + widget.prodevicesrno,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ), //Textstyle
                    ),
                    Text(
                      'Status:-  ' + widget.prostatus,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ), //Textstyle
                    ),
                    Text(
                      'Office:-  ' + widget.prooffice,

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ), //Textstyle
                    ),
                    Text(
                      'Branch:-  ' + widget.probranch,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ), //Textstyle
                    ),
                    Text(
                      'Issued Name:-  ' + widget.probissue,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ), //Textstyle
                    ),
                    Text(
                      'Mobile:-  ' + widget.probmobile,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ), //Textstyle
                    ),
                    Text(
                      'Remarks:-  ' + widget.proremarks,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ), //Textstyle
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        // Column(
        //   children: [
        //     Container(
        //       child: Image.asset(
        //         'assets/devices.jpg',
        //         fit: BoxFit.cover,
        //         height: 180,
        //         width: double.infinity,
        //       ),
        //     ),
        //     Center(
        //       child: Container(
        //           padding: EdgeInsets.all(5),
        //           child: Text(widget.procategory,
        //               style: TextStyle(
        //                   color: Colors.orange,
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 24))),
        //     ),
        //     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //       Text(
        //         'Model Id: ',
        //         style: TextStyle(
        //             //color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       ),
        //       Text(
        //         widget.promodelid,
        //         style: TextStyle(
        //             color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       ),
        //     ]),
        //     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //       Text(
        //         'Dealer:-  ',
        //         style: TextStyle(
        //             //color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       ),
        //       Text(
        //         widget.prodealer,
        //         style: TextStyle(
        //             color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       ),
        //     ]),
        //     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //       Text(
        //         'Tehsil:-  ',
        //         style: TextStyle(
        //             //color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       ),
        //       Text(
        //         widget.protehsil,
        //         style: TextStyle(
        //             color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       ),
        //     ]),
        //     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //       Text(
        //         'Model.No:-  ',
        //         style: TextStyle(
        //             //color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       ),
        //       Text(
        //         widget.promodelno,
        //         style: TextStyle(
        //             color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       ),
        //     ]),
        //     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //       Text(
        //         'Register:-  ',
        //         style: TextStyle(
        //             //color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       ),
        //       Text(
        //         widget.prostockRegister,
        //         style: TextStyle(
        //             color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       ),
        //     ]),
        //     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //       Text(
        //         'Warranty:-  ',
        //         style: TextStyle(
        //             //color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       ),
        //       Text(
        //         widget.prowarrantyPeriod,
        //         style: TextStyle(
        //             color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       ),
        //     ]),
        //     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //       Text(
        //         'branchide:-  ',
        //         style: TextStyle(
        //             //color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       ),
        //       Text(
        //         widget.probranchid,
        //         style: TextStyle(
        //             color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       ),
        //     ]),
        //     Center(
        //       child: Container(
        //           child: Text(
        //         widget.prostatus.substring(7),
        //         style: TextStyle(
        //             //color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       )),
        //     ),
        //     Center(
        //       child: Container(
        //           child: Text(
        //         'Remarks:- ' + widget.proremarks,
        //         style: TextStyle(
        //             //color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       )),
        //     ),
        //     Center(
        //       child: Container(
        //           child: Text(
        //         'Make:- ' + widget.promake,
        //         style: TextStyle(
        //             //color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16),
        //       )),
        //     ),
        //   ],
        // ),
        );
  }
}
