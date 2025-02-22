import 'package:flutter/material.dart';

class DrawMaster extends StatefulWidget {
  const DrawMaster({super.key});

  @override
  State<StatefulWidget> createState() => _drawMasterState();
}

class _drawMasterState extends State<DrawMaster> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<String> title = ["Name", "Password", "Status", "Bet Allow", "Offline", "Allow Basis", "Allow All User", "Admin Rights"];
  List<String> dealerTableTitle = ["Name", "UserId", "Password", "Wallet Status", "Phone No", "Phone No[SMS]", "Commission Jodi", "Commission Haruf", "Status"];
  int selectStatus = 0;
  bool isRights = false;
  String msg = "Hello";
  Widget currentUI = Container();
  bool isError = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: */SizedBox(
         height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('DRAW MASTER', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10, width: 20),
                    Row(
                      children: <Widget>[
                        const Text('    DRAW NAME ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                        Container(
                          width: 300,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xffebe7e7), width: 1),
                              borderRadius: BorderRadius.circular(7),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3.0,
                                    spreadRadius: 1.0,
                                    offset: const Offset(1, 3),
                                    color: Colors.grey[200]!
                                )
                              ]
                          ),
                          child: TextField(
                            maxLines: 1,
                            textAlignVertical: TextAlignVertical.center,
                            controller: emailController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(width: 50),
                        Container(
                          height: 35,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Center(child: Text('SEARCH BY NAME', style: TextStyle(color: Colors.white))),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const Text('DATE OF DRAW ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                        Container(
                          width: 300,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xffebe7e7), width: 1),
                              borderRadius: BorderRadius.circular(7),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3.0,
                                    spreadRadius: 1.0,
                                    offset: const Offset(1, 3),
                                    color: Colors.grey[200]!
                                )
                              ]
                          ),
                          child: TextField(
                            maxLines: 1,
                            textAlignVertical: TextAlignVertical.center,
                            controller: emailController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(width: 50),
                        Container(
                          height: 35,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Center(child: Text('SEARCH BY DATE', style: TextStyle(color: Colors.white))),
                        )
                      ],
                    ),
                    const SizedBox(height: 20, width: 20),
                    Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isRights.toString())));
                            },
                            child: Container(
                                height: 35,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Colors.brown,
                                    border: Border.all(color: Colors.white, width: 2),
                                    borderRadius: const BorderRadius.all(Radius.circular(5))
                                ),
                                child: const Center(child: Text('ADD', style: TextStyle(color: Colors.white, fontSize: 15)))
                            ),
                          ),
                          Container(
                              height: 35,
                              width: 120,
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Colors.brown,
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: const BorderRadius.all(Radius.circular(5))
                              ),
                              child: const Center(child: Text('UPDATE', style: TextStyle(color: Colors.white, fontSize: 15),))
                          ),
                          Container(
                              height: 35,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.brown,
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: const BorderRadius.all(Radius.circular(5))
                              ),
                              child: const Center(child: Text('DELETE', style: TextStyle(color: Colors.white, fontSize: 15),))
                          ),
                          Container(
                              height: 35,
                              width: 120,
                              margin: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  color: Colors.brown,
                                  border: Border.all(color: Colors.white, width: 1),
                                  borderRadius: const BorderRadius.all(Radius.circular(5))
                              ),
                              child: const Center(child: Text('RESET', style: TextStyle(color: Colors.white, fontSize: 15),))
                          ),
                        ]),
                    const Text('List Of Users', style: TextStyle(color: Colors.white, fontSize: 20),),
                    Expanded(
                      child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: dealerTableTitle.map((country){
                                    return Container(
                                        height: 40,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            border: Border.all(color: Colors.grey, width: 1)
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(country)
                                    );
                                  }).toList(),
                                )
                                ,
                              ),
                              Container(
                                height: 40,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: dealerTableTitle.map((country){
                                    return Container(
                                        height: 40,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: const Color(
                                                0xffe9e5e5), width: 1)
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(country)
                                    );
                                  }).toList(),
                                )
                                ,
                              ),
                            ],
                          )
                      ),
                    )


                  ]
              ),
            ),
          ),
        );
      /*),
    )*/
  }

}
