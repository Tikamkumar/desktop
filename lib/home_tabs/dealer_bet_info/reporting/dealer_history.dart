import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealerHistory extends StatefulWidget {
  const DealerHistory({super.key});
  @override
  State<StatefulWidget> createState() => _dealerHistoryState();
}

class _dealerHistoryState extends State<DealerHistory> {
  bool isOverall = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('DEALER HISTORY', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back, size: 20, color: Colors.white)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.blue[50],
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width*3/4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Net Profit Or Loss 0', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                  Text('Net Profit Or Loss WB 0', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                  Text('Total Game 0', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width*3/4,
              child: Row(
                children: <Widget>[
                  Text('SELECT DEALER', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 30,
                    width: 250,
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10, bottom: 12),
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
                  SizedBox(width: 10),
                  Text('FROM', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 30,
                    width: 150,
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10, bottom: 12),
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
                  SizedBox(width: 10),
                  Text('TO', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 30,
                    width: 150,
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10, bottom: 12),
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
                  SizedBox(width: 10),
                  Checkbox(value: isOverall, onChanged: (value) {
                    setState(() {
                      isOverall = value!!;
                    });
                  },
                  checkColor: Colors.black,
                    overlayColor: const WidgetStatePropertyAll(Colors.grey),
                  fillColor: const WidgetStatePropertyAll(Colors.white),),
                  Text('Overall', style: TextStyle(color: Colors.blue[900], fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(width: 10),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      border: Border.all(color: Colors.white, width: 2)
                    ),
                    child: Center(
                      child: Text('SUBMIT', style: TextStyle(color: Colors.black, fontSize: 17)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: MediaQuery.of(context).size.width*3/4,
              height: MediaQuery.of(context).size.height/2,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
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