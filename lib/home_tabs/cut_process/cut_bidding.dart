import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CutBidding extends StatefulWidget {
  const CutBidding({super.key});

  @override
  State<StatefulWidget> createState() => _cutBiddingState();
}

class _cutBiddingState extends State<CutBidding> {
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Row(
          children: <Widget>[
              Text('CUT BIDDING', style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500))
          , SizedBox(width: 50),
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
          SizedBox(width: 50),
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

            SizedBox(width: 50),
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

          ],
              ),
                SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width*2/3,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                        width: 200,
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
                      Spacer(),
                      Text('Cut Value : ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 35,
                        width: 150,
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
                      IconButton(onPressed: () {}, icon: Icon(Icons.cut, color: Colors.black))
                    ],
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width*2/3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Checkbox(value: true, onChanged: null),
                      Text('MANUAL ENTRY'),
                      SizedBox(width: 10),
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Center(child: Text('CHECK DEALERS', style: TextStyle(color: Colors.white),)),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                const Text('Total Bet : 12345', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),),
                SizedBox(height: 10),
                SizedBox(
                  child: Row(
                    children: <Widget>[
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
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Center(child: Text('Search Bet Values', style: TextStyle(color: Colors.white),)),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Center(child: Text('See Cut', style: TextStyle(color: Colors.white),)),
                      ),
                      SizedBox(width: 10),
                      Text('Dealer : ', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500)),
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
                      Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300]!, width: 1),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 30,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(3))
                        ),
                        child: Center(child: Text('ADD%', style: TextStyle(color: Colors.white),))
                      ),
                      /*Spacer(),
                      Text('Cut Value : ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 35,
                        width: 150,
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
                      IconButton(onPressed: () {}, icon: Icon(Icons.cut, color: Colors.black))*/
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 350,
                      width: 1000,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 100,
                          crossAxisCount: 10,
                          crossAxisSpacing: 1,
                          childAspectRatio: 0.75,
                        ),
                        // return a custom ItemCard
                        itemBuilder: (context, i) {
                          if(i < 100) {
                            return Row(
                              children: <Widget>[
                                Text((i < 9) ? "${i+1}  " : (i+1).toString(), style: TextStyle(fontSize: 14),),
                                (i < 99) ? const SizedBox(width: 5): const SizedBox(width: 0),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  height: 30,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(1)),
                                      border: Border.all(color: Colors.grey[300]!)
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    maxLines: 1,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        isDense: true,
                                        border: InputBorder.none
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(right: 35, top: 10),
                              child: Text('0', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.purple),),
                            );
                          }
                        },
                        itemCount: 100,
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300]!, width: 1)
                      ),
                      width: 150,
                      height: 350,
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width*3/4,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10, itemBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 100, child: Center(child: Text('0')));
                  }),
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 35,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    child: Center(
                      child: Text('SUBMIT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                    ),
                  ),
                )
              ]
              ,
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