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

class SeeJantri extends StatefulWidget {
  const SeeJantri({super.key, required this.bidList, required this.totalAmount});
  final List<Map<String, String>>? bidList;
  final String totalAmount;

  @override
  State<StatefulWidget> createState() => _SeeJantriState();
}

class _SeeJantriState extends State<SeeJantri> {
  BidModel? bidData;
  List<Map<String, String>>? bidList = [];
  List<Map<String, String>>? andarList = [];
  List<Map<String, String>>? baharList = [];

  @override
  void initState() {
    super.initState();
    initList();
  }

  initList() {
    log('Init Method Call');
    bidList = widget.bidList?.where((item) => (item['type'] != 'ANDAR' && item['type'] != 'BAHAR')).toList();
    andarList = widget.bidList?.where((item) => item['type'] == 'ANDAR').toList();
    baharList = widget.bidList?.where((item) => item['type'] == 'BAHAR').toList();
    log(bidList.toString());
    log(andarList.toString());
    log(baharList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffafb9b7),
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 30,
                    width: 1000,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('JANTRI',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                        Text('Total Bet : ₹${widget.totalAmount}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 350,
                              width: 1000,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 100,
                                  crossAxisCount: 10,
                                  crossAxisSpacing: 0,
                                  // childAspectRatio: 0.5,
                                ),
                                itemBuilder: (context, i) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        (i == 99) ? "00" : (i < 9) ? "0${i+1}" : (i+1).toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        height: 30,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            /*borderRadius:
                                            const BorderRadius.all(Radius.circular(1)),*/
                                            border: Border.all(color: Colors.grey, width: 0.2)),
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
                                              hintText:bidList!.isEmpty ? '' : showBid((i == 99) ? "00" : (i < 9) ? "0${i+1}" : (i+1).toString(), bidList!, 'SINGLE'),
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
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  height: 30,
                                  // width: 100,
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff9a7662),
                                      border: Border.all(color: Colors.white, width: 2),
                                      borderRadius: const BorderRadius.all(Radius.circular(2))
                                  ),
                                  child: const Center(child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_back, color: Colors.black, size: 15),
                                      SizedBox(width: 5,),
                                      Text('BACK', style: TextStyle(color: Colors.black, fontSize: 16),),
                                    ],
                                  ))),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          // width: 1000,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int i) {
                                return SizedBox(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      /*Text(().toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(width: 5),*/
                                      Container(
                                        height: 30,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(color: Colors.grey, width: 0.2)),
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
                                              hintText:bidList!.isEmpty ? '' : showBid((i).toString(), bidList!, 'TOTAL'),
                                              contentPadding: const EdgeInsets.only(
                                                  bottom: 18, left: 5, right: 5),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'ANDAR',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 40,
                              width: 1000,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: 10,
                                  itemBuilder: (BuildContext context, int i) {
                                    return SizedBox(
                                      width: 100,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text((i != 9) ? (i+1).toString() : '0',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
                                          const SizedBox(width: 5),
                                          Container(
                                            height: 30,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(color: Colors.grey, width: 0.2)),
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
                                                  hintText:andarList!.isEmpty ? '' : showBid((i != 9) ? (i+1).toString() : '0', andarList!, 'ANDAR'),
                                                  contentPadding: EdgeInsets.only(
                                                      bottom: 18, left: 5, right: 5),
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 30,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey, width: 0.2)),
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
                                    hintText:andarList!.isEmpty ? '' : showBid(().toString(), andarList!, 'TOTAL ANDAR'),
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 18, left: 5, right: 5),
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
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
                        Row(
                          children: [
                            SizedBox(
                              height: 40,
                              // width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: 10,
                                  itemBuilder: (BuildContext context, int i) {
                                    return SizedBox(
                                      width: 100,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text((i != 9) ? (i+1).toString() : '0',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
                                          const SizedBox(width: 5),
                                          Container(
                                            height: 30,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(color: Colors.grey, width: 0.2)),
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
                                                  hintText:baharList!.isEmpty ? '' : showBid((i != 9) ? (i+1).toString() : '0', baharList!, 'BAHAR'),
                                                  contentPadding: EdgeInsets.only(
                                                      bottom: 18, left: 5, right: 5),
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 30,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey, width: 0.2)),
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
                                    hintText:baharList!.isEmpty ? '' : showBid(().toString(), baharList!, 'TOTAL BAHAR'),
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 18, left: 5, right: 5),
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )

                ]),
          ),
        ),
      ),
    );
  }



/*  showData(BidModel model) {
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

  }*/

  String showBid(String num, List<Map<String, String>> list, String type) {
    log('Game Type : $type');
    int retBid = 0;
    if(type == 'SINGLE') {
      for(int i = 0; i < list!.length; i++) {
        if(list![i]['number'] == num) {
          retBid += int.parse(list![i]['amount'].toString());
        }
      }
    }

    if(type == 'ANDAR') {
      for(int i = 0; i < list.length; i = i + 10) {
        if(list[i]['number']?[0] == num) {
          retBid += 10 * int.parse(list[i]['amount'].toString());
        }
      }
    }

    if(type == 'BAHAR') {
      for(int i = 0; i < list.length; i = i + 10) {
        if(list[i]['number']?[1] == num) {
          retBid += 10 * int.parse(list[i]['amount'].toString());
        }
      }
    }

    if(type == 'TOTAL') {
      var li = list.where((item) => (item['number']?[0] == num || item['number'] == '${int.parse(num)+1}0') && item['number'] != '${num}0').toList();
      if(num == '9') {
        try {
          li.add(list.where((item) => item['number'] == '00').single);
        } catch(exp) {
          log(exp.toString());
        }
      }
      for(var item in li) {
        retBid += int.parse(item['amount']!);
      }
    }

    if(type == 'TOTAL ANDAR') {
      for(var item in list) {
        retBid += int.parse(item['amount']!);
      }
    }

    if(type == 'TOTAL BAHAR') {
      for(var item in list) {
        retBid += int.parse(item['amount']!);
      }
    }

    return retBid == 0 ? '' : retBid.toString();
  }



/*  filterData() {
    bidList = [];
    andarList = [];
    baharList = [];
    totalAmount = '0';

    *//*for(var item in dealerByList!) {
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
    }*//*
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
  }*/


}
