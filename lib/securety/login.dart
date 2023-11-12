import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/widgets.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    final userdata = GetStorage();
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool _showPassword = false;

  // ignore: unused_field
  String _errorMessage = '';
    void loginNow() async {
    var response = await http.post(Uri.parse(loginUser), body: {
      'username': usernameController.text,
      'PASS': passController.text
    });

    if (response.statusCode == 200) {
      // var Response = jsonDecode(response.body);
      if (response.body == 'Admin') {
               SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool("isAdmin", true);
         pref.setString("username", usernameController.text.trim());
         userdata.write('username', usernameController.text.trim());

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const home(),
            ),
            (route) => false);

      } else if(response.body == 'User') {
         SharedPreferences pref = await SharedPreferences.getInstance();
             pref.setBool("isAdmin", false);
         pref.setString("username", usernameController.text.trim());
         userdata.write('username', usernameController.text.trim());

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const UserHomeScreen(),
            ),
            (route) => false);
      }else{
           
             Fluttertoast.showToast(
          msg: "Incorrect Username or password. Try again");
      }
    } else {
      
      Fluttertoast.showToast(
          msg: "Connection Poor Please Check Your Connection.");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: cons.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 75,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // waa code login form sida txtfields ka iyo button login
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      //

                      //background color of the form
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(6, 0, 0, 0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Color.fromARGB(0, 235, 181, 5),
                            offset: Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                        child: Column(
                          children: [
                            //

                            //email-password-login button
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  // email halka lagu qorayo
                                  TextFormField(
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      // labelText: 'Machine name',
                                      hintText: 'Enter User Name',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter user name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      // _machineNameController = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),

                                  //password halka lagu qorayo
                                  TextFormField(
                                    controller: passController,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.vpn_key_sharp,
                                        color: Colors.white,
                                      ),
                                      // labelText: 'Password',
                                      hintText: 'Enter your password',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      suffixIcon: GestureDetector(
                                        child: Icon(_showPassword?Icons.visibility:Icons.visibility_off,color: Colors.black,),
                                        onTap: () {
                                          setState(() {
                                            _showPassword = !_showPassword;
                                          });
                                        },
                                      ),
                                    ),
                                    obscureText: !_showPassword,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a password';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgetPassword()));
                                        },
                                        child: Text(
                                          'Forget Password',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  //button

                                  MyButton(
                                      label: 'Login',
                                      onTap: () {
                                      if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          loginNow();
                          userdata.write('username', usernameController.text.trim());
                          } else {
                            return;
                          }
                                        
                                      }),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 16,
                            ),
                            ////sign up code if you don't have
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "OR",
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SingUp()));
                                  },
                                  child: const Text("Sign Up",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 16,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
