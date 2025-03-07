import 'dart:convert';
import 'dart:developer';
import 'package:betting/data/local/DatabaseHelper.dart';
import 'package:betting/data/local/user_prefers.dart';
import 'package:betting/helper/internet_checker.dart';
import 'package:betting/dashboard.dart';
import 'package:betting/view_models/UserViewModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController mobileController = TextEditingController(text: "9999999999");
  TextEditingController passwordController = TextEditingController(text: "ashu");
  DatabaseHelper? database;
  UserPrefers? prefs;
  bool isError = false;
  bool isLoading = false;
  late UserViewModel viewModel;
  late Future<String?> _tokenFuture;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    viewModel = UserViewModel();
    prefs = UserPrefers();
    _tokenFuture = prefs!.getToken();
    _tokenFuture.then((token) {
      if(token != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(token: token)));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    mobileController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey, width: 0.2)
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Center(child: Text('LOGIN', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600))),
                  isError? const Text('Invalid Username or password...') : const Text(''),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      validator: (value) {
                        if(value!.isEmpty) {
                          return 'Please enter the Username..';
                        }
                        return null;
                      },
                      controller: mobileController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username..',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Please enter the password.';
                        }
                        return null;
                      },
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password..',
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  !isLoading ? TextButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          /* setState(() {
                                isLoading = true;
                              });*/
                          signIn();
                        }
                      },
                      child: Container(
                        height: 35,
                        width:  300,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: const Center(
                          child:  Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      )
                  ) : Container(
                    height: 35,
                    width:  300,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.lightBlueAccent, width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(20))
                    ),
                    child: const Center(
                        child:  SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                    ),
                  ),
                  /*Container(
                            height: 40,
                            width:  MediaQuery.of(context).size.width,
                            color: Colors.purple,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: FlatButton(
                            child: Text('LogIn', style: TextStyle(fontSize: 20.0),),
                            color: Colors.blueAccent,
                            textColor: Colors.white,
                            onPressed: () {},
                          ),
                        ),*/
                  /*Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('Does not have account?'),
                            TextButton(
                              child: const Text(
                                'Sign in',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                //signup screen
                              },
                            )
                          ],
                        ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> headers = {
      'Content-Type': 'application/json'
    };
    Object body = jsonEncode({
      'mobile': mobileController.text,
      'password': passwordController.text
    });
    final response = await viewModel.signIn(headers, body);
    log(response.toString());
    if(!response.containsKey('error')) {
      setState(() {
        isLoading = false;
      });
      // saveAuth(response['token'], response['role'], response['id'].toString());
      await saveLoginData(response['token'], response['role'], response['id']);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(token : response['token'].toString())));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['error'].toString())));
      setState(() {
        isLoading = false;
      });
    }
  }

  Future checkOnLocalDatabase() async {
     try {
       List<Map<String, dynamic>> users = await DatabaseHelper.instance.getUser;

        Map<String, String> currentUser = { 'email': mobileController.text, 'password': passwordController.text};
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(users.toString())));
        if(users.contains(currentUser)) {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  Dashboard()));
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Successfully Offline..')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid Offline..')));
        }
     } catch(exp) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exp.toString())));
       log(exp.toString());
     }
  }

  Future saveLoginData(String token, String role, int id) async {
    prefs?.setId(id);
    prefs?.setRole(role);
    prefs?.setToken(token);
  }

  Future saveAuth(String token, String role, String userId) async {
    try {
      await DatabaseHelper.instance.deleteAuth();
      await DatabaseHelper.instance.saveAuth(<String, String>{
        'token': token,
        'role': role,
        'userId': userId
      });
    } catch(exp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exp.toString())));
    }
  }

  Future getAuth() async {
    try {
      final data = await DatabaseHelper.instance.getUser;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data.length.toString())));
      if(data[0].isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data[0]['token'].toString())));
        Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(token: data[0]['token'].toString())));
      }
    } catch(exp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exp.toString())));
    }
  }

}

