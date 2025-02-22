import 'package:flutter/material.dart';

class DealerReport extends StatefulWidget {
  const DealerReport({super.key});

  @override
  State<StatefulWidget> createState() => _DealerReportState();
}

class _DealerReportState extends State<DealerReport> {

  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
      body: SingleChildScrollView(
        child: */SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('DEALER REPORT', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(width: 10),
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
                            /*border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                            )*/
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
                            /*border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                            )*/
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
                            /*border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                            )*/
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
                            /*border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                            )*/
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
                    Text('Basis ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17)),
                    SizedBox(width: 5),
                    Container(
                      height: 30,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                          border: Border.all(color: Colors.grey[200]!, width: 1)
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                      child: Center(child: Text('Search', style: TextStyle(color: Colors.white, fontSize: 18),)),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('SINGLE', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),),
                ),
                SizedBox(
                  height: 450,
                  width: 1000,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 40,
                      crossAxisCount: 10,
                      crossAxisSpacing: 1,
                      childAspectRatio: 0.75,
                    ),
                    // return a custom ItemCard
                    itemBuilder: (context, i) {
                      if(i < 100) {
                        return Row(
                          children: <Widget>[
                            Text((i < 9) ? "${i+1}  " : (i+1).toString()),
                            (i < 99) ? const SizedBox(width: 5): const SizedBox(width: 0),
                            Container(
                              height: 35,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: const TextField(
                                maxLines: 1,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 18, left: 5, right: 5),
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
                      /*return */
                    },
                    itemCount: 110,
                  ),
                ),
                Text('ANDAR', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width*3/4,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int i) {
                        return Row(
                          children: <Widget>[
                            Text((i+1).toString()),
                            const SizedBox(width: 5),
                            Container(
                              height: 35,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: const TextField(
                                maxLines: 1,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 18, left: 5, right: 5),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),

                          ],
                        );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Text('BAHAR', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),),
                ),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int i) {
                        return Row(
                          children: <Widget>[
                            Text((i+1).toString()),
                            const SizedBox(width: 5),
                            Container(
                              height: 35,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: const TextField(
                                maxLines: 1,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 18, left: 5, right: 5),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),

                          ],
                        );
                      }),
                ),
                SizedBox(height: 15),
                Text('JODI', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500)),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width*3/4,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[200]!, width: 1)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text('JODICUT', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500)),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width*3/4,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[200]!, width: 1)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text('CROSSING', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500)),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width*3/4,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[200]!, width: 1)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true
                    ),
                  ),
                ),
                SizedBox(height: 15),

              ]
            ),
          ),
        )/*,
      ),
    )*/;
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