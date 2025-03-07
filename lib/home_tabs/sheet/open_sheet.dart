import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:betting/Components/custom_dropdown.dart';
import 'package:betting/home_tabs/sheet/see_jantri.dart';
import 'package:betting/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../model/dealer_model.dart';
import '../../view_models/DealerViewModel.dart';
import '../../view_models/GameViewModel.dart';

class OpenSheet extends StatefulWidget {
  const OpenSheet({super.key, required this.token});
  final token;

  @override
  State<StatefulWidget> createState() => _openSheetState();
}

class _openSheetState extends State<OpenSheet> {
  String selectDealer = "Seller";
  List<Map<String, String>> selectedNumber = [];
  List<Map<String, String>> showNumbers = [];
  List<String> andarNumList = [];
  List<String> baharNumList = [];
  int totalAmount = 0;
  String selectDate = 'Select Date';
  String selectGame = 'Single';
  String selectDealerNumber = 'Numbers';
  TextEditingController singleNumController = TextEditingController();
  TextEditingController besisController = TextEditingController();
  TextEditingController andarController = TextEditingController();
  TextEditingController baharController = TextEditingController();
  TextEditingController sinAmountController = TextEditingController();
  TextEditingController jodiAmountController = TextEditingController();
  GameViewModel gameViewModel = GameViewModel();
  DealerViewModel dealerViewModel = DealerViewModel();
  bool isLoading = false;
  List<Map<String, String>> gameList = [];
  int sheetNo = 0;
  String? selectGameId;
  List<Map<String, String>> dealerList = [];
  String? selectDealerId = '-1';
  List<Map<String, String>> openDealerList = [];
  String? selectOpenDealerId;
  List<Map<String, String>> gamesList = [
    {'key': 'F1', 'name': 'Single'},
    {'key': 'F2', 'name': 'Jodi'},
    {'key': 'F3', 'name': 'Andar'},
    {'key': 'F4', 'name': 'Bahar'},
    {'key': 'F5', 'name': 'Jodicut'},
    {'key': 'F6', 'name': 'Crossing'},
    {'key': 'F7', 'name': 'Crossing Cut'}
  ];
  int selectedField = -1;
  String? endTime;
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    fetchGame();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                             child: Center(child: Text(totalAmt(selectedNumber), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                           )
                         ],
                       ),
                       const SizedBox(height: 10),
                       customButton('SEE JANTRI', () => Navigator.push(context, MaterialPageRoute(builder: (context) => SeeJantri(bidList: selectedNumber, totalAmount: totalAmt(selectedNumber)))), Colors.blueGrey),
                     ],
                   )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              CallbackShortcuts(
                                bindings: <ShortcutActivator, VoidCallback>{
                                  const SingleActivator(LogicalKeyboardKey.f1): () {
                                    setState(
                                            () => selectGame = gamesList[0]['name']!!);
                                  },
                                  const SingleActivator(LogicalKeyboardKey.f2): () {
                                    setState(
                                            () => selectGame = gamesList[1]['name']!!);
                                  },
                                  const SingleActivator(LogicalKeyboardKey.f3): () {
                                    setState(
                                            () => selectGame = gamesList[2]['name']!!);
                                  },
                                  const SingleActivator(LogicalKeyboardKey.f4): () {
                                    setState(
                                            () => selectGame = gamesList[3]['name']!!);
                                  },
                                  const SingleActivator(LogicalKeyboardKey.f5): () {
                                    setState(
                                            () => selectGame = gamesList[4]['name']!!);
                                  },
                                  const SingleActivator(LogicalKeyboardKey.f6): () {
                                    setState(
                                            () => selectGame = gamesList[5]['name']!!);
                                  },
                                  const SingleActivator(LogicalKeyboardKey.f7): () {
                                    setState(
                                            () => selectGame = gamesList[6]['name']!!);
                                  },
                                },
                                child: Focus(
                                  autofocus: true,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: Radio(
                                        // fillColor: MaterialStateProperty.all(Colors.white),
                                        value: gamesList[index]['name'],
                                        groupValue: selectGame,
                                        onChanged: (value) {
                                          setState(() {
                                            selectGame = value!!;
                                          });
                                        }),
                                  ),
                                ),
                              ),
                              SizedBox(width: 0),
                              Text(
                                '${gamesList[index]['name']!!} (${gamesList[index]['key']!})',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                            ],
                          );
                        },
                        itemCount: gamesList.length),
                  ),
                  ((selectGame == gamesList[0]['name']) ||
                      (selectGame == gamesList[1]['name']) ||
                      (selectGame == gamesList[2]['name']) ||
                      (selectGame == gamesList[3]['name']))
                      ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 180,
                            width: 400,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey, width: 0.1)),
                            padding: const EdgeInsets.only(left: 10),
                            child: TextField(
                              onSubmitted: (value) {
                                addFunc();
                              },
                              controller: singleNumController,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  // hintText: 'Enter Number',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[500]!,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                  border: InputBorder.none),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 120,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                /*borderRadius:
                                BorderRadius.all(Radius.circular(6)),*/
                                border: Border.all(
                                    color: Colors.grey, width: 0.1)),
                            padding: EdgeInsets.only(left: 10),
                            child: TextField(
                              onSubmitted: (value) {
                                addFunc();
                              },
                              controller: sinAmountController,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  border: InputBorder.none,
                                  // hintText: 'Amount',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[500]!,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18)),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      )
                      : ((selectGame == gamesList[4]['name']) ||
                      (selectGame == gamesList[5]['name']) ||
                      (selectGame == gamesList[6]['name']))
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 0.1)),
                            padding: const EdgeInsets.only(left: 10),
                            child: TextField(
                              onSubmitted: (value) {
                                addFunc();
                              },
                              controller: andarController,
                              textAlignVertical:
                              TextAlignVertical.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter
                                    .digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  border: InputBorder.none),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text('X', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400)),
                          ),
                          Container(
                            // width: 140,
                            height: 100,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey, width: 0.1)),
                            padding: const EdgeInsets.only(left: 10),
                            child: TextField(
                              onSubmitted: (value) {
                                addFunc();
                              },
                              controller: baharController,
                              textAlignVertical:
                              TextAlignVertical.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  border: InputBorder.none),
                            ),
                          ),
                          /*Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('ANDAR',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey,
                                        width: 0.5)),
                                padding: EdgeInsets.only(left: 10),
                                child: TextField(
                                  controller: andarController,
                                  textAlignVertical:
                                  TextAlignVertical.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter
                                        .digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true,
                                      border: InputBorder.none),
                                ),
                              ),

                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('BAHAR',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              Container(
                                width: 140,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: 0.5)),
                                padding: EdgeInsets.only(left: 10),
                                child: TextField(
                                  controller: baharController,
                                  textAlignVertical:
                                  TextAlignVertical.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true,
                                      border: InputBorder.none),
                                ),
                              )
                            ],
                          ),*/
                          const SizedBox(width: 20),
                          Container(
                            width: 120,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(2)),
                                border: Border.all(
                                    color: Colors.grey, width: 0.1)),
                            padding: const EdgeInsets.only(left: 10),
                            child: TextField(
                              onSubmitted: (value) {
                                addFunc();
                              },
                              controller: jodiAmountController,
                              keyboardType: TextInputType.number,
                              textAlignVertical: TextAlignVertical.center,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  border: InputBorder.none,
                                  // hintText: 'Amount',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16)),
                            ),
                          ),
                          SizedBox(width: 15),
                        ],
                      )
                      : Text(''),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 650,
                        child: Row(
                          children: [
                            customTitle(''),
                            customTitle('Number'),
                            customTitle('Amount'),
                            customTitle('Bet type'),
                            customTitle('SNO')
                          ],
                        ),
                      ),
                      Container(
                        width: 530,
                        height: MediaQuery.of(context).size.height / 3,
                        decoration: BoxDecoration(color: Colors.grey[200]!),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              bool isSelected = selectedField == index;
                              return GestureDetector(
                                onDoubleTap: () {
                                  if(selectedField == index) {
                                    selectedField = -1;
                                  } else {
                                    selectedField = index;
                                  }
                                },
                                child: Row(
                                  children: [
                                    customField(index, '', isSelected, false, 'blank'),
                                    customField(index, showNumbers[index]['number']!, isSelected, true, 'number'),
                                    customField(index, showNumbers[index]['amount']!!, isSelected, true, 'amount'),
                                    customField(index, showNumbers[index]['type']!!, isSelected, false, 'type'),
                                    customField(index, (index+1).toString(), isSelected, false, 'sr'),
                                  ],
                                ),
                              );
                            },
                            itemCount: showNumbers.length),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          customButton('RESET', () {
                            setState(() {
                              totalAmount = 0;
                              selectedNumber = [];
                              showNumbers = [];
                            });
                          }, Colors.blue),
                          customButton('SUBMIT', createBids, Colors.blue),
                        ],
                      )
                    ],
                  ),

                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 400),
                  SizedBox(
                    width: 700,
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 30,
                                width: 80,
                                decoration: const BoxDecoration(
                                  color: Colors.white
                                ),
                                child: Center(
                                  child: Text(amountCount(selectedNumber, gamesList[index]['name']!.toUpperCase()))
                                ),
                              ),
                              Text(gamesList[index]['name']!.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w500),)
                            ],
                          );
                        },
                      itemCount: gamesList.length,
                    ),
                  ),
                ],
              )
            ],
          )
            ),
      ),
    );
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

  Widget customTitle(String title) {
    return  Container(

        width: title == '' ? 50 : 120,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
            color: Colors.grey,
            width: 0.5
          ),
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5
          )
          )
        ),
        child: Text(title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w400)));

  }
 TextEditingController numberController = TextEditingController();
  Widget customField(int index, String title, bool isSelected, bool isEditable, String type) {
    return  Container(
        width: title == '' ? 50 : 120,
        height: 25,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[300] : Colors.white,
          border: Border(
            left: BorderSide(
            color: Colors.grey[100]!,
            width: 0.5
          ),
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 0.5
          )
          )
        ),
        child: (isSelected && title == '') ? const Icon(Icons.arrow_right, color: Colors.black, size: 18) : (isSelected && isEditable) ?
        TextField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          keyboardType: TextInputType.number,
          onSubmitted: (value) {
            updateField(value, type, index);
            isSelected = false;
            setState(() {});
          },
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: title,
            isDense: true,
            // labelText: title,
            border: InputBorder.none
          ),
        ) : Text(title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w400))
       /*   TextField(
            controller: TextEditingController(text: title),
            decoration: InputDecoration(

            ),
          )*/
    );

  }

  updateField(String updtValue, String type, int index) {
    showNumbers[index][type] = updtValue;
    selectedNumber[index][type] = updtValue;
    setState(() {});
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

  addFunc() {
    switch(selectGame) {
      case 'Single': {
         singleGameCalc();
         return;
      }
      case 'Jodi': {
         jodiGameCalc();
         return;
      }
      case 'Andar': {
         andarBaharGameCalc('andar');
         return;
      }
      case 'Bahar': {
        andarBaharGameCalc('bahar');
        return;
      }
      case 'Jodicut': {
        andarBaharGameSubmit();
        return;
      }
      case 'Crossing': {
        andarBaharGameSubmit();
        return;
      }
      case 'Crossing Cut': {
        andarBaharGameSubmit();
        return;
      }
    }
  }

  singleGameCalc() {
    if (sinAmountController.text.isEmpty || sinAmountController.text.isEmpty) {
      return;
    }
    int length = singleNumController.text.length;
    if(length == 1) {
      showNumbers.add({
        'number': singleNumController.text,
        'amount': sinAmountController.text.toString(),
        'type': 'ANDAR'
      });
      for (int i = 0; i < 10; i++) {
        selectedNumber.add({
          'number': singleNumController.text + i.toString(),
          'amount': sinAmountController.text.toString(),
          'type':'ANDAR'
        });
      }
    }
    if(length == 2) {
      showNumbers.add({
        'number': singleNumController.text,
        'amount': sinAmountController.text.toString(),
        'type': 'SINGLE'
      });
      selectedNumber.add({
        'number': singleNumController.text,
        'amount': sinAmountController.text.toString(),
        'type': 'SINGLE'
      });
    }
    if(length == 3) {
      showNumbers.add({
        'number': singleNumController.text.substring(2, 3),
        'amount': sinAmountController.text.toString(),
        'type': 'BAHAR'
      });
      for (int i = 0; i < 10; i++) {
        selectedNumber.add({
          'number': i.toString() + singleNumController.text.substring(2, 3),
          'amount': sinAmountController.text.toString(),
          'type': 'BAHAR'
        });
      }
    }
    if(length % 2 == 0 && length != 2) {

       for(int i = 0; i < length; i = i + 2) {
         showNumbers.add({
           'number': (singleNumController.text.toString()[i]+singleNumController.text.toString()[i+1]).toString(),
           'amount': sinAmountController.text.toString(),
           'type': 'SINGLE'
         });
         selectedNumber.add({
           'number':(singleNumController.text.toString()[i]+singleNumController.text.toString()[i+1]).toString(),
           'amount':sinAmountController.text.toString(),
           'type': 'SINGLE'
         });
       }
    }

    if(length % 2 != 0 && length > 3) {
      showNumbers.add({
        'number': singleNumController.text.substring(length-1, length),
        'amount': sinAmountController.text.toString(),
        'type': 'BAHAR'
      });
      for (int i = 0; i < 10; i++) {
        selectedNumber.add({
          'number': i.toString() + singleNumController.text.substring(2, 3),
          'amount': sinAmountController.text.toString(),
          'type': 'BAHAR'
        });
      }
    }

    totalAmount = 0;
    for(int i = 0; i < showNumbers.length; i++) {
      totalAmount += int.parse(showNumbers[i]['amount']!);
    }
     setState(() {
       showNumbers;
      selectedNumber;
      totalAmount;
    });
  }

  andarBaharGameCalc(String game) {
    if (sinAmountController.text.isEmpty || singleNumController.text.isEmpty) {
      return;
    }
    int length = singleNumController.text.length;
    String number = singleNumController.text.toString();

      for(int i = 0; i < length; i++) {
        showNumbers.add({
          'number':(number[i]).toString(),
          'amount':sinAmountController.text.toString(),
          'type': (game == 'andar') ? 'ANDAR' : 'BAHAR'
        });
        for(int j = 0; j < 10; j++) {
          selectedNumber.add({
            'number':(game == 'andar') ? ('${number[i]}$j').toString() : ('$j${number[i]}').toString(),
            'amount':sinAmountController.text.toString(),
            'type': (game == 'andar') ? 'ANDAR' : 'BAHAR'
          });
        }
      }


    totalAmount = 0;
    for(int i = 0; i < showNumbers.length; i++) {
      totalAmount += int.parse(showNumbers[i]['amount']!);
    }
     setState(() {
      showNumbers;
      selectedNumber;
      totalAmount;
    });
  }

  jodiGameCalc() {
    if (sinAmountController.text.isEmpty || singleNumController.text.isEmpty) {
      return;
    }
    int length = singleNumController.text.length;
    if(length > 1) {
      showNumbers.add({
        'number':(singleNumController.text.toString()),
        'amount':sinAmountController.text.toString(),
        'type': 'JODI'
      });
      for(int i = 0; i < length; i = i + 2) {
        /*showNumbers.add({
          'number':(singleNumController.text.toString()[i]+singleNumController.text.toString()[i+1]).toString(),
          'amount':sinAmountController.text.toString(),
          'type': 'JODI'
        });*/
        selectedNumber.add({
          'number':(singleNumController.text.toString()[i]+singleNumController.text.toString()[i+1]).toString(),
          'amount':sinAmountController.text.toString(),
          'type': 'JODI'
        });
      }
    } else {
      CustomSnackBar(context).showWarningMsg('Provide Valid Number...');
    }
    totalAmount = 0;
    for(int i = 0; i < showNumbers.length; i++) {
      totalAmount += int.parse(showNumbers[i]['amount']!);
    }
    setState(() {
      selectedNumber;
      totalAmount;
    });
  }

  andarBaharGameSubmit() {
    if (andarController.text.isEmpty ||
        baharController.text.isEmpty ||
        jodiAmountController.text.isEmpty) {
      return;
    }
    andarNumList = [];
    baharNumList = [];
    for (int i = 0; i < andarController.text.length; i++) {
      andarNumList
          .add(andarController.text.characters.characterAt(i).toString());
    }
    for (int i = 0; i < baharController.text.length; i++) {
      baharNumList
          .add(baharController.text.characters.characterAt(i).toString());
    }
    switch (selectGame) {
     /* case 'Jodi':
        {
          for (String andar in andarNumList) {
            for (String bahar in baharNumList) {
              selectedNumber.add({
                'number': andar + bahar,
                'amount': jodiAmountController.text.toString()
              });
            }
          }
        }*/
      case 'Jodicut':
        {
          showNumbers.add({
            'number': andarController.text + ' X ' + baharController.text,
            'amount': jodiAmountController.text.toString(),
            'type': 'JODICUT'
          });
          for (String andar in andarNumList) {
            for (String bahar in baharNumList) {
              if (andar != bahar) {
                /*showNumbers.add({
                  'number': andar + bahar,
                  'amount': jodiAmountController.text.toString(),
                  'type': 'JODICUT'
                });*/
                selectedNumber.add({
                  'number': andar + bahar,
                  'amount': jodiAmountController.text.toString(),
                  'type': 'JODICUT'
                });
                log(selectedNumber.toString());
              }
            }
          }
        }
      case 'Crossing':
        {
          showNumbers.add({
            'number': andarController.text + ' X ' + baharController.text,
            'amount': jodiAmountController.text.toString(),
            'type': 'CROSSING'
          });
          for (String andar in andarNumList) {
            for (String bahar in baharNumList) {
              /*showNumbers.add({
                'number': andar + bahar,
                'amount': jodiAmountController.text.toString(),
                'type': 'CROSSING'
              });*/
              selectedNumber.add({
                'number': andar + bahar,
                'amount': jodiAmountController.text.toString(),
                'type': 'CROSSING'
              });
            }
          }
          if(andarNumList == baharNumList) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hello')));
        }
        /*andarNumList.addAll(baharNumList);
        for(String i in andarNumList) {
          for (String j in andarNumList) {
              selectedNumber.add({'number': i+j, 'amount': jodiAmountController.text.toString()});
          }
        }*/
        }
      case 'Crossing Cut':
        {
          showNumbers.add({
            'number': andarController.text + ' X ' + baharController.text,
            'amount': jodiAmountController.text.toString(),
            'type': 'CROSSING CUT'
          });
          for (String andar in andarNumList) {
            for (String bahar in baharNumList) {
              if (andar != bahar) {
               /* showNumbers.add({
                  'number': andar + bahar,
                  'amount': jodiAmountController.text.toString(),
                  'type': 'CROSSING CUT'
                });*/
                selectedNumber.add({
                  'number': andar + bahar,
                  'amount': jodiAmountController.text.toString(),
                  'type': 'CROSSING CUT'
                });
              }
            }
          }
          /*andarNumList.addAll(baharNumList);
        for(String i in andarNumList) {
          for (String j in andarNumList) {
            if(i != j) {
              selectedNumber.add({'number': i+j, 'amount': jodiAmountController.text.toString()});
            }
          }
        }*/
        }
    }

    totalAmount = 0;
    for(int i = 0; i < showNumbers.length; i++) {
      totalAmount += int.parse(showNumbers[i]['amount']!);
    }

    /*selectedNumber.map((item) => item.entries.map((MapEntry<k, v>) =>  ));
    List<String> amounts = selectedNumber.where((item) => item.entries.map((k, v) => (k == 'amount'))).toList();
    selectedNumber.map((item) => item)*/

    setState(() {
      selectedNumber;
      showNumbers;
      totalAmount;
    });
  }

  Future fetchGame() async {
    gameList = [];
    log(widget.token.toString());
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    Map<String, String> param = {
      'startDateTime': DateTime.parse(selectDate).toIso8601String()
    };
    final response = await gameViewModel.getAllGames(header, param);

    log(response.toString());
    gameList = response!.map((model) => {'id': model.id.toString(), 'name': model.name.toString(), 'end': model.endDate.toString()}).toList();
    log('Game List : ${gameList.isEmpty}');
    if(gameList.isEmpty) {
      _timer?.cancel();
      _countDownValue = '00:00:00';
      setState(() {});
    }
    selectGameId = gameList[0]['id']!;
    endTime = gameList[0]['end'];
    showTimer(endTime!);
    log('End Time $endTime');
    if (selectGameId != null) {
      fetchDealer();
      fetchOpenDealers();
    }
    setState(() {
      gameList;
    });
  }


  Future fetchDealer() async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    List<DealerModel>? list = (await dealerViewModel.getAllDealers(header));
    log(list.toString());

    dealerList = List.generate(
        list!.length,
        (index) => {
              'id': list[index].id.toString(),
              'name': list[index].name.toString(),
              'mobile': list[index].mobile.toString()
            });
    selectDealerId = dealerList[0]['id'].toString();
    selectDealerNumber = dealerList.where((item) => item['id'] == selectDealerId!).single['mobile'].toString();
    if (selectDealerId != null) {
      fetchSheetNo();
    }
    log(dealerList.toString());
    setState(() {
      dealerList;
    });
  }

  String showNumber(String dealerId) {
    log('Dealer Id: $dealerId');
    String number = 'Numbers';
    try {
       number = dealerList.where((item) => item['id'] == dealerId).single['number'].toString();
    } catch(exp) {
      log(exp.toString());
    }
    return number == 'null' ? 'Numbers' : number;
  }

  Future fetchOpenDealers() async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    Map<String, String> param = {'startDateTime': selectDate};
    openDealerList = (await dealerViewModel.getAllOpenDealers(header, param))!;
    if(openDealerList.isNotEmpty) {
      selectOpenDealerId = openDealerList[0]['id'].toString();
    }

    setState(() {
      openDealerList;
    });
  }

  Future fetchSheetNo() async {
    log(selectDealerId!);
    log(selectGameId!);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    Map<String, String> param = {
      'dealerId': selectDealerId!,
      'gameId': selectGameId!
    };
    final response = (await gameViewModel.getSheetNo(header, param));
    try {
      sheetNo =
          response?['sheetNo'] != null ? int.parse(response!['sheetNo']!) : 0;
    } catch (exp) {
      log(exp.toString());
    }
    log(response.toString());

    setState(() {
      sheetNo;
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
      fetchGame();
    }
  }

  Future createBids() async {
    setState(() {
      isLoading = true;
    });

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    Object body = jsonEncode({
      'gameId':selectGameId,
      'bidAmount':totalAmount,
      'dealerId':selectDealerId,
      'bidNumbers':selectedNumber,
      'insideNumbers':[],
      'outsideNumbers':[]
    });
    final response = (await gameViewModel.createJantriBids(header, body));
    log(response.toString());
    if(response == '201') {
      fetchOpenDealers();
      fetchSheetNo();
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bids Created Succesfully..', style: TextStyle(fontWeight: FontWeight.w500)), backgroundColor: Colors.green));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response!, style: TextStyle(fontWeight: FontWeight.w500)), backgroundColor: Colors.green));
    }
    setState(() {
      isLoading = false;
    });
  }

  String amountCount(List<Map<String, String>> selectedNumber, String type) {
    log('Selected Number : $selectedNumber');
    int amount = 0;
    var list = selectedNumber.where((item) => item['type'] == type).toList();
    for(var item in list) {
      amount += int.parse(item['amount']!);
    }
    return amount.toString();
  }

  String totalAmt(List<Map<String, String>> selectedNumber) {
    log('Selected Number : $selectedNumber');
    log('Total Number : ${selectedNumber.length}');
    int amount = 0;
    for(var item in selectedNumber) {
      amount += int.parse(item['amount']!);
    }
    return amount.toString();
  }
}
