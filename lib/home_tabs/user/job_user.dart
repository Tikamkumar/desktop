import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:betting/view_models/StaffViewModel.dart';
import 'package:flutter/material.dart';
import '../../model/staff_model.dart';

class CreateUserJob extends StatefulWidget {
  const CreateUserJob({super.key, this.token});
  final token;

  @override
  State<StatefulWidget> createState() => _createUserState();
}

class _createUserState extends State<CreateUserJob> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController besisController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late StaffViewModel _viewModel;
  List<StaffModel> staffList = [];
  List<String> dealerTableTitle = [
    "Sr",
    "Name",
    "Phone No",
    "Password",
    "Role"
  ];
  late StreamController<List<StaffModel>> staffController;
  String? staffField;
  int page = 0;
  String staffId = '';
  String? selectPassword;
  Color hoverColor = Colors.black12;
  int selectedIndex = -1;
  bool ishover = false;
  int hoverIndex = -1;
  List<DropdownMenuItem<String>>? roleList;
  String selectStatus = "deny";
  String betStatus = "deny";
  String permitStatus = "deny";
  Map<String, String> selectRole = {};

  bool isRights = false;
  String msg = "Hello";
  Widget currentUI = Container();
  final _formKey = GlobalKey<FormState>();
  bool isError = false;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    besisController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _viewModel = StaffViewModel();
    staffController = StreamController();
    roleList = [];
    getDealerByPage(page.toString());
    _scrollController.addListener(loadDealer);
    getRole();
  }

  loadDealer() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (staffList.length >= (page + 1) * 10) {
        page++;
        getDealerByPage(page.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
        backgroundColor: Colors.blue[50],
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: */
        SizedBox(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('CREATE JOB USER',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 5),
                isError
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.red[50],
                        padding: EdgeInsets.all(5),
                        child: Text(msg,
                            style: TextStyle(
                                color: Colors.red[800],
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      )
                    : Text(''),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text('Name ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          width: 10,
                        ),
                        /* ResponsiveTextField(controller: nameController, hint: "hint")*/
                        Container(
                          width: 250,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.grey[400]!, width: 1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: TextField(
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
                    const SizedBox(width: 20),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text('Mobile ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 250,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.grey[400]!, width: 1),
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
                            controller: mobileController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  bottom: 15, left: 10, right: 10),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text('Password ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 250,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.grey[400]!, width: 1),
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
                              contentPadding: EdgeInsets.only(
                                  bottom: 15, left: 10, right: 10),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20, width: 30),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Role   ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: 250,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.grey[400]!, width: 1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 5),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  selectRole['name'] = newValue!;
                                  log('Selected Role name${selectRole['name']!}');
                                });
                              },
                              items: roleList),
                        )),
                  ],
                ),
                /*ListTile(
                          leading: Checkbox(value: isRights, onChanged: (check) {
                            setState(() {
                              isRights = check!!;
                            });
                          }),
                          title: const Text('Admin Rights', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                        ),*/
                const SizedBox(height: 20),
                Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: const Center(
                            child: Text(
                          'ADD',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ))),
                  ),
                  GestureDetector(
                    onTap: () {
                      updateStaff();
                    },
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
                    onTap: deleteStaff,
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
                const Text(
                  'List Of Users',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[300]!)),
                    width: 652,
                    height: 30,
                    child: Row(
                        children: dealerTableTitle.map((title) {
                      return Builder(builder: (context) {
                        return Container(
                          width: dealerTableTitle.first == title ? 50 : 150,
                          // padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.blue[200]),
                          child: Center(
                              child: Text(
                            title,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          )),
                        );
                      });
                    }).toList(growable: true))),
                Container(
                  width: 650,
                  height: 300,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: StreamBuilder(
                      stream: staffController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data;
                          // log('data : $data');
                          return Scrollbar(
                            controller: _scrollController,
                            // thumbVisibility: true,
                            thickness: 5,
                            //According to your choice
                            thumbVisibility: false,
                            //
                            radius: Radius.circular(5),
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: data!.length + 1,
                              controller: _scrollController,
                              itemBuilder: (context, i) {
                                StaffModel? item;
                                if ((i < data!.length)) {
                                  item = data?[i];
                                } else {
                                  item = null;
                                }
                                // log('name: ${item!.name}');
                                return (item != null)
                                    ? InkWell(
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
                                              color: (selectedIndex != i)
                                                  ? ((ishover &&
                                                          hoverIndex == i)
                                                      ? Colors.black12
                                                      : Colors.white)
                                                  : Colors.black12,
                                              border: Border.all(
                                                  color: Colors.black26,
                                                  width: 0.1)),
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: index == 0 ? 50 : 150,
                                                  child: Center(
                                                      child: Text(
                                                    showText(item, index, i)!!,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )),
                                                );
                                              },
                                              itemCount: 5),
                                        ),
                                      )
                                    : Container(
                                        height: 100, color: Colors.white);
                              },
                            ),
                          );
                        } else {
                          return Text('');
                        }
                      }),
                )
              ]),
        ),
      ),
    );
    /* ),
        )
    );*/
  }

  Future getRole() async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    Map<String, String> param = {'slug': 'admin'};
    final response = await _viewModel.getRole(header, param);
    setState(() {
      roleList?.add(DropdownMenuItem(
        child: Text(response?['name']),
        value: response?['name'].toString(),
      ));
    });
   /* ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(roleList.toString())));*/
    selectRole['id'] = response!['id'].toString();
    // log('Selected Role Id${selectRole['id']!}');
    /*if(response != null && response.isNotEmpty) {
      setState(() {
        staffList.addAll(List.generate(response.length, (index) => {'name': response[index].name, 'value': response[index].id.toString()}));
        staffId = staffList[0]['value'];
        // log('Staff List : '+ staffList.toString());
        // log('Staff Id : $staffId');
      });
    }*/
  }

  Future createStaff() async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    Object body = jsonEncode({
      'name': nameController.text,
      'mobile': mobileController.text,
      'password': passwordController.text,
      'roleId': selectRole['id']!!
    });
    final response = await _viewModel.createStaff(header, body);
    if (response == "User created successfully") {
      staffList.clear();
      page = 0;
      getDealerByPage(page.toString());
      resetForm();
    }
    /* setState(() {
      roleList?.add(DropdownMenuItem(child: Text(response?['name']), value: response?['id'].toString(),));
    });
    log('Response : '+ roleList.toString());*/
    /*if(response != null && response.isNotEmpty) {
      setState(() {
        staffList.addAll(List.generate(response.length, (index) => {'name': response[index].name, 'value': response[index].id.toString()}));
        staffId = staffList[0]['value'];
        // log('Staff List : '+ staffList.toString());
        // log('Staff Id : $staffId');
      });
    }*/
  }

  resetForm() {
    nameController.text = '';
    mobileController.text = '';
    passwordController.text = '';
    setState(() {
      selectedIndex = -1;
    });
  }

  selectField(StaffModel item) {
    staffId = item.id.toString();
    selectPassword = item.password;
    nameController.text = item.name;
    mobileController.text = item.mobile;
    passwordController.text = item.password;
    // item.password != null ? passwordController.text = '********' : passwordController.text = '';
  }

  validateForm({String func = 'add'}) {
    log(selectRole.toString());
    showError(false);
    if (nameController.text.isEmpty) {
      showError(true, msg: "Please fill the Staff name !");
      return;
    }
    if (mobileController.text.isEmpty) {
      showError(true, msg: 'Please fill the Mobile no !');
      return;
    }
    if (passwordController.text.isEmpty) {
      showError(true, msg: 'Please fill the Password !');
      return;
    }
    if (selectRole?['name'] == null) {
      showError(true, msg: 'Please select role !');
      return;
    }
    createStaff();
    // func == 'add' ? createStaff() :  updateStaff();
  }

  void showError(bool flag, {String msg = "Fill all the details !"}) {
    setState(() {
      isError = flag;
      this.msg = msg!!;
    });
  }

  Future getDealerByPage(String page) async {
    // log('Page'+ page);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${widget.token}'
    };
    Map<String, String> param = {'limit': '10', 'page': page};
    final response = await _viewModel.getStaffByPage(header, param);
    if (response != null && response.isNotEmpty) {
      staffList.addAll(List.generate(
          response.length,
              (index) => StaffModel(
              response[index].id,
              response[index].name,
              response[index].roleId,
              response[index].roleSlug,
              response[index].mobile,
              response[index].password,
              response[index].adminId,
              response[index].status)));
      staffController.add(staffList);
      setState(() {});
    }
  }

  String? showText(StaffModel? model, int index, int sr) {
    // log('Model : $model');
    // log(staffList.toString());
    // staffField = staffList.where((staff) => staff['value'] == model?.staffId.toString()).map((item) => item['name']).toString();
    switch (index) {
      case 0:
        return (sr + 1).toString();
      case 1:
        {
          // log('index: $index');
          return model!.name.toString();
        }
      case 2:
        return model!.mobile.toString();
      case 3:
        return model!.password != null ? '******' : 'NA';
      case 4:
        return 'Staff';
      /*
      case 5: return model!.besis.toString();
      case 6: return model!.partProgram.toString();
      case 7: return (model!.status.toString() == '0') ? 'inactive' : 'active';*/
      default:
        return null;
    }
  }

  Future deleteStaff() async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      'authorization': 'Bearer ${widget.token.toString()}'
    };
    Map<String, dynamic> param = {'id': staffId};
    final response = await _viewModel.deleteStaff(header, param);
    /*ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response)));*/
    if (response == "200") {
      staffList = [];
      page = 0;
      getDealerByPage(page.toString());
      resetForm();
    }
  }

  Future updateStaff() async {
    if (staffId == '') {
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
      'mobile': mobileController.text,
      'password': passwordController.text,
      'roleId': selectRole['id']
    });
    Map<String, dynamic> param = {'id': staffId};
    final response = await _viewModel.updateStaff(header, param, body);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response)));
    if (response == '200') {
      staffList = [];
      page = 0;
      getDealerByPage(page.toString());
      resetForm();
    }
  }
}
