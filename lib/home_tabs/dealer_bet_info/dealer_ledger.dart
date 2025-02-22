import 'package:betting/home_tabs/dealer_bet_info/reporting/dealer_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealerLedger extends StatefulWidget {
  const DealerLedger({super.key});

  @override
  State<StatefulWidget> createState() => _DealerState();
}

class _DealerState extends State<DealerLedger> {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Container(width: MediaQuery.of(context).size.width, color: Colors.white, child: Text('DEALER LEDGER', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500))),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Text('Set SMS Config', style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.w500),),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    color: Colors.black12,
                    width: MediaQuery.of(context).size.width,
                    child: Text('DEALER LEDGER DETAILS', style: TextStyle(color: Colors.black,fontSize: 18, fontWeight: FontWeight.w400),),
                  ),
                ),
                Row(
                  children: <Widget>[
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Row(
                             children: <Widget>[
                               Text('Select Dealer', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
                               SizedBox(
                                 height: 30,
                                 width: 150,
                                 child: DropdownButtonFormField(
                                     decoration: InputDecoration(
                                         contentPadding: const EdgeInsets.only(left: 10),
                                         focusedBorder: OutlineInputBorder(
                                           borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                                         ),
                                         disabledBorder: OutlineInputBorder(
                                           borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                                         ),
                                         filled: true,
                                         fillColor: Colors.white,
                                         border: InputBorder.none
                                     ),
                                     onChanged: (newValue) {
                                       setState(() {
                                         // selectDealer = newValue!;
                                       });
                                     },
                                     items: dropdownItems
                                 ),
                               ),
                               SizedBox(width: 50),
                               SizedBox(
                                 height: 30,
                                 width: 150,
                                 child: DropdownButtonFormField(
                                     decoration: InputDecoration(
                                         contentPadding: const EdgeInsets.only(left: 10),
                                         focusedBorder: OutlineInputBorder(
                                           borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                                         ),
                                         disabledBorder: OutlineInputBorder(
                                           borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                                         ),
                                         filled: true,
                                         fillColor: Colors.white,
                                         border: InputBorder.none
                                     ),
                                     onChanged: (newValue) {
                                       setState(() {
                                         // selectDealer = newValue!;
                                       });
                                     },
                                     items: dropdownItems
                                 ),
                               ),
                             ],
                           ),
                           SizedBox(height: 10),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               Text('Dealer Ledger Report', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
                               SizedBox(width: 100),
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 5),
                                 decoration: BoxDecoration(
                                   color: Colors.redAccent,
                                   borderRadius: BorderRadius.all(Radius.circular(5)),
                                   border: Border.all(color: Colors.white, width: 2)
                                 ),
                                 child: Text('SMS TO MULTIPLE DEALERS', style: TextStyle(color: Colors.white,),),
                               )
                             ],
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisSize: MainAxisSize.max,
                         children: <Widget>[
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                               Container(
                                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                 decoration: BoxDecoration(
                                     color: Colors.blue,
                                     border: Border.all(color: Colors.white, width: 2),
                                     borderRadius: BorderRadius.all(Radius.circular(5))
                                 ),
                                 child: const Text('See Ledger', style: TextStyle(color: Colors.white)),
                               ),
                               SizedBox(width: 10,),
                               Column(
                                 children: <Widget>[
                                   Container(
                                     height: 30,
                                     width: 250,
                                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                     decoration: BoxDecoration(
                                         color: Colors.white,
                                         border: Border.all(color: Colors.white, width: 2),
                                         borderRadius: BorderRadius.all(Radius.circular(5))
                                     ),
                                     child: TextField(
                                       decoration: InputDecoration(
                                           border: InputBorder.none,
                                           isDense: true
                                       ),
                                     ),
                                   ),
                                   SizedBox(height: 10),
                                   SizedBox(
                                     width: 250,
                                     child: Row(
                                       mainAxisSize: MainAxisSize.max,
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: <Widget>[
                                         Container(
                                           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                           child: Text('Send SMS', style: TextStyle(color: Colors.white)),
                                           decoration: BoxDecoration(
                                               color: Colors.blueAccent,
                                               border: Border.all(color: Colors.white, width: 2),
                                               borderRadius: BorderRadius.all(Radius.circular(8))
                                           ),
                                         ),

                                         Container(
                                           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                           child: Text('Whatsapp', style: TextStyle(color: Colors.white)),
                                           decoration: BoxDecoration(
                                               color: Colors.blueAccent,
                                               border: Border.all(color: Colors.white, width: 2),
                                               borderRadius: BorderRadius.all(Radius.circular(8))
                                           ),
                                         ),
                                       ],
                                     ),
                                   )
                                 ],
                               )
                             ]
                           ),
                           SizedBox(height: 20),
                           Row(
                             mainAxisSize: MainAxisSize.max,
                             children: <Widget>[
                               Text('DIYA WORK 0'),
                               SizedBox(width: 100),
                               Text('LIYA WORK 0')

                             ],
                           )
                         ],
                       ),
                     ),
                     SizedBox(width: 20,),
                     Text('Profile/Loss 0', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),),
                    SizedBox(width: 20,),
                     InkWell(
                       onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => const DealerHistory()));
                       },
                       child: Container(
                         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                         decoration: BoxDecoration(
                           color: Colors.blue,
                           borderRadius: BorderRadius.all(Radius.circular(5)),
                           border: Border.all(color: Colors.white, width: 2)
                         ),
                         child: Text('DEALER HISTORY', style: TextStyle(color: Colors.white),),
                       ),
                     )
                  ],
                )
              ],
            ),
          ),
          Container(
            color: Colors.blue[100]!,
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    color: Colors.black12,
                    width: MediaQuery.of(context).size.width,
                    child: Text('DEALER BALANCE', style: TextStyle(color: Colors.black,fontSize: 18, fontWeight: FontWeight.w400),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                                width: 150,
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(left: 10),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: InputBorder.none
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        // selectDealer = newValue!;
                                      });
                                    },
                                    items: dropdownItems
                                ),
                              ),
                              SizedBox(width: 50),
                              SizedBox(
                                height: 30,
                                width: 150,
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(left: 10),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: InputBorder.none
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        // selectDealer = newValue!;
                                      });
                                    },
                                    items: dropdownItems
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text('Last Bal :    0', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
                          Text('Final Bal:    0', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
                          Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text('Amount Received :', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
                                      Container(
                                        width: 150,
                                        height: 30,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      Text('Password :', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
                                      Container(
                                        width: 200,
                                        height: 30,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: 5),
                              Container(
                                height: 70,
                                width: 150,
                                color: Colors.white,
                                child: Text(''),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: <Widget>[
                              Container(
                                height: 35,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(child: Text('Eliminate Basis', style: TextStyle(color: Colors.white),)),
                              ),
                              SizedBox(width: 10),
                              Container(
                                height: 35,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(child: Text('View Details', style: TextStyle(color: Colors.white),)),
                              ),
                              SizedBox(width: 10),
                              Container(
                                height: 35,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(child: Text('Submit', style: TextStyle(color: Colors.white),)),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          color: Colors.blue[100]!,
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

        ],
      )
    ;
  }
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }
}