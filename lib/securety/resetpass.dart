// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:production_schedule/widgets/widgets.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  String? _password;
  String? _confirmPassword;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  TextEditingController pass = TextEditingController();
  TextEditingController showpass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Center(
            child: Text(
          'Reset Password',
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
            padding: const EdgeInsets.only(left: 16, top: 110, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Enter New Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: pass,
                  decoration: InputDecoration(
                    // labelText: 'Password',
                    hintText: 'Enter New password',
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
                      return 'Please enter new password';
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
                  'Re-enter your New Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: showpass,
                  decoration: InputDecoration(
                    // labelText: 'Confirm Password',
                    hintText: 'Re-enter your new password',
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
                      return 'Please re-enter your new password';
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
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ButtonPrimary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                    child: Text(
                      'Change Password',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
