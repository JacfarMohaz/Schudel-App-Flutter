// ignore_for_file: unused_field

// import 'dart:html';

// import 'dart:io';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
import 'package:production_schedule/widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  String? _userName;
  String? _password;
  String? _confirmPassword;
  String? _email;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  List employeeData = [];
  String? selectedEmployee;

  TextEditingController username = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController showpass = TextEditingController();
  TextEditingController email = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> getEmployeeData() async {
    final response = await http.get(Uri.parse(drpEmpUser));

    if (response.statusCode == 200) {
      setState(() {
        employeeData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void Save() async {
    try {
      var res = await http.post(Uri.parse(APIsignup), body: {
        'empID': selectedEmployee,
        'username': username.text.trim(),
        'pass': pass.text.trim(),
        'email': email.text.trim(),
      });

      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        if (response['success'] == true) {
          Fluttertoast.showToast(msg: "Congratulations,Employee Successfully.");

          setState(() {
            selectedEmployee = null;
            username.clear();
            pass.clear();
            showpass.clear();
            email.clear();
          });
        } else {
          Fluttertoast.showToast(msg: "Error Occurred, Try Again.");
        }
      } else {
        Fluttertoast.showToast(msg: "Please Check Your Connection");
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "error " + e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmployeeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (context) => home()));
        //   },
        //   child: Icon(
        //     Icons.arrow_back_ios,
        //     size: 20,
        //     color: Colors.white,
        //   ),
        // ),
        title: Center(
            child: Text(
          'Sign Up',
          style: TextStyle(fontSize: 26),
        )),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10),
        //     child: CircleAvatar(
        //       foregroundImage: AssetImage('assets/images/profile.jpg'),
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Employee Name Dropdown
                Text(
                  'Employee Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField(
                  value: selectedEmployee,
                  hint: Text('Select Employee'),
                  items: employeeData.map((item) {
                    return DropdownMenuItem(
                      value: item['empolyeeID'].toString(),
                      child: Text(item['empName']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedEmployee = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                ),
                SizedBox(height: 16),
                // User Name
                Text(
                  'User Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                    // labelText: 'User Name',
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _userName = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                // Password
                Text(
                  'Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: pass,
                  decoration: InputDecoration(
                    // labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    suffixIcon: GestureDetector(
                      child: Icon(Icons.visibility),
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
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                // Confirm Password
                Text(
                  'Confirm Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: showpass,
                  decoration: InputDecoration(
                    // labelText: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    suffixIcon: GestureDetector(
                      child: Icon(Icons.visibility),
                      onTap: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !_showConfirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please re-enter your password';
                    }
                    if (value != _password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _confirmPassword = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                // Email
                Text(
                  'Email',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    // labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                // Submit Button
                ElevatedButton(
                  style: ButtonPrimary,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Save();
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Or',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
