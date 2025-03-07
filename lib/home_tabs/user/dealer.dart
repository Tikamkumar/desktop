import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:betting/custom_style.dart';
import 'package:betting/view_models/DealerViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/dealer_model.dart';
import '../../view_models/StaffViewModel.dart';

class Dealer extends StatefulWidget {
  const Dealer({super.key, this.token, this.id});
  final token;
  final id;

  @override
  State<StatefulWidget> createState() => _dealerState();
}

class _dealerState extends State<Dealer> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController phoneNoSmsController = TextEditingController();
  TextEditingController besisController = TextEditingController(text: '0');
  TextEditingController partController = TextEditingController(text: '0');
  TextEditingController searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  String? staffField;
  String? selectPassword;
  Color hoverColor = Colors.black12;
  int selectedIndex = -1;
  late String selectStaff;
  bool ishover = false;
  int hoverIndex = -1;
  late List<Map<String, String>> dealers;
  late List<Map<String, String>> staffList;
  String? staffId;
  List<DealerModel> dealerList = [];
  late StreamController<List<DealerModel>> dealerController;
  String? dealerId;
  int page = 0;
  List<String> dealerTableTitle = ["Sr","Name", "Phone No", "Password", "Staff", "Besis", 'Partership Program', "Status"];
  String selectStatus = 'inactive';
  String partStatus = 'deny';
  bool isRights = false;
  String msg = "Hello";
  Widget currentUI = Container();
  bool isError = false;
  bool isDenaWork = false;
  bool isLoading = false;
  String permitStatus = 'deny';
  String commHaruf = '';
  String commJodi = '';
  late DealerViewModel viewModel;
  late StaffViewModel staffViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dealerController = StreamController();
    viewModel = DealerViewModel();
    staffViewModel = StaffViewModel();
    staffId = widget.id;
    staffList  = [{'name': 'Self', 'value': staffId!!}];
    selectStaff = staffList[0]['name']!;
    getDealerByPage(page.toString());
    // searchController.addListener(searchListener);
    _scrollController.addListener(loadDealer);
    // getAllDealer();
    getAllStaff();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneNoController.dispose();
    passwordController.dispose();
    besisController.dispose();
    partController.dispose();
    searchController.dispose();
    _scrollController.dispose();
  }

  loadDealer() {
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if(dealerList.length >= (page+1)*10) {
         page++;
         getDealerByPage(page.toString());
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
      body: Container(
        color: Colors.blue[50],
        padding: const EdgeInsets.all(12.0),
        child: */SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text('CREATE DEALER', style: CustomStyle.titleStyle),
                                const SizedBox(height: 5),
                                isError ? Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  child: Text(msg, style: TextStyle(color: Colors.red[800], fontSize: 15, fontWeight: FontWeight.w500)),
                                ) : Text(''),
                                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text('Name :  ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                            Container(
                              width: 250,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[400]!, width: 1),
                                borderRadius: BorderRadius.circular(2),
                                /* boxShadow: [
                                      BoxShadow(
                                          blurRadius: 3.0,
                                          spreadRadius: 1.0,
                                          offset: const Offset(1, 3),
                                          color: Colors.grey[200]!
                                      )
                                    ]*/
                              ),
                              child: TextField(
                                maxLines: 1,
                                textAlignVertical: TextAlignVertical.center,
                                controller: nameController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15, width: 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('Staff :    ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                            Container(
                              width: 250,
                              height: 35,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[400]!, width: 1),
                                borderRadius: BorderRadius.circular(2),
                                /* boxShadow: [
                                      BoxShadow(
                                          blurRadius: 3.0,
                                          spreadRadius: 1.0,
                                          offset: const Offset(1, 3),
                                          color: Colors.grey[200]!
                                      )
                                    ]*/
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: staffId,
                                  onChanged: (newValue) {
                                    log('Call');
                                    setState(() {
                                      staffId = newValue!!;
                                    });
                                  },
                                  items: staffList.map((dealer) {
                                    return DropdownMenuItem(
                                        child: new Text(dealer['name']!),
                                        value: dealer['value']
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15, width: 0),
                       /* Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('Game :  ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                            Container(
                              width: 250,
                              height: 35,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[400]!, width: 1),
                                borderRadius: BorderRadius.circular(2),
                                *//* boxShadow: [
                                      BoxShadow(
                                          blurRadius: 3.0,
                                          spreadRadius: 1.0,
                                          offset: const Offset(1, 3),
                                          color: Colors.grey[200]!
                                      )
                                    ]*//*
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: staffId,
                                  onChanged: (newValue) {
                                    log('Call');
                                    setState(() {
                                      staffId = newValue!!;
                                    });
                                  },
                                  items: staffList.map((dealer) {
                                    return DropdownMenuItem(
                                        child: new Text(dealer['name']!),
                                        value: dealer['value']
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15, width: 0),*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('Status : ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                            SizedBox(
                                width: 250,
                                height: 35,
                                child:  Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 'active',
                                      groupValue: selectStatus,
                                      onChanged: (value) {
                                        setState(() {
                                          selectStatus = value!!;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Active', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(width: 50, height: 20),
                                    Radio(
                                      value: 'inactive',
                                      groupValue: selectStatus,
                                      onChanged: (value) {
                                        setState(() {
                                          selectStatus = value!!;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Inactive', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text('Phone No: ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                            Container(
                              width: 250,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[400]!, width: 1),
                                borderRadius: BorderRadius.circular(2),
                                /* boxShadow: [
                                      BoxShadow(
                                          blurRadius: 3.0,
                                          spreadRadius: 1.0,
                                          offset: const Offset(1, 3),
                                          color: Colors.grey[200]!
                                      )
                                    ]*/
                              ),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLines: 1,
                                textAlignVertical: TextAlignVertical.center,
                                controller: phoneNoController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15, width: 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text('Besis(%) : ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                            Container(
                              width: 250,
                              height: 35,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[400]!, width: 1),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: TextField(
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textAlignVertical: TextAlignVertical.center,
                                controller: besisController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  int besis = (besisController.text.toString() != '') ? int.parse(besisController.text.toString()) : 0;
                                  log('Besis : $besis');
                                  commJodi = (besis != 0 && besis <= 30) ? (100-besis).toString() : '';
                                  commHaruf = (besis != 0 && besis <= 30) ? ((100-besis)/10).toString() : '';
                                  setState(() {});
                                },
                              ),
                            ),
                            
                            /*SizedBox(
                                      width: MediaQuery.of(context).size.width/5,
                                      height: 35,
                                      child:  Row(
                                        children: <Widget>[
                                          Radio(
                                            value: 'allow',
                                            groupValue: permitStatus,
                                            onChanged: (value) {
                                              setState(() {
                                                permitStatus = value!!;
                                              });
                                            },
                                          ),
                                          const Text(
                                            'Allow', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(width: 50, height: 20),
                                          Radio(
                                            value: 'deny',
                                            groupValue: permitStatus,
                                            onChanged: (value) {
                                              setState(() {
                                                permitStatus = value!!;
                                              });
                                            },
                                          ),
                                          const Text(
                                            'Deny', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      )
                                  ),*/
                            
                          ],
                        ),
                        const SizedBox(height: 15, width: 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text('Commission Haruf: ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                            Container(
                              width: 40,
                              height: 30,
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[400]!, width: 1),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: TextField(
                                  readOnly: true,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: commHaruf
                                  )
                              ),
                            ),
                            SizedBox(width: 10),
                            const Text('Commission Jodi: ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                            Container(
                              width: 40,
                              height: 30,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[400]!, width: 1),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: TextField(
                                readOnly: true,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: commJodi
                                ),
                              ),
                            ),
                            /*SizedBox(
                                      width: MediaQuery.of(context).size.width/5,
                                      height: 35,
                                      child:  Row(
                                        children: <Widget>[
                                          Radio(
                                            value: 'allow',
                                            groupValue: permitStatus,
                                            onChanged: (value) {
                                              setState(() {
                                                permitStatus = value!!;
                                              });
                                            },
                                          ),
                                          const Text(
                                            'Allow', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(width: 50, height: 20),
                                          Radio(
                                            value: 'deny',
                                            groupValue: permitStatus,
                                            onChanged: (value) {
                                              setState(() {
                                                permitStatus = value!!;
                                              });
                                            },
                                          ),
                                          const Text(
                                            'Deny', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      )
                                  ),*/
                            
                          ],
                        )
                        /* const SizedBox(height: 10, width: 0),
                              permitStatus == 'allow' ? Row(
                                children: [
                                  const Text('Commission (%): ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                                  Container(
                                    width: 80,
                                    height: 30,
                                    padding: EdgeInsets.symmetric(horizontal: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 1),
                                    ),
                                    child: TextField(
                                      maxLines: 1,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      textAlignVertical: TextAlignVertical.center,
                                      controller: besisController,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        isDense: true,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ) : Text(''),*/
                      ],
                    ),
                    const SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text('Password : ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                            Container(
                              width: 250,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[400]!, width: 1),
                                borderRadius: BorderRadius.circular(2),
                                /* boxShadow: [
                                      BoxShadow(
                                          blurRadius: 3.0,
                                          spreadRadius: 1.0,
                                          offset: const Offset(1, 3),
                                          color: Colors.grey[200]!
                                      )
                                    ]*/
                              ),
                              child: TextField(
                                maxLines: 1,
                                textAlignVertical: TextAlignVertical.center,
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15, width: 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('Partnership Program : ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                            SizedBox(
                                width: 250,
                                height: 35,
                                child:  Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 'allow',
                                      groupValue: partStatus,
                                      onChanged: (value) {
                                        setState(() {
                                          partStatus = value!!;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Allow', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(width: 50, height: 20),
                                    Radio(
                                      value: 'deny',
                                      groupValue: partStatus,
                                      onChanged: (value) {
                                        setState(() {
                                          partStatus = value!!;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Deny', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                        const SizedBox(height: 10, width: 0),
                        partStatus == 'allow' ? Row(
                          children: [
                            const Text('Commission (%): ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                            Container(
                              width: 80,
                              height: 30,
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey, width: 1),
                            
                              ),
                              child: TextField(
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textAlignVertical: TextAlignVertical.center,
                                controller: partController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ) : Text(''),
                            
                      ],
                    ),
                  ],
                                ),
                                /*Center(
                        child: ListTile(
                          leading: Checkbox(value: isDenaWork, onChanged: (check) {
                             setState(() {
                               isDenaWork = check!!;
                             });
                          }),
                          title: const Text('Dena Work', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                        ),
                      ),*/
                                const SizedBox(height: 10, width: 20),
                                SizedBox(
                  width: 1100,
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            validateForm();
                          },
                          child: Container(
                              height: 35,
                              width: 110,
                              decoration: BoxDecoration(
                                  color: Colors.brown,
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: const BorderRadius.all(Radius.circular(5))
                              ),
                              child: const Center(child: Text('ADD', style: TextStyle(color: Colors.white, fontSize: 15),))
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            validateForm(func: 'update');
                          },
                          child: Container(
                              height: 35,
                              width: 110,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: const BorderRadius.all(Radius.circular(5))
                              ),
                              child: const Center(child: Text('UPDATE', style: TextStyle(color: Colors.white, fontSize: 15),))
                          ),
                        ),
                        GestureDetector(
                          onTap: deleteStaff,
                          child: Container(
                              height: 35,
                              width: 110,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: const BorderRadius.all(Radius.circular(5))
                              ),
                              child: const Center(child: Text('DELETE', style: TextStyle(color: Colors.white, fontSize: 15),))
                          ),
                        ),
                        GestureDetector(
                          onTap: resetForm,
                          child: Container(
                              height: 35,
                              width: 110,
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: const BorderRadius.all(Radius.circular(5))
                              ),
                              child: const Center(child: Text('RESET', style: TextStyle(color: Colors.white, fontSize: 15),))
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 200,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[400]!, width: 1),
                            borderRadius: BorderRadius.circular(5),
                            /* boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3.0,
                                            spreadRadius: 1.0,
                                            offset: const Offset(1, 3),
                                            color: Colors.grey[200]!
                                        )
                                      ]*/
                          ),
                          child: TextField(
                            maxLines: 1,
                            textAlignVertical: TextAlignVertical.center,
                            controller: searchController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                                border: InputBorder.none,
                                hintText: 'Search Dealer',
                                hintStyle: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.w400),
                                prefixIcon: Icon(Icons.search, color: Colors.grey[400]!, size: 18,)
                            ),
                          ),
                        )
                      ]),
                                ),
                                const SizedBox(height: 10),
                                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[300]!)
                    ),
                    width: 1102,
                    height: 30,
                    child: Row(
                        children: dealerTableTitle.map((title) {
                          return Builder(builder: (context) {
                            return Container(
                              width: dealerTableTitle.first == title ? 50 : 150,
                              // padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.blue[200]
                              ),
                              child: Center(child: Text(title, style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),)),
                            );
                          });
                        }).toList(growable: true)
                    )
                                ),
                                Container(
                  width: 1100,
                  height: 300,
                  /*decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(100))
                         ),*/
                  child: StreamBuilder(stream: dealerController.stream, builder: (context, snapshot)  {
                    if(snapshot.hasData)  {
                      final data = snapshot.data;
                      // log('data : $data');
                      return Scrollbar(
                        controller: _scrollController,
                        // thumbVisibility: true,
                        thickness: 5,//According to your choice
                        thumbVisibility: false, //
                        radius: Radius.circular(5),
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: data!.length + 1,
                          controller: _scrollController,
                          itemBuilder: (context, i) {
                            DealerModel? item;
                            if ((i < data!.length)) {
                              item = data?[i];
                            } else {
                              item = null;
                            }
                            // log('name: ${item!.name}');
                            return (item != null ) ? InkWell(
                              onTap: () {
                                setState(() {
                                  selectField(item!);
                                  selectedIndex = i;
                                });
                              },
                              onHover: (flag) {
                                setState(() {
                                  ishover = flag;
                                  hoverIndex = i;
                                  // log('hover : $ishover');
                                });
                              },
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    color: (selectedIndex != i) ? ((ishover && hoverIndex == i) ? Colors.black12 : Colors.white) : Colors.black12,
                                    border: Border.all(color: Colors.black26, width: 0.1)
                                ),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: index == 0 ? 50 : 150,
                                        child: Center(child: Text(showText(item, index, i)!!, style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w400),)),
                                      );
                                    }, itemCount: 8),
                              ),
                            ) : Container(height: 100, color: Colors.white);
                          },
                        ),
                      );
                    } else {
                      return Text('');
                    }
                  }),
                                )
                              ]
                  ),
                ),
              ),
        );
      /*)
    );*/
  }

  Future validateForm({String func = 'add'}) async {
    showError(false);
    if(nameController.text.isEmpty) {
      showError(true, msg: "Please fill the dealer's name !");
      return;
    }
    if(phoneNoController.text.isEmpty || phoneNoController.text.length != 10) {
      showError(true, msg: 'Please fill the Valid Phone No !');
      return;
    }
    /*if(passwordController.text.isEmpty || passwordController.text.length < 8) {
      showError(true, msg: 'Password at least 8 characters !');
      return;
    }*/
    if(besisController.text.isEmpty || int.parse(besisController.text) > 100) {
      showError(true, msg: 'Besis(%) must be 1-100 !');
      return;
    }
    // log(widget.token.toString());
    func == 'add' ? createStaff() :  updateStaff();
  }

  void showError(bool flag, {String msg = "Fill all the details !"}) {
    setState(() {
      isError = flag;
      this.msg = msg!!;
    });
  }

  Future createStaff() async {
    // log('ParnerShip'+ partController.text);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      'authorization': 'Bearer ${widget.token.toString()}'
    };
    Object body = jsonEncode({
      'name': nameController.text,
      'mobile': phoneNoController.text,
      'password': passwordController.text,
      'besis': besisController.text,
      'partnerProgram': partStatus == 'allow' ? partController.text : '0',
      'status': selectStatus == 'active' ? 1 : 0,
      'staffMemberId': staffId
    });
    final response = await viewModel.createDealer(header, body);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
    if(response == "Dealer created successfully") {
      dealerList = [];
      setState(() {
        page = 0;
        getDealerByPage(page.toString());
        _scrollController.position.setPixels(0);
      });
      resetForm();
    }
  }

  Future deleteStaff() async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      'authorization': 'Bearer ${widget.token.toString()}'
    };
    Map<String, dynamic> param = {
      'id': dealerId
    };
    final response = await viewModel.deleteDealer(header, param);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
    if(response == "200") {
      dealerList = [];
      setState(() {
        page = 0;
        getDealerByPage(page.toString());
        // _scrollController.position.setPixels(0);
      });
      resetForm();
      log("Selected Index : $selectedIndex");
    }
  }

  Future updateStaff() async {
    if(dealerId == '') {
      return;
    }
    log(selectStatus);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      'authorization': 'Bearer ${widget.token.toString()}'
    };
    Object body = jsonEncode({
      'name': nameController.text,
      'mobile': phoneNoController.text,
      'password': passwordController.text == '****' ? '' : passwordController.text,
      'besis': besisController.text,
      'partnerProgramCommission': partStatus == 'allow' ? partController.text : '0',
      'status': selectStatus == 'active' ? '1' : '0',
      'staffMemberId': staffId
    });
    Map<String, dynamic> param = {
      'id': dealerId!!
    };
    final response = await viewModel.updateDealer(header, param, body);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
    if(response == '200') {
      dealerList = [];
      setState(() {
        page = 0;
        getDealerByPage(page.toString());
      });
      _scrollController.position.setPixels(0);
      resetForm();
    }
  }

  Future getAllStaff() async {
    // log(widget.token.toString());
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    final response = await staffViewModel.getAllStaff(header);
    // log('Data : $response');
    if(response != null && response.isNotEmpty) {
      setState(() {
        staffList.addAll(List.generate(response.length, (index) => {'name': response[index].name, 'value': response[index].id.toString()}));
        staffId = staffList[0]['value'];
        // log('Staff List : '+ staffList.toString());
        // log('Staff Id : $staffId');
      });
    }
  }

  Future getAllDealer() async {
    // log(widget.token.toString());
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    final response = await viewModel.getAllDealers(header);

    // log('Data : '+ response.toString());
    if(response != null && response.isNotEmpty) {
      setState(() {
        dealers.addAll(List.generate(response.length, (index) => {'name': response[index].name, 'value': response[index].id.toString()}));
        // log('Dealer List : '+ dealers.toString());
        dealerId = dealers[0]['value']!;
        // log('Dealer Id : $dealerId');
      });
    }
  }

  String? showText(DealerModel? model, int index, int sr) {
    // log('Model : $model');
    // log(staffList.toString());
    staffField = staffList.where((staff) => staff['value'] == model?.staffId.toString()).map((item) => item['name']).toString();
    switch(index) {
      case 0: return (sr+1).toString();
      case 1: {
        // log('index: $index');
        return model!.name.toString();
      }
      case 2: return model!.mobile.toString();
      case 3: return model!.password != null ? '******' : 'NA';
      case 4: return staffField;
      case 5: return model!.besis.toString();
      case 6: return model!.partProgram.toString();
      case 7: return (model!.status.toString() == '0') ? 'inactive' : 'active';
      default: return null;
    }
  }

  Future getDealerByPage(String page) async {
    // log('Page'+ page);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    Map<String, String> param = {
      'limit':'10',
      'page':page
    };
    final response = await viewModel.getDealerByName(header, param);
    if(response != null && response.isNotEmpty) {
      setState(() {
        dealerList.addAll(List.generate(response.length, (index) =>
        DealerModel(
            response[index].name,
            response[index].id,
            response[index].mobile,
            response[index].status,
            response[index].walletAmount,
            response[index].password,
            response[index].besis,
            response[index].partProgram,
            response[index].userId,
            response[index].image,
            response[index].staffId
        )));
        dealerController.add(dealerList);
      });
      log('Dealer List : '+ dealerList[0].name);

    }
  }

  resetForm() {
    dealerId = '';
    nameController.text = "";
    phoneNoController.text = "";
    passwordController.text = "";
    besisController.text = "0";
    partController.text = "0";
    setState(() {
      selectedIndex = -1;
    });
  }

  selectField(DealerModel item) {
     selectPassword = item.password;
     dealerId = item.id.toString();
     nameController.text = item.name;
     phoneNoController.text = item.mobile.toString();
     item.password != null ? passwordController.text = '****' : passwordController.text = '';
     besisController.text = item.besis.toString();
     partController.text = item.partProgram.toString();
     setState(() {
       selectStatus = (item.status.toString() == "0") ?  'inactive' : "active";
       (item.partProgram.toString() == "0") ? partStatus = 'deny' : partStatus = "allow";
       if(staffId != item.staffId) {
         staffId = item.staffId.toString();
       }
     });
  }

  /*Future printlength() async {
    Future<int> msg = await dealerController.stream.length;
    log(msg.toString());
  }*/
}
