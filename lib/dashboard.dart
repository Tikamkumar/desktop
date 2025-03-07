import 'package:betting/data/local/user_prefers.dart';
import 'package:betting/home_tabs/dealer_bet_info/dealer_ledger.dart';
import 'package:betting/home_tabs/dealer_bet_info/reporting/dealer_report.dart';
import 'package:betting/home_tabs/draws/draw_master.dart';
import 'package:betting/home_tabs/draws/draw_winning_number.dart';
import 'package:betting/home_tabs/game/all_game.dart';
import 'package:betting/home_tabs/sheet/open_sheet.dart';
import 'package:betting/view_models/UserViewModel.dart';
import 'package:flutter/material.dart';
import 'package:menu_bar/menu_bar.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'home_tabs/cut_process/cut_bidding.dart';
import 'home_tabs/sheet/jantri_sheet.dart';
import 'home_tabs/user/dealer.dart';
import 'home_tabs/user/job_user.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, this.token});
  final token;
  @override
  State<StatefulWidget> createState() => dashboardState();
}

class dashboardState extends State<Dashboard> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Widget currentUI = Container();
  late UserViewModel _userViewModel;
  late ProgressDialog pr;
  UserPrefers? userPrefers;
  String? token;
  String? role;
  int? id;

  @override
  void initState() {
    super.initState();
    userPrefers = UserPrefers();
    init();
    _userViewModel = UserViewModel();
    progressBarInit();
  }

  Future init() async {
    token = await userPrefers!.getToken();
    role = await userPrefers!.getRole();
    id = await userPrefers!.getId();
    if (role == 'staff') {
      updateUI(OpenSheet(token: widget.token));
    } else {
      updateUI(CreateUserJob(token: widget.token));
    }
    setState(() {});
  }

  void progressBarInit() {
    pr = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false);
    pr.style(
      message: 'Logging Out..',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: 100.0,
      messageTextStyle: const TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
  }

/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: constraint.maxHeight
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    MenuBarWidget(
                      barStyle: MenuStyle(
                        // padding: WidgetStatePropertyAll(EdgeInsets.all(2)),
                        backgroundColor: WidgetStatePropertyAll(Colors.blue),
                      ),
                      menuButtonStyle: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      barButtons: getAllBarButton(),
                      // child: Container(),
                      child: showUI(currentUI),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }*/

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
                constraints: BoxConstraints(

                ),
              child: IntrinsicHeight(
                child: MenuBarWidget(
                    barStyle: MenuStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(2)),
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    ),
                    menuButtonStyle: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    barButtons: getAllBarButton(),
                    // child: Container()
                  child: showUI(currentUI),
                ),
              ),
            ),
          );
        }
      ),
    );
  }*/
  // C:\Users\Indutech\Downloads\flutter_windows_3.24.5-stable\flutter\bin
  // C:\Users\Indutech\Desktop\flutter\bin
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: constraint.maxHeight,maxWidth: constraint.maxWidth),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: MenuBarWidget(
                    barStyle: MenuStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(2)),
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    menuButtonStyle: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    barButtons: getAllBarButton(),
                    child: Container(
                      color: const Color(0xff96a7b9),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: showUI(currentUI),
                    ),
                    // child: Container(),
                  ),
                ),
              ),
              );
          },
        ),
    );
  }

  Widget showUI(Widget ui) {
    return ui;
  }

  /* Widget createUserJob() {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(15.0),
          color: Colors.lightGreen,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('CREATE JOB USER', style: TextStyle(color: Colors.black, fontSize: 20)),
                const SizedBox(height: 20, width: 20),
                Row(
                  children: <Widget>[
                    const Text('Name : ', style: TextStyle(color: Colors.black, fontSize: 18)),
                    Container(
                      width: 300,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.white,
                      child:  TextField(
                        controller: emailController,  // Make sure you define emailController
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20, width: 50),
                    const Text('Password : ', style: TextStyle(color: Colors.black, fontSize: 20)),
                    Container(
                      width: 300,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.white,
                      child:  TextField(
                        controller: emailController,  // Make sure you define emailController
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20, width: 50),
                    const Text('Status : ', style: TextStyle(color: Colors.black, fontSize: 20)),
                    Radio(
                      value: 0,
                      groupValue: selectStatus,
                      onChanged: (value) {
                        setState(() {
                          selectStatus = value!!;
                        });
                      },
                    ),
                    const Text(
                        'Carnivore'
                    ),
                    const SizedBox(height: 10, width: 10),
                    Radio(
                      value: 1,
                      groupValue: selectStatus,
                      onChanged: (value) {
                        setState(() {
                          selectStatus = value!!;
                        });
                      },
                    ),
                    Text(
                      'Herbivore',
                      style: new TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20, width: 30),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const Text('Permission to see bet Report', style: TextStyle(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 5, width: 5),
                        Row(
                          children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: 0,
                              onChanged: (value) {
                                setState(() {
                                });
                              },
                            ),
                            const Text(
                                'Allow'
                            ),
                            const SizedBox(width: 50, height: 20),
                            Radio(
                              value: 1,
                              groupValue: selectStatus,
                              onChanged: (value) {
                                setState(() {
                                  selectStatus = value!!;
                                });
                              },
                            ),
                            const Text(
                              'Deny',
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(width: 50, height: 20),
                    Column(
                      children: <Widget>[
                        const Text('Permit besis', style: TextStyle(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 5, width: 5),
                        Row(
                          children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: 0,
                              onChanged: (value) {
                                setState(() {
                                });
                              },
                            ),
                            const Text(
                                'Allow'
                            ),
                            Radio(
                              value: 1,
                              groupValue: selectStatus,
                              onChanged: (value) {
                                setState(() {
                                  selectStatus = value!!;
                                });
                              },
                            ),
                            const Text(
                              'Deny',
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                ListTile(
                  leading: Checkbox(value: false, onChanged: (check) {

                  }),
                  title: const Text('Admin Rights'),
                ),
                const SizedBox(height: 10, width: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 40,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: const BorderRadius.all(Radius.circular(5))
                          ),
                          child: const Center(child: Text('CREATE', style: TextStyle(color: Colors.white, fontSize: 15),))
                      ),
                      Container(
                          height: 40,
                          width: 130,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: const BorderRadius.all(Radius.circular(5))
                          ),
                          child: const Center(child: Text('UPDATE', style: TextStyle(color: Colors.white, fontSize: 15),))
                      ),
                      Container(
                          height: 40,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: const BorderRadius.all(Radius.circular(5))
                          ),
                          child: const Center(child: Text('RESET', style: TextStyle(color: Colors.white, fontSize: 15),))
                      ),
                    ]),
                const Text('List Of Users', style: TextStyle(color: Colors.white, fontSize: 20),),
                */ /*Container(
                height: 40,
                child: ListView (
                    scrollDirection: Axis.horizontal,
                  children: title.map((item) {
                    return Container(
                      height: 40,
                      width: 100,
                      child: Text(item),
                    );
                  }).toList()
                    ),
              ),
              ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: title.map((country){
                  return Container(
                      color: Colors.orangeAccent,
                      height: 100,
                      alignment: Alignment.center,
                      child: Text(country)
                  );
                }).toList(),
              )*/ /*
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
                              children: title.map((country){
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
                              children: title.map((country){
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
        )
    );
  }*/

  void updateUI(Widget newUi) {
    setState(() {
      currentUI = newUi;
    });
  }


  List<BarButton> getAllBarButton() {
    return <BarButton>[
      if (role != 'staff')
        BarButton(
          text: const Text(
            'USERS',
            style: TextStyle(color: Colors.black),
          ),
          submenu: SubMenu(
            menuItems: [
              MenuButton(
                  text: const Text('JOB USER MASTER'),
                  onTap: () {
                    updateUI(CreateUserJob(token: widget.token));
                  }
                /*icon: Icon(Icons.save),
                shortcutText: 'Ctrl+S',*/
              ),
              MenuButton(
                  text: const Text('DEALER[CLIENT] USER MASTER'),
                  onTap: () {
                    updateUI(Dealer(token: widget.token, id: id.toString()));
                  }
                /*icon:  Icon(Icons.exit_to_app),
                shortcutText: 'Ctrl+Q',*/
              ),
            ],
          ),
        ),
      BarButton(
        text: const Text('SHEET', style: TextStyle(color: Colors.black)),
        submenu: SubMenu(
          menuItems: [
            MenuButton(
                text: const Text('OPEN SHEET'),
                onTap: () {
                  setState(() {
                    currentUI = OpenSheet(token: widget.token);
                  });
                }),
            MenuButton(
                text: Text('JANTRI SHEET'),
                onTap: () {
                  setState(() {
                    currentUI = Jantri(token: widget.token);
                  });
                }),
            /*MenuButton(
                text: Text('SHOW SHEET'),
                onTap: () {
                  setState(() {
                    currentUI = Jantri(token: widget.token);
                  });
                }
            ),*/
          ],
        ),
      ),
      BarButton(
        text: const Text('GAME', style: TextStyle(color: Colors.black)),
        submenu: SubMenu(
          menuItems: [
            MenuButton(
                text: const Text('All Game'),
                onTap: () {
                  setState(() {
                    currentUI = Game(token: widget.token);
                  });
                }),
          ],
        ),
      ),
      BarButton(
        text: const Text('DEALER BET INFORMATION',
            style: TextStyle(color: Colors.black)),
        submenu: SubMenu(
          menuItems: [
            MenuButton(
              submenu: SubMenu(
                menuItems: [
                  MenuButton(
                      text: const Text('DEALER REPORT'),
                      onTap: () {
                        setState(() {
                          currentUI = DealerReport();
                        });
                      }
                    /*icon: Icon(Icons.save),
                shortcutText: 'Ctrl+S',*/
                  ),
                  const MenuButton(
                    text: Text('BET REPORT'),
                    /*icon:  Icon(Icons.exit_to_app),
                shortcutText: 'Ctrl+Q',*/
                  ),
                  const MenuButton(
                    text: Text('JANTRI'),
                    /*icon:  Icon(Icons.exit_to_app),
                shortcutText: 'Ctrl+Q',*/
                  ),
                ],
              ),
              text: const Text('REPORTING'),
              /*icon: Icon(Icons.save),
                shortcutText: 'Ctrl+S',*/
            ),
            MenuButton(
                text: const Text('DEALER LEDGER'),
                onTap: () {
                  setState(() {
                    currentUI = const DealerLedger();
                  });
                }
              /*icon:  Icon(Icons.exit_to_app),
                shortcutText: 'Ctrl+Q',*/
            ),
            const MenuButton(
              text: Text('BALANCE SHEET'),
              /*icon:  Icon(Icons.exit_to_app),
                shortcutText: 'Ctrl+Q',*/
            ),
            const MenuButton(
              text: Text('BOOK KEEPING MASTER'),
              /*icon:  Icon(Icons.exit_to_app),
                shortcutText: 'Ctrl+Q',*/
            ),
          ],
        ),
      ),
      BarButton(
        text: Text('DRAWS', style: TextStyle(color: Colors.black)),
        submenu: SubMenu(
          menuItems: [
            MenuButton(
                text: Text('DRAW MASTER'),
                onTap: () {
                  setState(() {
                    currentUI = const DrawMaster();
                  });
                },
              icon: Icon(Icons.save),
                shortcutText: 'Ctrl+S',
            ),
            MenuButton(
                text: Text('DECLARE DRAW WINNING NUMBER'),
                onTap: () {
                  setState(() {
                    currentUI = const DrawWinningNumber();
                  });
                },
              icon:  Icon(Icons.exit_to_app),
                shortcutText: 'Ctrl+Q',
            ),
          ],
        ),
      ),
      BarButton(
        text: Text('EXTRA EXPENDITURE', style: TextStyle(color: Colors.black)),
        submenu: SubMenu(
          menuItems: [
            MenuButton(
                text: Text('JOB USER MASTER'),
                icon: Icon(Icons.save),
                shortcutText: 'Ctrl+S',
                onTap: () {
                  setState(() {
                    currentUI = const DrawMaster();
                  });
                }),
            MenuButton(
              submenu: SubMenu(menuItems: []),
              text: Text('DEALER[CLIENT] USER MASTER'),
              icon: Icon(Icons.exit_to_app),
              shortcutText: 'Ctrl+Q',
            ),
          ],
        ),
      ),
      BarButton(
        text: const Text('CUT PROCESS', style: TextStyle(color: Colors.black)),
        submenu: SubMenu(
          menuItems: [
            const MenuButton(
              text: Text('CUT DEALER'),
              icon: Icon(Icons.save),
                shortcutText: 'Ctrl+S',
            ),
            MenuButton(
                text: const Text('CUT BIDDING'),
                onTap: () {
                  setState(() {
                    currentUI = const CutBidding();
                  });
                },
              icon:  Icon(Icons.exit_to_app),
                shortcutText: 'Ctrl+Q',
            ),
            const MenuButton(
              text: Text('CUT LEDGER'),
              icon:  Icon(Icons.exit_to_app),
                shortcutText: 'Ctrl+Q',
            ),
          ],
        ),
      ),
      BarButton(
        text: const Text('PROFILE', style: TextStyle(color: Colors.black)),
        submenu: SubMenu(
          menuItems: [
           /* MenuButton(
                text: const Text('CHANGE PASSWORD'),
                onTap: () {
                  setState(() {
                    currentUI = const ChangePassword();
                  });
                }
              *//*icon: Icon(Icons.save),
                shortcutText: 'Ctrl+S',*//*
            ),*/
            MenuButton(
                text: const Text('LOGOUT'),
                onTap: () {
                  logoutDialog();
                }
              /*icon:  Icon(Icons.exit_to_app),
                shortcutText: 'Ctrl+Q',*/
            ),
          ],
        ),
      ),
    ];
  }

  Future logoutDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Logout ? '),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    logout();
                  },
                  child: const Text('Yes')
              ),
            ],
          );
        });
  }

  Future logout() async {
    /*await DatabaseHelper.instance.deleteAuth();
    await UserPrefers().removeToken();*/
    Navigator.pop(context);
    /*Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    final response = await _userViewModel.logout(header);
    if (response == "success") {
      await DatabaseHelper.instance.deleteAuth();
      await UserPrefers().removeToken();
      Navigator.pop(context);
    } else {
      await DatabaseHelper.instance.deleteAuth();
      await UserPrefers().removeToken();
      Navigator.pop(context);
      // pr.hide();
    }*/
  }
}
