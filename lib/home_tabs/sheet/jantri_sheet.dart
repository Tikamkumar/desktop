import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:betting/Components/custom_dropdown.dart';
import 'package:betting/data/remote/api_service.dart';
import 'package:betting/home_tabs/sheet/see_jantri.dart';
import 'package:betting/model/dealer_model.dart';
import 'package:betting/dashboard.dart';
import 'package:betting/view_models/GameViewModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:dartx/dartx.dart';
import '../../view_models/DealerViewModel.dart';

class Jantri extends StatefulWidget {
  const Jantri({super.key, required this.token});
  final token;
  @override
  State<StatefulWidget> createState() => _JantriState();
}

class _JantriState extends State<Jantri> {
  String selectDate = 'Select Date';
  String selectDealerNumber = 'Numbers';
  String? endTime;
  Timer? _timer;
  TextEditingController besisController = TextEditingController();
  TextEditingController singleController = TextEditingController();
  TextEditingController andarController = TextEditingController();
  TextEditingController baharController = TextEditingController();
  TextEditingController partPerController = TextEditingController();
  List<TextEditingController> singleControllers = [];
  List<TextEditingController> andarControllers = [];
  List<TextEditingController> baharControllers = [];
  GameViewModel gameViewModel = GameViewModel();
  DealerViewModel dealerViewModel = DealerViewModel();
  bool isLoading = false;
  List<Map<String, String>> gameList = [];
  int sheetNo = 0;
  String? selectGameId;
  String? selectSheetNo;
  List<Map<String, String>> dealerList = [];
  String? selectDealerId;
  List<Map<String, String>> openDealerList = [];
  String? selectOpenDealerId;
  List<Map<String, String>> singleBids = List.generate(
      100, (i) => {'number': i < 10 ? '0${i}' : '$i', 'amount': ''});
  // List<Map<String, String>> singleBids = [];
  List<Map<String, String>> andarBids = List.generate(
      10, (i) => {'number': i < 10 ? '0${i}' : '$i', 'amount': ''});
  List<Map<String, String>> baharBids = List.generate(
      10, (i) => {'number': i < 10 ? '0${i}' : '$i', 'amount': ''});
  double totalAmount = 0;
  bool isEditBtnShow = false;
  List<String> inputBidsText = List.generate(100, (index) => '');

  @override
  void dispose() {
    super.dispose();
    singleController.dispose();
    andarController.dispose();
    baharController.dispose();
    partPerController.dispose();
    for(var list in [singleControllers, andarControllers, baharControllers]) {
      for(var bid in list) {
        bid.dispose();
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    log(selectDate);
    initControllers();
    // fetchGame();
  }

  initControllers() {
    for(int i = 0; i < singleBids.length; i++) {
      if(singleControllers.length != singleBids.length) {
        singleControllers.add(TextEditingController(text: singleBids[i]['amount']));
      } else {
        singleControllers[i] = TextEditingController(text: singleBids[i]['amount'].toString());
      }
    }
    for(int i = 0; i < andarBids.length; i++) {
      if(andarControllers.length != andarBids.length) {
        andarControllers.add(TextEditingController(text: andarBids[i]['amount']));
      } else {
        andarControllers[i] = TextEditingController(text: andarBids[i]['amount'].toString());
      }
    }
    for(int i = 0; i < baharBids.length; i++) {
      if(baharControllers.length != baharBids.length) {
        baharControllers.add(TextEditingController(text: baharBids[i]['amount']));
      } else {
        baharControllers[i] = TextEditingController(text: baharBids[i]['amount'].toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return/* Scaffold(
      body: SingleChildScrollView(
        child: */SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 160),
                                CustomDropDown(selectId: selectOpenDealerId, dataList: openDealerList, hint: 'Select Dealer'),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: 150,
                                  height: 30,
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.3),
                                      borderRadius: const BorderRadius.all(Radius.circular(2))),
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(selectDealerNumber, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 150,
                                  height: 30,
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.3),
                                      borderRadius: const BorderRadius.all(Radius.circular(2))),
                                  padding: const EdgeInsets.only(left: 5),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      iconEnabledColor: Colors.grey[300],
                                      // iconDisabledColor: Colors.white,
                                      dropdownColor: Colors.grey[100],
                                      isExpanded: true,
                                      value: selectGameId,
                                      items: gameList.map((item) {
                                        return DropdownMenuItem(
                                          value: item['id'],
                                          child: Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.w400)),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        selectGameId = value!;
                                        endTime = gameList.where((item) => item['id'] == selectGameId).single['end'];
                                        showTimer(endTime!);
                                        setState(() {});
                                      },
                                      hint: Text('Select Game'),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  height: 30,
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.3),
                                      borderRadius: const BorderRadius.all(Radius.circular(2))),
                                  padding: const EdgeInsets.only(left: 5),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      iconEnabledColor: Colors.grey[300],
                                      // iconDisabledColor: Colors.white,
                                      dropdownColor: Colors.grey[100],
                                      isExpanded: true,
                                      value: selectDealerId,
                                      items: dealerList.map((item) {
                                        return DropdownMenuItem(
                                          value: item['id'],
                                          child: Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.w400)),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        selectDealerId = value!;
                                        selectDealerNumber = dealerList.where((item) => item['id'] == selectDealerId!).single['mobile'].toString();
                                        setState(() {});
                                      },
                                      hint: Text('Select Dealer'),
                                    ),
                                  ),
                                ),
                                /*Container(
                    width: 200,
                    height: 30,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.3),
                        borderRadius: const BorderRadius.all(Radius.circular(2))),
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectGameId,
                        items: gameList.map((item) {
                          return DropdownMenuItem(
                            value: item['id'],
                            child: Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.w500)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectGameId = value!;
                          });
                        },
                        hint: Text('Select Game'),
                      ),
                    ),
                  ),*/
                                /*Container(
                    width: 250,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.5),
                        borderRadius: const BorderRadius.all(Radius.circular(8))),
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectDealerId,
                        items: dealerList.map((item) {
                          return DropdownMenuItem(
                            child: Text(item['name']!),
                            value: item['id'],
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectDealerId = value!;
                          });
                          fetchSheetNo();
                        },
                        hint: Text('Select dealer'),
                      ),
                    ),
                  ),*/
                                // const SizedBox(width: 10),
                                /*Container(
                    width: 250,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectOpenDealerId,
                        items: openDealerList.map((item) {
                          return DropdownMenuItem(
                            value: item['id'],
                            child: Text(item['name']!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectOpenDealerId = value!;
                          });
                        },
                        hint: Text('Open dealer'),
                      ),
                    ),
                  ),*/
                                // const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: pickDate,
                                  child: Container(
                                      width: 150,
                                      height: 30,
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey, width: 0.5),
                                      ),
                                      padding: const EdgeInsets.only(left: 5),
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        textAlignVertical: TextAlignVertical.center,
                                        enabled: false,
                                        decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(bottom: 15),
                                            suffixIcon: Icon(
                                              Icons.arrow_drop_down,
                                              size: 18,
                                              color: Colors.grey[300],
                                            ),
                                            border: InputBorder.none,
                                            hintText: selectDate,
                                            hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                                      )),
                                ),
                                // const SizedBox(width: 50),
                                Container(
                                    width: 50,
                                    height: 30,
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey, width: 0.3),
                                        borderRadius: const BorderRadius.all(Radius.circular(2))),
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('$sheetNo',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal)),
                                        Icon(Icons.arrow_drop_down, color: Colors.grey[200],)
                                      ],
                                    )
                                ),
                                const SizedBox(width: 30),
                                const Text('B', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                const SizedBox(width: 5),
                                Container(
                                  width: 60,
                                  height: 30,
                                  color: Colors.white,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: besisController,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: const InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text('%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(left: 100),
                                  // height: 25,
                                  width: 200,
                                  color: Colors.blue[800],
                                  child: Text(_countDownValue, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)),
                                ),
                                const SizedBox(width: 20),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey, width: 0.5),
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(5))
                                  ),
                                  child: Text(_countDownValue == '00:00:00' ? 'Finished' : 'Pending'),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black, width: 0.5),
                                      borderRadius: const BorderRadius.all(Radius.circular(2))
                                  ),
                                  child: const Center(child: Text('CREDITS', style: TextStyle(fontSize: 15))),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  width: 120,
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black, width: 0.5),
                                      borderRadius: const BorderRadius.all(Radius.circular(2))
                                  ),
                                  child: const Center(child: Text('UNLIMITED', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black, width: 0.5),
                                      borderRadius: const BorderRadius.all(Radius.circular(2))
                                  ),
                                  child: const Center(child: Text('TOTAL', style: TextStyle(fontSize: 15))),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  width: 120,
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black, width: 0.5),
                                      borderRadius: const BorderRadius.all(Radius.circular(2))
                                  ),
                                  child: Center(child: Text(totalAmt(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            // customButton('SEE JANTRI', () => Navigator.push(context, MaterialPageRoute(builder: (context) => SeeJantri(bidList: selectedNumber, totalAmount: totalAmt(selectedNumber)))), Colors.blueGrey),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 0.5),),
                          padding: const EdgeInsets.only(left: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectGameId,
                              items: gameList.map((item) {
                                return DropdownMenuItem(
                                  value: item['id'],
                                  child: Text(item['name']!),
                                );
                              }).toList(),
                              onChanged: (value) {
                                 setState(() {
                                   selectGameId = value!!;
                                 });
                              },
                              hint: Text('Select Game'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: pickDate,
                          child: Container(
                              width: 150,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey, width: 0.5)),
                              padding: const EdgeInsets.only(left: 10),
                              child: TextField(
                                // textAlignVertical: TextAlignVertical.top,
                                enabled: false,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    suffixIcon: const Icon(
                                      Icons.arrow_drop_down,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                    hintText: selectDate,
                                    hintStyle: const TextStyle(color: Colors.black)),
                              )),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 0.5)),
                          padding: EdgeInsets.only(left: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectDealerId,
                              items: dealerList.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item['name']!),
                                  value: item['id'],
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectDealerId = value!!;
                                });
                                fetchSheetNo();
                                fetchAllSheet();
                              },
                              hint: Text('Select dealer'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 0.5)),
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(sheetNo.toString()),
                              const Icon(Icons.arrow_drop_down, color: Colors.grey)
                            ],
                          )
                        ),
                        const SizedBox(width: 10),
                        const Text('B', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                        Container(
                          width: 60,
                          height: 30,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 0.5)),
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true
                            ),
                            
                          )
                        ),
                        const Text('%', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(width: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: const BorderRadius.all(Radius.circular(5))
                          ),
                          child: const Center(child: Text('Pending', style: TextStyle(color: Colors.white))),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 0.5)),
                          padding: EdgeInsets.only(left: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectOpenDealerId,
                              items: openDealerList.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item['name']!),
                                  value: item['id'],
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectOpenDealerId = value!!;
                                });
                              },
                              hint: Text('Open dealer'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 0.5)),
                          // padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: TextField(
                            // textAlignVertical: TextAlignVertical.top,
                            controller: partPerController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: 'Partner Percent',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero
                            ),
                          )
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: createBids,
                          child: Container(
                              height: 40,
                              width: 100,
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              margin: const EdgeInsets.only(right: 50),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: Colors.white, width: 2)
                              ),
                              child: Center(
                                child: !isLoading ? const Text('SUBMIT',
                                  style: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),) : const SizedBox( height: 15, width:15, child: CircularProgressIndicator(color: Colors.white, strokeWidth:  2,))
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          padding: EdgeInsets.only(left: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectSheetNo,
                              items: List.generate(sheetNo+1, (index) {
                                 return DropdownMenuItem(child: Text(index == 0 ? 'None' : '${index}'), value: '${index}');
                              }),

                              onChanged: (value) {
                                setState(() {
                                  selectSheetNo = value!!;
                                  isEditBtnShow = (sheetNo != 0 && selectSheetNo != '0') ? true : false;
                                });
                                if(selectSheetNo != null && selectSheetNo != '0') {
                                  showData();
                                }
                                if(selectSheetNo == '0') {
                                  resetForm();
                                }
                              },
                              hint: Text('Select Sheet No'),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        isEditBtnShow ? GestureDetector(
                          onTap: updateBids,
                          child: Container(
                              height: 40,
                              width: 100,
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              margin: EdgeInsets.only(right: 50),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: Colors.white, width: 2)
                              ),
                              child: Center(
                                  child: !isLoading ? Text('EDIT',
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),) : SizedBox( height: 15, width:15, child: CircularProgressIndicator(color: Colors.white, strokeWidth:  2,))
                              )),
                        ) : Container(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 320,
                      width: 1000,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 100,
                          crossAxisCount: 10,
                          crossAxisSpacing: 1,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, i) {
                          return Row(
                            children: <Widget>[
                              Text(
                                (i == 99) ? "00" : (i < 9) ? "0${i+1}" : (i+1).toString(),
                                style: const TextStyle(color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),),
                              const SizedBox(width: 5),
                              Container(
                                height: 30,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey)
                                ),
                                child: TextField(
                                    controller: singleControllers[(i == 99) ? 00 : (i < 9) ? 0 : (i+1)],
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) {
                                      singleBids[(i == 99) ? 00 : (i < 9) ? 0 : (i+1)]['amount'] = value;
                                      totalAmountCalc();
                                    },
                                    maxLines: 1,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            bottom: 18, left: 5, right: 5),
                                        border: InputBorder.none)
                                ),
                              )

                            ],
                          );
                        },
                        /* } else {
                            return Padding(
                              padding: const EdgeInsets.only(right: 35, top: 10),
                              child: Text('0', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.purple),),
                            );
                          }
                        },*/
                        itemCount: 100,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('ANDAR', style: TextStyle(color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),),
                    SizedBox(
                      height: 30,
                      width: 1000,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int i) {
                            return SizedBox(
                              width: 100,
                              child: Row(
                                // mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text((i != 9) ? (i+1).toString() : '0', style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                                  const SizedBox(width: 5),
                                  Container(
                                    height: 30,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey)
                                    ),
                                    child: TextField(
                                      controller: andarControllers[(i != 9) ? (i+1) : 0],
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (value) {
                                        andarBids[i]['amount'] = value;
                                        totalAmountCalc();
                                      },
                                      maxLines: 1,
                                      textAlignVertical: TextAlignVertical.center,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              bottom: 18, left: 5, right: 5),
                                          border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),

                                ],
                              ),
                            );
                          }),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text('BAHAR', style: TextStyle(color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(
                      height: 40,
                      width: 1000,
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
                                  Text((i != 9) ? (i+1).toString() : '0', style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                                  const SizedBox(width: 5),
                                  Container(
                                    height: 30,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey)
                                    ),
                                    child: TextField(
                                      controller: baharControllers[(i != 9) ? (i+1) : 0],
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (value) {
                                        baharBids[i]['amount'] = value;
                                        totalAmountCalc();
                                      },
                                      maxLines: 1,
                                      textAlignVertical: TextAlignVertical.center,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              bottom: 18, left: 5, right: 5),
                                          border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),

                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Total Amount : ₹$totalAmount', style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20)),
                      ],
                    )
                  ]
              ),
            ),
          ),
        );
      /*),
    );*/
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

  resetForm() {
    singleControllers[10] = TextEditingController(text: '50');
    singleBids = List.generate(100, (i) => {'number': '$i', 'amount': ''});
    andarBids = List.generate(10, (i) => {'number': '$i', 'amount': ''});
    baharBids = List.generate(10, (i) => {'number': '$i', 'amount': ''});
    for(int i = 0; i < singleBids.length; i++) {
      singleControllers[i] = TextEditingController(text: singleBids[i]['amount'].toString());
    }
    for(int i = 0; i < andarBids.length; i++) {
      andarControllers[i] = TextEditingController(text: andarBids[i]['amount'].toString());
    }
    for(int i = 0; i < baharBids.length; i++) {
      baharControllers[i] = TextEditingController(text: baharBids[i]['amount'].toString());
    }
    totalAmount = 0;
   setState(() {});
  }

  totalAmountCalc() {
    // log('total amount call');
    totalAmount = 0;
    for(int i = 0; i < singleBids.length; i++) {
      if(singleBids[i]['amount'] != '') {
        totalAmount += int.parse(singleBids[i]['amount'].toString());
      }
    }
    for(int i = 0; i < andarBids.length; i++) {
      if(andarBids[i]['amount'] != '') {
        totalAmount += int.parse(andarBids[i]['amount'].toString());
      }
    }
    for(int i = 0; i < baharBids.length; i++) {
      if(baharBids[i]['amount'] != '') {
        totalAmount += int.parse(baharBids[i]['amount'].toString());
      }
    }
    setState(() {
      totalAmount;
    });
    /*
    *//*for (int i = 0; i < singleBids.length; i++) {
      totalAmount += int.parse(singleBids[i]['amount'].toString());
    }*//*
    log(singleBids.toString());
    log(totalAmount.toString());*/
    /*singleBids.where((item) => item['amount'] != '0' && item['amount'] != '').toList().map((item) {
      log(item.toString());
        totalAmount += int.parse(item['amount'].toString());
    });
    andarBids.where((item) => item['amount'] != '0' && item['amount'] != '').toList().map((item) {
      log(item.toString());
      totalAmount += int.parse(item['amount'].toString());
    });
    baharBids.where((item) => item['amount'] != '0' && item['amount'] != '').toList().map((item) {
      log(item.toString());
      totalAmount += int.parse(item['amount'].toString());
    });
    var singleAmt = singleBids.map((item) => item['amount']).toList();
    var andarAmt = andarBids.map((item) => item['amount']).toList();
    var baharAmt = baharBids.map((item) => item['amount']).toList();
    for (int i = 0; i < singleAmt.length; i++) {
      if (singleAmt[i]!.isEmpty) {
        singleAmt[i] = "0";
      }
      totalAmount += int.parse(singleAmt[i].toString());
    }
    for (int i = 0; i < andarAmt.length; i++) {
      if (andarAmt[i]!.isEmpty) {
        andarAmt[i] = "0";
      }
      totalAmount += int.parse(andarAmt[i].toString());
    }
    for (int i = 0; i < baharAmt.length; i++) {
      if (baharAmt[i]!.isEmpty) {
        baharAmt[i] = "0";
      }
      totalAmount += int.parse(baharAmt[i].toString());
    }*/
    /*setState(() {
      // totalAmount;
    });*/
  }

 /* Future fetchGame() async {
     Map<String, String> header = {
       'Content-Type': 'application/json',
       'authorization': 'Bearer ${widget.token}'
     };
     *//*Map<String, String> param = {
       'startDateTime':selectDate
     };*//*
     final response = await gameViewModel.getAllGames(header);
     log(response.toString());
     gameList = response!.map((model) => {'id': model.id.toString(), 'name': model.name.toString()}).toList();
     selectGameId = gameList[0]['id']!;
     if(selectGameId != null) {
       fetchDealer();
       fetchOpenDealers();
     }
     log('Reponse : $gameList');
     setState(() {
       gameList;
     });
  }*/

  Future fetchDealer() async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    List<DealerModel>? list = (await dealerViewModel.getAllDealers(header));
    log(list.toString());
    dealerList = List.generate(list!.length, (index) => {'id': list[index].id.toString(), 'name': list[index].name.toString()});
    selectDealerId = dealerList[0]['id'].toString();
    if(selectDealerId != null) {
      fetchSheetNo();
      fetchAllSheet();
    }
    log(dealerList.toString());
    setState(() {
      dealerList;
    });
  }

  Future fetchOpenDealers() async {
    log('Open Dealer Call');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    Map<String, String> param = {
      'startDateTime': selectDate
    };
    openDealerList = (await dealerViewModel.getAllOpenDealers(header, param))!;
    log('Open Dealer List'+ openDealerList.toString());
    selectOpenDealerId = openDealerList[0]['id'].toString();


    setState(() {
      openDealerList;
    });
  }

  Future fetchSheetNo() async {
    log(selectDealerId!);
    log(selectGameId!);
    log('hello');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    Map<String, dynamic> param = {
      'dealerId': selectDealerId!,
      'gameId': selectGameId!
      // 'startDateTime':'${DateTime.now()}'
    };
    final response = (await gameViewModel.getSheetNo(header, param));
    log('Sheet No : '+ response.toString());
    try {
      sheetNo = response?['sheetNo'] != null ? int.parse(response!['sheetNo']!) : 0;
    } catch(exp) {
      log(exp.toString());
    }
    // log(response!.body.toString());

    setState(() {
      sheetNo;
    });
  }

  http.Response? sheetResponse;
  Future fetchAllSheet() async {
    log('Dealer Id : '+ selectDealerId.toString());
    log('Game Id : '+ selectGameId.toString());
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    Map<String, dynamic> param = {
      'dealerId': selectDealerId!,
      'gameId': selectGameId!
    };
    sheetResponse = (await gameViewModel.getAllSheet(header, param));

    // showDate()
    /*try {
      sheetNo = response?['sheetNo'] != null ? int.parse(response!['sheetNo']!) : 0;
    } catch(exp) {
      log(exp.toString());
    }*/
    // log(response!.body.toString());

    setState(() {
      sheetNo;
    });
  }

  showData() {
    final body = jsonDecode(sheetResponse!.body);
    final item = (body['data'] as List).where((item) => item['sheetNo'].toString() == selectSheetNo).single;
    singleBids = List.generate(100, (index) {return {'number': (index < 10) ? '0$index' : '$index', 'amount': ''};});
    this.andarBids = List.generate(10, (index) {return {'number': '0$index', 'amount': ''};});
    this.baharBids = List.generate(10, (index) {return {'number': '0$index', 'amount': ''};});

    List? bids = json.decode(item['bidNumbers']).toList();
    List? andarBids = json.decode(item['insideNumbers']).toList();
    List baharBids = json.decode(item['outsideNumbers']).toList();

    if(bids != null) {
      for(var bid in bids) {
        singleBids.where((item) => item['number'] == bid['number']).single['amount'] = bid['amount'];
      }
    }

    if(andarBids != null) {
      for(var bid in andarBids) {
        this.andarBids.where((item) => item['number'] == bid['number']).single['amount'] = bid['amount'];
      }
    }

    if(baharBids != null) {
      for(var bid in baharBids) {
        this.baharBids.where((item) => item['number'] == bid['number']).single['amount'] = bid['amount'];
      }
    }

    initControllers();
    totalAmountCalc();

   /* for(var field in singleBids) {
      for(var bid in bids) {
        if(field['number'] == bid['number'].toString()) {
          singleBids.where((item) => item['number'] == bid['number'].toString()).single['amount'] = bid['amount'].toString();
          log('${singleBids.where((item) => item['number'] == bid['number'].toString())}');
          log(singleBids.toString());
        } else {
          singleBids.where((item) => item['number'] == bid['number'].toString()).single['amount'] = '';
        }
      }*/

    // log(singleBids.toString());
    // log('Single Bids : '+ singleBids.toString());

  /*  for (int i = 0; i < bids.length; i++) {
      singleBids!.add({
        'number': '${bids[i]['number']}',
        'amount': bids[i]['amount'].toString()
      });
    }*/

    /*List inside = json.decode(item['insideNumbers']).toList();
    for (int i = 0; i < inside.length; i++) {
      andarBids!.add({
        'number': inside[i]['number'].toString(),
        'amount': inside[i]['amount'].toString()
      });
    }
    log(andarBids.toString());
    List outside = json.decode(item['outsideNumbers']).toList();
    for (int i = 0; i < inside.length; i++) {
      baharBids!.add({
        'number': outside[i]['number'].toString(),
        'amount': outside[i]['amount'].toString()
      });
    }
    log(baharBids.toString());


    List outside = json.decode(model.outside).cast<Map<String, dynamic>>().toList();
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
    if(sortList.length > 10) {
      maxBids = sortList.sublist(0, 10);
      minBids = sortList.reversed.toList().sublist(0, 10);
    } else {
      maxBids = sortList;
      minBids = sortList.reversed.toList();
    }

    totalAmount = (-model.collectedBidAmount).toString();
    resultController.text =
    model.finalBidNumber != null ? model.finalBidNumber.toString() : '';

    setState(() {
      totalAmount;
      minBids;
      maxBids;
    });*/
  }

  String _countDownValue = '00:00:00';
  showTimer(String time) {
    _timer?.cancel();
    DateTime endDateTime = DateTime.parse(time);
    final currentDateTime = DateTime.now();

    double difference = endDateTime.difference(currentDateTime).inSeconds - (5.5 * 60 * 60);
    int diffSecond = difference.toInt();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int sec = (diffSecond--);
      int hours = sec ~/ 3600;
      int minute = (sec - (hours*3600)) ~/ 60;
      int seconds = sec - (hours * 3600) - (minute * 60);

      _countDownValue =  !seconds.isNegative ? '$hours:$minute:$seconds' : '00:00:00';
      setState(() {});
    });
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
      // fetchGame();
      fetchOpenDealers();
    }
  }

  Future createBids() async {
    setState(() {
      isLoading = true;
    });
    log(partPerController.text);
    List<Map<String, String>> bids = singleBids.where((bid) => bid['amount'] != '' && bid['amount'] != '0').toList();
    List<Map<String, String>> andarbids = andarBids.where((bid) => bid['amount'] != '' && bid['amount'] != '0').toList();
    List<Map<String, String>> baharbids = baharBids.where((bid) => bid['amount'] != '' && bid['amount'] != '0').toList();
    log(bids.toString());
    log(andarbids.toString());
    log(baharbids.toString());

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    Object body = jsonEncode({
      'gameId':selectGameId,
      'bidAmount':totalAmount,
      'dealerId':selectDealerId,
      'bidNumbers':bids,
      'insideNumbers':andarbids,
      'outsideNumbers':baharbids,
      'partnerCommission':partPerController.text.isEmpty ? '0' : partPerController.text
    });
    final response = (await gameViewModel.createJantriBids(header, body));
    if(response == '201') {
      fetchOpenDealers();
      fetchSheetNo();
      fetchAllSheet();
      setState(() {
        isLoading = false;
      });
      resetForm();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bids Created Successfully...', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),), backgroundColor: Colors.green));
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.toString())['message'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),), backgroundColor: Colors.red));
    }
    log(response.toString());
  }

  Widget customButton(String title, Function()? onTap, Color backgroundColor) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 120,
        height: 30,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(3))
        ),
        child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16)),
      ),
    );
  }


  Future updateBids() async {
    try {
      final sheetRes = jsonDecode(sheetResponse!.body);
      String? bidId = (sheetRes['data'] as List).where((item) => item['sheetNo'].toString() == selectSheetNo).single['id'].toString();
      List<Map<String, String>> bids = singleBids.where((bid) => bid['amount'] != '' && bid['amount'] != '0').toList();
      List<Map<String, String>> andarbids = andarBids.where((bid) => bid['amount'] != '' && bid['amount'] != '0').toList();
      List<Map<String, String>> baharbids = baharBids.where((bid) => bid['amount'] != '' && bid['amount'] != '0').toList();
      Map<String, String> header = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${widget.token}'
      };
      Object body = jsonEncode({
        'bidId':bidId,
        'gameId':selectGameId,
        'bidAmount':totalAmount,
        'dealerId':selectDealerId,
        'bidNumbers':bids,
        'insideNumbers':andarbids,
        'outsideNumbers':baharbids,
        'partnerCommission':partPerController.text.isEmpty ? '0' : partPerController.text
      });
      final response = await http.post(
          Uri.parse('${ApiService.BASE_URL}api/web/update/update-sheet'),
          headers: header,
          body: body
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if(response.statusCode == 200) {
        fetchAllSheet();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bids Updated Successfully...', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),), backgroundColor: Colors.green));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.toString())['message'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),), backgroundColor: Colors.red));
      }
    } catch(exp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong..', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),), backgroundColor: Colors.red));
    }
  }

  String totalAmt() {
    List list = [];
    list.addAll(singleBids.where((bid) => bid['amount'] != '' && bid['amount'] != '0').toList());
    list.addAll(andarBids.where((bid) => bid['amount'] != '' && bid['amount'] != '0').toList());
    list.addAll(baharBids.where((bid) => bid['amount'] != '' && bid['amount'] != '0').toList());

    int amount = 0;
    for(var item in list) {
      amount += int.parse(item['amount']!);
    }
    return amount.toString();
  }

}