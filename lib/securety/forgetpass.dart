// import 'dart:convert';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:email_otp/email_otp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
import '../widgets/widgets.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
    validateUserEmail() async {
    try {
      var res = await http.post(
        Uri.parse(validateUser),
        body: {
          'email': email.text.trim(),
        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
      {
        var resBodyOfValidateEmail = jsonDecode(res.body);

        if (resBodyOfValidateEmail['emailFound'] == true) {
          Fluttertoast.showToast(
              msg: "Email is already in someone else use. Try another email.");
        } else {
          //register & save new user record to database
          // registerAndSaveUserRecord();
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  EmailOTP myauth = EmailOTP();

    validateWalletAccount() async
  {
   
  }


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
      
      ),
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
                    padding: const EdgeInsets.only(top: 60, left: 10),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 100,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // waa code login form sida txtfields ka iyo button login
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text(
                              "Enter your Email to get Code",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: email,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.mail,
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                     try
    {
      var res = await http.post(
        Uri.parse(validateUser),
        body: {
          'email': email.text.trim(),
        },
      );

      if(res.statusCode == 200) //from flutter app the connection with api to server - success
          {
        var response = jsonDecode(res.body);

        if(response['emailFound'] == false)
        {
          Fluttertoast.showToast(
          msg: "Error: Email Not Exist Try another Email.");
         
        }
        else
        {
  myauth.setConfig(
                                            appEmail: "contact@hdevcoder.com",
                                            appName: "Email OTP",
                                            userEmail: email.text,
                                            otpLength: 4,
                                            otpType: OTPType.digitsOnly);
                                        if (await myauth.sendOTP() == true) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text("OTP has been sent"),
                                          ));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content:
                                                Text("Oops, OTP send failed"),
                                          ));
                                        }
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => OtpScreen(
                                                      myauth: myauth,
                                                    )));
        }
      }

    }
    catch(e)
    {
      print(e.toString());
    }
                                      },
                                      icon: const Icon(
                                        Icons.send_rounded,
                                        color: Colors.teal,
                                      )),
                                  hintText: "Email Address",
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
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
                              ),
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
