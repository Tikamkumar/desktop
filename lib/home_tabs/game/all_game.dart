import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:betting/home_tabs/game/show_bids.dart';
import 'package:betting/utils/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../model/dealer_model.dart';
import '../../model/game_model.dart';
import '../../view_models/DealerViewModel.dart';
import '../../view_models/GameViewModel.dart';

class Game extends StatefulWidget {
  const Game({super.key, this.token});
  final token;

  @override
  State<StatefulWidget> createState() => _gameState();
}

class _gameState extends State<Game> {
  TextStyle titleTextStyle =
      TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500);
  TextStyle subtitleTextStyle =
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400);
  TextEditingController gameController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  DateTime? resultDate;
  DateTime? filterDate;
  TextEditingController nameController = TextEditingController();
  TextEditingController resultController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController phoneNoSmsController = TextEditingController();
  TextEditingController besisController = TextEditingController(text: '0');
  TextEditingController partController = TextEditingController(text: '0');
  TextEditingController searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  List<Map<String, String>> dropGameList = [];
  List<GameModel> gameList = [];
  String? selectedGameId;
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
  String? dealerId;
  int page = 0;
  List<String> tableTitle = [
    "SR",
    "NAME",
    "START DATE TIME",
    "END DATE TIME",
    "RESULT DATE TIME",
    "STATUS",
    'RESULT'
  ];
  String selectStatus = 'inactive';
  String gameStatus = 'close';
  bool isRights = false;
  String msg = "Hello";
  Widget currentUI = Container();
  bool isError = false;
  bool isDenaWork = false;
  bool isLoading = false;
  String permitStatus = 'deny';
  late DealerViewModel viewModel;
  late GameViewModel gameViewModel;

  @override
  void initState() {
    super.initState();
    gameViewModel = GameViewModel();
    filterDate = DateTime.now();
    fetchGame();
    staffList = [];
  }

  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: */SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('CREATE GAME',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
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
                                  const Text('New Game :  ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  Container(
                                    width: 250,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey[400]!, width: 1),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: TextField(
                                      style: TextStyle(color: Colors.black),
                                      maxLines: 1,
                                      textAlignVertical: TextAlignVertical.center,
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            bottom: 15, left: 10, right: 10),
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
                                  const Text('Old Game :    ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  Container(
                                    width: 250,
                                    height: 35,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey[400]!, width: 1),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        value: selectedGameId,
                                        items: dropGameList.map((game) {
                                          return DropdownMenuItem(
                                              child: new Text(game['name']!,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400)),
                                              value: game['id']);
                                        }).toList(),
                                        onChanged: (newValue) {
                                          log('Call');
                                          setState(() {
                                            selectedGameId = newValue!!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  const Text('Start Date Time: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  GestureDetector(
                                    onTap: () {
                                      pickDate('start');
                                    },
                                    child: Container(
                                        width:
                                            250,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey[400]!, width: 1),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        child: TextField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  bottom: 6, left: 10),
                                              suffixIcon: const Icon(
                                                Icons.arrow_drop_down,
                                                size: 18,
                                                color: Colors.grey,
                                              ),
                                              border: InputBorder.none,
                                              hintText: startDate != null ? startDate.toString() : '',
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400)),
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15, width: 0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  const Text('End Date Time: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  GestureDetector(
                                    onTap: () {
                                      pickDate('end');
                                    },
                                    child: Container(
                                        width:
                                            250,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey[400]!, width: 1),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        child: TextField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  bottom: 6, left: 10),
                                              suffixIcon: const Icon(
                                                Icons.arrow_drop_down,
                                                size: 18,
                                                color: Colors.grey,
                                              ),
                                              border: InputBorder.none,
                                              hintText: endDate != null ? endDate.toString() : '',
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400)),
                                        )),
                                  ),

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
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  const Text('Result Date Time: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  GestureDetector(
                                    onTap: () {
                                      pickDate('result');
                                    },
                                    child: Container(
                                        width: 250,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey[400]!, width: 1),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        child: TextField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  bottom: 6, left: 10),
                                              suffixIcon: const Icon(
                                                Icons.arrow_drop_down,
                                                size: 18,
                                                color: Colors.grey,
                                              ),
                                              border: InputBorder.none,
                                              hintText: resultDate != null ? resultDate.toString() : '',
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400)),
                                        )),
                                  ),

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
                              const SizedBox(height: 15, width: 0),
                              (selectedIndex != -1)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        const Text('Status : ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                            width:250,
                                            height: 35,
                                            child: Row(
                                              children: <Widget>[
                                                Radio(
                                                  value: 'open',
                                                  groupValue: gameStatus,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      gameStatus = value!!;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                  'Open',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                    width: 50, height: 20),
                                                Radio(
                                                  value: 'close',
                                                  groupValue: gameStatus,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      gameStatus = value!!;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                  'Close',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            )),
                                      ],
                                    )
                                  : Container(height: 35)
                            ],
                          ),
                        ]),
                    const SizedBox(height: 10, width: 20),
                    SizedBox(
                      width: 1100,
                      child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            createGame();
                          },
                          child: Container(
                              height: 35,
                              width: 110,
                              decoration: BoxDecoration(
                                  color: Colors.brown,
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(5))),
                              child: const Center(
                                  child: Text(
                                'ADD',
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ))),
                        ),
                        GestureDetector(
                          onTap: updateGame,
                          child: Container(
                              height: 35,
                              width: 110,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(5))),
                              child: const Center(
                                  child: Text(
                                'UPDATE',
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ))),
                        ),
                        GestureDetector(
                          onTap: deleteGame,
                          child: Container(
                              height: 35,
                              width: 110,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(5))),
                              child: const Center(
                                  child: Text(
                                'DELETE',
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ))),
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
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(5))),
                              child: const Center(
                                  child: Text(
                                'RESET',
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ))),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 950,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                              'Single click to select and Double click to game to know about more details',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                          GestureDetector(
                            onTap: () {
                              pickDate('filter', isFilter: true);
                            },
                            child: Container(
                                width: 150,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey[400]!, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 6, left: 10),
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        size: 18,
                                        color: Colors.grey,
                                      ),
                                      border: InputBorder.none,
                                      hintText: filterDate != null ? DateFormat('yyyy-MM-dd').format(filterDate!) : '',
                                      hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400)),
                                )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.5)),
                        width: 952,
                        height: 30,
                        child: Row(
                            children: tableTitle.map((title) {
                          return Builder(builder: (context) {
                            return Container(
                              width: tableTitle.first == title ? 50 : 150,
                              // padding: EdgeInsets.all(5),
                              decoration: const BoxDecoration(color: Colors.white),
                              child: Center(
                                  child: Text(
                                title,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                            );
                          });
                        }).toList(growable: true))),
                    SizedBox(
                        width: 950,
                        height: MediaQuery.of(context).size.height / 2,
                        child: Scrollbar(
                          controller: _scrollController,
                          // thumbVisibility: true,
                          thickness: 5,
                          //According to your choice
                          thumbVisibility: false,
                          //
                          radius: const Radius.circular(5),
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: gameList.length,
                            controller: _scrollController,
                            itemBuilder: (context, i) {
                              GameModel item = gameList[i];
                              return (item != null)
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectField(item!);
                                          selectedIndex = i;
                                        });
                                      },
                                      onDoubleTap: () {
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ShowBids(
                                                        token: widget.token,
                                                        gameId: item.id.toString())))
                                            .then(refreshData);
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
                                            color: (selectedIndex != i) ? Colors.white
                                                /*? ((ishover && hoverIndex == i)
                                                    ? Colors.grey[200]
                                                    : Colors.white)*/
                                                : Colors.blue[500],
                                            border: Border.all(
                                                color: Colors.black26, width: 0.1)),
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                width: index == 0 ? 50 : 150,
                                                child: Center(
                                                    child: Text(
                                                  showText(item, index, i),
                                                  style: TextStyle(
                                                      color: selectedIndex != i ? Colors.black : Colors.white,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400),
                                                )),
                                              );
                                            },
                                            itemCount: 8),
                                      ),
                                    )
                                  : Container(height: 100, color: Colors.white);
                            },
                          ),
                        ))
                  ])),
        ),
      )
    /*))*/;
  }

  DateTime? newDateTime;
  Future pickDate(String field, {bool isFilter = false}) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if (pickedDate == null) {
      return;
    }

    if(isFilter) {
      filterDate = pickedDate;
      fetchGame();
      setState(() {});
      return;
    }

    TimeOfDay? pickTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay(hour: pickedDate.hour, minute: pickedDate.minute));
    if (pickTime == null) {
      resetForm();
      return;
    }
    newDateTime = DateTime(pickedDate.year, pickedDate.month,
        pickedDate.day, pickTime.hour, pickTime.minute);
    String formatDate = DateFormat('yyyy-MM-dd hh:mm a').format(newDateTime!);
    switch (field) {
      case 'start':
        {
          log('start');
          startDate = newDateTime;
        }
      case 'end':
        {
          endDate = newDateTime;
        }
      case 'result':
        {
          resultDate = newDateTime;
        }
    }

    setState(() {
      startDate;
      endDate;
      resultDate;
    });
    fetchGame();

  }

  Future validateForm({String func = 'add'}) async {
    showError(false);
    if (nameController.text.isEmpty) {
      showError(true, msg: "Please fill the dealer's name !");
      return;
    }
    if (phoneNoController.text.isEmpty || phoneNoController.text.length != 10) {
      showError(true, msg: 'Please fill the Valid Phone No !');
      return;
    }
    /*if(passwordController.text.isEmpty || passwordController.text.length < 8) {
      showError(true, msg: 'Password at least 8 characters !');
      return;
    }*/
    if (besisController.text.isEmpty || int.parse(besisController.text) > 100) {
      showError(true, msg: 'Besis(%) must be 1-100 !');
      return;
    }
    // log(widget.token.toString());
    func == 'add' ? createGame() : updateGame();
  }

  void showError(bool flag, {String msg = "Fill all the details !"}) {
    setState(() {
      isError = flag;
      this.msg = msg!!;
    });
  }

  Future createGame() async {
    if ((dropGameList.isEmpty && nameController.text.isEmpty) || startDate == 'Select Date' || endDate == 'Select Date' || resultDate == 'Select Date') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Fill all the details')));
      return;
    }

    Map<String, String> header = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      'authorization': 'Bearer ${widget.token.toString()}'
    };
    String? gameName;
    try {
      gameName = dropGameList
          .where((item) => item['id'] == selectedGameId)
          .toList()[0]['name']
          .toString();
    } catch (exp) {
      log(exp.toString());
    }
    log(nameController.text.isEmpty
        ? gameName.toString()
        : nameController.text.toString());
    final body = jsonEncode({
      'name': nameController.text.isEmpty
          ? gameName
          : nameController.text.toString(),
      'startDateTime': startDate?.toIso8601String(),
      'endDateTime': endDate?.toIso8601String(),
      'resultDateTime': resultDate?.toIso8601String()
    });
    final response = await http.post(
      Uri.parse('https://battingtwoapi.indutechit.com/api/web/create/game'),
      headers: header,
      body: body
    );

    // final response = await gameViewModel.createGame(header, body);
    if (response.statusCode == 200) {
      fetchGame();
      resetForm();
    } else {
      CustomSnackBar(context).showErrorMsg(jsonDecode(response.body)['message']);
    }
  }

  Future deleteGame() async {
    if (selectedIndex == -1) {
      return;
    }
    Map<String, String> header = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      'authorization': 'Bearer ${widget.token.toString()}'
    };
    Map<String, dynamic> param = {'id': selectedGameId};
    final response = await gameViewModel.deleteGame(header, param);
    if (response == "200") {
      fetchGame();
      setState(() {
        selectedIndex = -1;
      });
      resetForm();
    }
  }

  Future updateGame() async {
    log('Start Date : $startDate');
    log('End Date : $endDate');
    log('Result Date : $resultDate');
    if ((dropGameList.isEmpty && nameController.text.isEmpty) ||
        startDate == null ||
        endDate == null ||
        resultDate == null ||
        selectedIndex == -1) {
      return;
    }
    Map<String, String> header = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      'authorization': 'Bearer ${widget.token.toString()}'
    };
    String? gameName;
    try {
      gameName = dropGameList
          .where((item) => item['id'] == selectedGameId)
          .toList()[0]['name']
          .toString();
    } catch (exp) {
      log(exp.toString());
    }
    Object body = jsonEncode({
      'name': nameController.text.isEmpty
          ? gameName
          : nameController.text.toString(),
      'startDateTime': convertISOString(startDate!),
      'endDateTime': convertISOString(endDate!),
      'resultDateTime': convertISOString(resultDate!),
      'finalBidNumber': resultController.text,
      'status': gameStatus == 'open' ? 1 : 0
    });
    Map<String, dynamic> param = {'id': selectedGameId!!};
    final response = await gameViewModel.updateGame(header, body, param);
    if (response == '200') {
      fetchGame();
      setState(() {
        selectedIndex = -1;
      });
      resetForm();
    }
  }

  String convertISOString(DateTime date) {
    DateTime newDateTime = DateTime(date.year, date.month, date.day, date.hour, date.minute);
    return newDateTime.toIso8601String();
  }

  String showText(GameModel? model, int index, int sr) {
    String startDate = model!.startDate != null
        ? DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(model!.startDate))
        : 'NA';
    String endDate = model!.endDate != null
        ? DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(model!.endDate))
        : 'NA';
    String resultDate = model!.resultDate != null
        ? DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(model!.resultDate))
        : 'NA';

    switch (index) {
      case 0:
        return (sr + 1).toString();
      case 1:
        return model!.name.toString();
      case 2:
        return startDate;
      case 3:
        return endDate;
      case 4:
        return resultDate;
      case 5:
        return model!.status.toString() == '1' ? 'Open' : 'Close';
      case 6:
        return model!.finalBidNumber != null
            ? model!.finalBidNumber.toString()
            : 'NA';
      default:
        return '';
    }
  }

  resetForm() {
    nameController.text = "";
    setState(() {
      startDate = null;
      endDate = null;
      resultDate = null;
      selectedIndex = -1;
    });
  }

  selectField(GameModel item) {
    nameController.text = item.name;
    selectedGameId = item.id.toString();
    resultController.text =
        item.finalBidNumber != null ? item.finalBidNumber.toString() : '';
    setState(() {
      gameStatus = item.status.toString() == '0' ? 'close' : 'open';
      startDate = item.startDate != null
          ? DateTime.parse(item.startDate)
          : null;
      endDate = item.endDate != null
          ? DateTime.parse(item.endDate)
          : null;
      resultDate = item.resultDate != null
          ? DateTime.parse(item.resultDate)
          : null;
    });
  }

  FutureOr refreshData(dynamic value) {
    fetchGame();
  }

  Future fetchGame() async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    Map<String, String> param = {
      'startDateTime':filterDate!.toIso8601String()
    };
    final response = await gameViewModel.getAllGames(header, param);
    log('All Game'+ response.toString());
    gameList = response!;
    dropGameList = [];
    try {
      dropGameList.addAll(response!
          .map((model) =>
              {'id': model.id.toString(), 'name': model.name.toString()})
          .toList());
      selectedGameId = gameList[0].id.toString()!;
    } catch (exp) {
      selectedGameId = null;
    }
    log(dropGameList.toString());
    setState(() {
      dropGameList;
      gameList;
    });
  }
}
