import 'dart:convert';
import 'dart:developer';
import 'package:dartx/dartx.dart';
import 'package:betting/data/remote/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:betting/model/bid_model.dart';
import 'package:betting/model/dealer_model.dart';
import 'package:betting/view_models/GameViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ShowBids extends StatefulWidget {
  ShowBids({super.key, required this.token, required this.gameId});
  final token;
  String gameId;

  @override
  State<StatefulWidget> createState() => _showBidState();
}

class _showBidState extends State<ShowBids> {
  String selectDate = '';
  GameViewModel gameViewModel = GameViewModel();
  BidModel? bidData;
  List<Map<String, String>> dealerList = [{'id':'-1', 'name': 'None'}];
  String selectedDealerId = '-1';
  List<Map<String, String>>? bidList = [];
  List<Map<String, String>>? andarList = [];
  List<Map<String, String>>? baharList = [];
  List<Map<String, String>> maxBids = [];
  List<Map<String, String>> minBids = [];
  TextEditingController resultController = TextEditingController();
  String totalAmount = '0';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBidData();
    getAllDealer();
  }

  @override
  void dispose() {
    super.dispose();
    resultController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        /*constraints: BoxConstraints(
              minHeight: constraint.maxHeight,
              minWidth: constraint.maxWidth
            ),*/
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.blue[700],
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                child: Icon(Icons.arrow_back,
                                    size: 20, color: Colors.white)),
                          ),
                          SizedBox(width: 15),
                          Text('BID NUMBERS',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('SELECT DEALER',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey, width: 0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              padding: EdgeInsets.only(left: 10),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedDealerId,
                                  items: dealerList.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item['id'],
                                      child: Text(
                                        item['name'].toString(),
                                        style:
                                        const TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedDealerId = value!;
                                    });
                                    if(selectedDealerId == '-1') {
                                      getBidData();
                                    } else {
                                      getBidByDealer();
                                    }
                                  },
                                  hint: Text('Show Bid'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('TOP 10 MAXIMUM BIDS',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            // SizedBox(height: 5),
                            Container(
                              width: 250,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                  Border.all(color: Colors.grey, width: 0.5),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                              padding: EdgeInsets.only(left: 10),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  items: maxBids.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        item.toString(),
                                        style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                      value: item['number'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {

                                  },
                                  hint: Text('Show Bid'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('TOP 10 MINIMUM BIDS',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            Container(
                              width: 250,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                  Border.all(color: Colors.grey, width: 0.5),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                              padding: EdgeInsets.only(left: 10),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  items: minBids.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item.toString()),
                                      value: item['number'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {

                                  },
                                  hint: Text('Show Bid'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('SELECT START DATE',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            GestureDetector(
                              onTap: pickDate,
                              child: Container(
                                  width: 200,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 0.5),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                                  padding: EdgeInsets.only(left: 10),
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.date_range,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        hintText: selectDate,
                                        hintStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('BID RESULT NUMBER',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            Container(
                                width: 200,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                    Border.all(color: Colors.grey, width: 0.5),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                                padding: EdgeInsets.only(left: 10),
                                child: TextField(
                                  controller: resultController,
                                  maxLength: 2,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true,
                                      border: InputBorder.none),
                                )),
                          ],
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: declareResult,
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.blue[700],
                                  border: Border.all(color: Colors.grey, width: 0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              )),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: confirmDialog,
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.blue[700],
                                  border: Border.all(color: Colors.grey, width: 0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  'RE-BID',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 420,
                      width: 1000,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 40,
                          crossAxisCount: 10,
                          crossAxisSpacing: 1,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, i) {
                          return Row(
                            children: <Widget>[
                              Text(
                                (i < 10) ? "0${i}" : (i).toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(width: 5),
                              Container(
                                height: 35,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color: Colors.grey)),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  enabled: false,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  maxLines: 1,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                      hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                      hintText:bidList!.isEmpty ? '' : showBid((i < 10) ? "0${i}" : (i).toString(), bidList!),
                                      contentPadding: const EdgeInsets.only(bottom: 18, left: 5, right: 5),
                                      border: InputBorder.none),
                                ),
                              )
                            ],
                          );
                          /* } else {
                            return Padding(
                              padding: const EdgeInsets.only(right: 35, top: 10),
                              child: Text('0', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.purple),),
                            );
                          }*/
                        },
                        itemCount: 100,
                      ),
                    ),
                    const Text(
                      'ANDAR',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 40,
                      // width: MediaQuery.of(context).size.width*3/4,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int i) {
                            return Row(
                              children: <Widget>[

                                Text((i).toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(width: 5),
                                Container(
                                  height: 35,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color: Colors.grey)),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    enabled: false,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    maxLines: 1,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                        hintText:andarList!.isEmpty ? '' : showBid((i < 10) ? "0${i}" : (i).toString(), andarList!),
                                        contentPadding: EdgeInsets.only(
                                            bottom: 18, left: 5, right: 5),
                                        border: InputBorder.none),
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            );
                          }),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        'BAHAR',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      // width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int i) {
                            return Row(
                              children: <Widget>[
                                Text((i).toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(width: 5),
                                Container(
                                  height: 35,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color: Colors.grey)),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    enabled: false,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    maxLines: 1,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                        hintText:baharList!.isEmpty ? '' : showBid((i < 10) ? "0${i}" : (i).toString(), baharList!),
                                        contentPadding: EdgeInsets.only(
                                            bottom: 18, left: 5, right: 5),
                                        border: InputBorder.none),
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            );
                          }),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('TOTAL AMOUNT : ₹${totalAmount}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20)),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }


  Future pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      setState(() {
        selectDate = DateFormat('yyyy-MM-dd').format(pickedDate).toString();
      });
      getBidByDate();
    }
  }

  Future getBidData() async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    Map<String, String> param = {'id': widget.gameId.toString()};
    bidData = await gameViewModel.getBidById(header, param);
    if (bidData != null) {
      showData(bidData!);
    }
  }

  showData(BidModel model) {
    if(model.bids != null) {
      for (int i = 0; i < model.bids.length; i++) {
        bidList!.add({
          'number': '${model.bids[i]['number']}',
          'amount': model.bids[i]['amount'].toString()
        });
      }
    }
    if(model.inside != null) {
      List inside = json.decode(model.inside).cast<Map<String, dynamic>>().toList();
      for (int i = 0; i < inside.length; i++) {
        andarList!.add({
          'number': inside[i]['number'].toString(),
          'amount': inside[i]['amount'].toString()
        });
      }
    }

    if(model.outside != null) {
      List outside = json.decode(model.outside).cast<Map<String, dynamic>>().toList();
      for (int i = 0; i < outside.length; i++) {
        baharList!.add({
          'number': outside[i]['number'].toString(),
          'amount': outside[i]['amount'].toString()
        });
      }
    }

    final sortList = bidList;
    for(int i = 0; i < sortList!.length; i++) {
      for(int j = 0; j < bidList!.length; j++) {
        if(int.parse(sortList![i]['amount']!) < int.parse(bidList![j]['amount']!)) {
          var item = sortList![i];
          sortList![i] = bidList![j];
          sortList![j] = item;
        }
      }
    }
    if(sortList.length > 10) {
      maxBids = sortList.sublist(0, 10);
      minBids = sortList.reversed.toList().sublist(0, 10);
    } else {
      maxBids = sortList;
      minBids = sortList.reversed.toList();
    }

    totalAmount = (-int.parse(model.collectedBidAmount.toString())).toString() ?? '0';
    resultController.text =
        model.finalBidNumber != null ? model.finalBidNumber.toString() : '';

    setState(() {
      totalAmount;
      minBids;
      maxBids;
    });
  }

  showFilterData(final body) {
    bidList = [];
    andarList = [];
    baharList = [];
    widget.gameId = body['data']['prevGame']['id'];
   try {
     List bids = json.decode(body['data']['prevGame']['bidArray']).cast<Map<String, dynamic>>().toList();
     for (int i = 0; i < bids.length; i++) {
       bidList!.add({
         'number': '${bids[i]['number']}',
         'amount': bids[i]['amount'].toString()
       });
     }
     List inside = json.decode(body['data']['prevGame']['inside']).cast<Map<String, dynamic>>().toList();
     for (int i = 0; i < inside.length; i++) {
       andarList!.add({
         'number': inside[i]['number'].toString(),
         'amount': inside[i]['amount'].toString()
       });
     }
     List outside = json.decode(body['data']['prevGame']['outside']).cast<Map<String, dynamic>>().toList();
     for (int i = 0; i < outside.length; i++) {
       baharList!.add({
         'number': outside[i]['number'].toString(),
         'amount': outside[i]['amount'].toString()
       });
     }

     final sortList = bidList;
     for(int i = 0; i < sortList!.length; i++) {
       for(int j = 0; j < bidList!.length; j++) {
         if(int.parse(sortList![i]['amount']!) < int.parse(bidList![j]['amount']!)) {
           var item = sortList![i];
           sortList![i] = bidList![j];
           sortList![j] = item;
         }
       }
     }
     maxBids = sortList.sublist(0, 10);
     minBids = sortList.reversed.toList().sublist(0, 10);

     // totalAmount = (-model.collectedBidAmount).toString();
     resultController.text =
     body['data']['prevGame']['finalBidNumber'] != null ? body['data']['prevGame']['finalBidNumber'].toString() : '';

     setState(() {
       totalAmount;
       minBids;
       maxBids;
     });
   } catch(exp) {
     log('hello'+exp.toString());
   }

  }

  String showBid(String num, List<Map<String, String>> list) {
    String retBid = '';
    for(int i = 0; i < list!.length; i++) {
      if(list![i]['number'] == num) {
        retBid = list![i]['amount'].toString();
        break;
      } else {
        retBid = '';
      }
    }
     return retBid;
  }

  Future declareResult() async {
    Map<String, String> header = {
      'Content-Type':'application/json',
      'authorization':'Bearer ${widget.token}'
    };
    Object body = jsonEncode({
      'bidNumber':resultController.text.toString(),
      'bidAmount':totalAmount
    });
    Map<String, dynamic> param = {
      'id':'${widget.gameId}'
    };
    final response = await gameViewModel.gameResult(header, body, param);
    if(response == '200') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Result Declare Successfully...', style: TextStyle(color: Colors.black),), backgroundColor: Colors.white));
      getBidData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response, style: TextStyle(color: Colors.black)), backgroundColor: Colors.white));
    }
  }

  Future confirmDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
           child: Container(
             padding: const EdgeInsets.all(15),
             height: 150,
             width: 400,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(10)),
               color: Colors.white,
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const Row(
                   children: [
                     Text('Confirm Re-bid !', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 17),),
                   ],
                 ),
                 const Text('Are you sure want to delete Last Result ? ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),),
                 const Spacer(),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     TextButton(onPressed: () {Navigator.pop(context);}, child: Text('Cancel',)),
                     GestureDetector(
                       onTap: () {
                         Navigator.pop(context);
                         deleteResult();
                       },
                       child: Container(
                         height: 35,
                         width: 90,
                         decoration: BoxDecoration(
                           color: Colors.red[600],
                           borderRadius: BorderRadius.all(Radius.circular(5))
                         ),
                         child: const Center(
                           child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 16)),
                         ),
                       ),
                     )
                   ],
                 )
               ],
             ),
           ),
        );
      }
    );
  }

  Future deleteResult() async {
    Map<String, String> header = {
      'Content-Type':'application/json',
      'authorization':'Bearer ${widget.token}'
    };
    Map<String, String> param = {
      'id':"${widget.gameId}"
    };

    final response = await gameViewModel.deleteResult(header, param);
    if(response == '200') {
      getBidData();
    }
  }

  Future getBidByDate() async {
    Map<String, String> header = {
      'Content-Type':'application/json',
      'authorization':'Bearer ${widget.token}'
    };
    Map<String, String> param = {
      'id': widget.gameId.toString(),
      'resultDate':selectDate.toString()
    };
    final response = await gameViewModel.getBidByDate(header, param);
    try {
      log(response!.body.toString());
      if(jsonDecode(response!.body)['type']=='success') {
        showFilterData(jsonDecode(response!.body));
      } else {
        setState(() {
          bidList = [];
          andarList = [];
          baharList = [];
          maxBids = [];
          minBids = [];
        });
      }
    } catch(exp) {
      log(exp.toString());
      setState(() {
        bidList = [];
        andarList = [];
        baharList = [];
        maxBids = [];
        minBids = [];
      });
    }
  }

  Future getAllDealer() async {
    try {
      Map<String, String> header = {
        'Content-Type':'application/json',
        'authorization':'Bearer ${widget.token}'
      };
      final response = await http.get(
          Uri.parse('${ApiService.BASE_URL}api/web/retrieve/dealers'),
         headers: header
      );
      log('Dealer Response : '+ response.body.toString());
      if(response.statusCode == 200 && jsonDecode(response.body)['type'] == 'success') {
        log('hello');
        final list = jsonDecode(response.body)['data']['dealers'] as List;
        for(var item in list) {
          dealerList.add(
              {'id': item['id'].toString(), 'name': item['name'].toString()}
          );
        }
            setState(() {
              dealerList;
            });
      }
    } catch(exp) {
      log(exp.toString());
    }
  }

  List<dynamic>? dealerByList;
  Future getBidByDealer() async {
    Map<String, String> header = {
      'Content-Type':'application/json',
      'authorization':'Bearer ${widget.token}'
    };
    Map<String, String> param = {
      'dealerId': selectedDealerId,
      'gameId': widget.gameId
    };
    final response = await http.get(
      Uri.parse('${ApiService.BASE_URL}api/web/retrieve/bids-by-dealer-id').replace(queryParameters: param),
      headers: header
    );
    try {
      log(response!.body.toString());
      if(jsonDecode(response!.body)['type']=='success') {
        dealerByList = jsonDecode(response.body)['data'];
        filterData();
      } else {
        resetPage();
      }
    } catch(exp) {
      log(exp.toString());
      resetPage();
    }
  }

  filterData() {
    bidList = [];
    andarList = [];
    baharList = [];
    totalAmount = '0';

    for(var item in dealerByList!) {
      BidModel bidModel = BidModel(item['insideNumbers'], item['outsideNumbers'], item['bidNumbers'], '0', item['bidAmount']);
      List? bids;
      List? inside;
      List? outside;
      if(bidModel.bids != null) {
        bids = jsonDecode(bidModel.bids).cast<Map<String, dynamic>>().toList();
      }
      if(bidModel.inside != null) {
        inside = jsonDecode(bidModel.inside).cast<Map<String, dynamic>>().toList();
      }
      if(bidModel.outside != null) {
        outside = jsonDecode(bidModel.outside).cast<Map<String, dynamic>>().toList();
      }
      log(bids.toString());
      if(bids != null) {
        log('inside');
        for (int i = 0; i < bids.length; i++) {
          log('Api Bid : ' + bids[i]['number'].toString());
          try {
            Map<String, String>? alreadyBid = bidList?.where((item) => (item['number'] == bids![i]['number'].toString())).single;
            log('Already Bid : '+ alreadyBid.toString());
            if(alreadyBid != null) {
              bidList?.where((item) => (item['number'] == bids![i]['number'])).single['amount'] = (int.parse(alreadyBid['amount'].toString()) + int.parse(bids[i]['amount'])).toString();
            }
          } catch(exp) {
            bidList!.add(
                {
                  'number':bids[i]['number'].toString(),
                  'amount':bids[i]['amount'].toString()
                }
            );
          }
        }
      }
      if(inside != null) {
        for (int i = 0; i < inside.length; i++) {
          try {
            Map<String, String>? alreadyBid = andarList?.where((item) => (item['number'] == inside![i]['number'].toString())).single;
            if(alreadyBid != null) {
              andarList?.where((item) => (item['number'] == inside![i]['number'])).single['amount'] = (int.parse(alreadyBid['amount'].toString()) + int.parse(inside[i]['amount'])).toString();
            }
          } catch(exp) {
            andarList!.add(
                {
                  'number':inside[i]['number'].toString(),
                  'amount':inside[i]['amount'].toString()
                }
            );
          }
        }
      }
      if(outside != null) {
        for (int i = 0; i < outside.length; i++) {
          try {
            Map<String, String>? alreadyBid = baharList?.where((item) => (item['number'] == outside![i]['number'].toString())).single;
            if(alreadyBid != null) {
              baharList?.where((item) => (item['number'] == outside![i]['number'])).single['amount'] = (int.parse(alreadyBid['amount'].toString()) + int.parse(outside[i]['amount'])).toString();
            }
          } catch(exp) {
            baharList!.add(
                {
                  'number':outside[i]['number'].toString(),
                  'amount':outside[i]['amount'].toString()
                }
            );
          }
        }
      }
      setState(() {
        bidList;
        andarList;
        baharList;
      });
      final sortList = bidList;
      for(int i = 0; i < sortList!.length; i++) {
        for(int j = 0; j < bidList!.length; j++) {
          if(int.parse(sortList![i]['amount']!) < int.parse(bidList![j]['amount']!)) {
            var item = sortList![i];
            sortList![i] = bidList![j];
            sortList![j] = item;
          }
        }
      }

      if(bidModel.collectedBidAmount != null) {
        totalAmount = (int.parse(totalAmount.toString()) + int.parse(bidModel.collectedBidAmount)).toString();
      }
    }
    final sortList = bidList;
    for(int i = 0; i < sortList!.length; i++) {
      for(int j = 0; j < bidList!.length; j++) {
        if(int.parse(sortList![i]['amount']!) < int.parse(bidList![j]['amount']!)) {
          var item = sortList![i];
          sortList![i] = bidList![j];
          sortList![j] = item;
        }
      }
    }
    if(sortList.length > 10) {
      maxBids = sortList.sublist(0, 10);
      minBids = sortList.reversed.toList().sublist(0, 10);
    } else {
      maxBids = sortList;
      minBids = sortList.reversed.toList();
    }

    setState(() {
      totalAmount;
      minBids.reversed;
      maxBids.reversed;
    });
  }



  resetPage() {
    setState(() {
      bidList = [];
      andarList = [];
      baharList = [];
      maxBids = [];
      minBids = [];
    });
  }
}
