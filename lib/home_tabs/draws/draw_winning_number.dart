import 'package:flutter/material.dart';

class DrawWinningNumber extends StatefulWidget {
  const DrawWinningNumber({super.key});

  @override
  State<StatefulWidget> createState() => _DrawWinningNumber();
}

class _DrawWinningNumber extends State<DrawWinningNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('DRAW WINNING NUMBER', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Text('Draw ', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),),
                SizedBox(width: 10),
                SizedBox(
                  height: 30,
                  width: 180,
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
                SizedBox(
                  height: 30,
                  width: 180,
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
                SizedBox(width: 20),
                Text('Number ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: 35,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[300]!, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true
                    ),
                  ),
                ),
                SizedBox(width: 40),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(5))
                  ),
                  child: const Center(
                    child: Text('See Report', style: TextStyle(color: Colors.white),),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(5))
                  ),
                  child: const Center(
                    child: Text('Declare Winning Number', style: TextStyle(color: Colors.white),),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(5))
                  ),
                  child: const Center(
                    child: Text('Rollback', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: 100,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueGrey, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
              child: const Center(
                child: Text('PL Report', style: TextStyle(color: Colors.black),),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text('Profit/Loss : 0', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18))
            ),
            SizedBox(height: 20),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width*3/4,
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