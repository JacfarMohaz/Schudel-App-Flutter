import 'package:email_otp/email_otp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:production_schedule/widgets/widgets.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  EmailOTP myauth = EmailOTP();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => home()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Center(
            child: Text(
          'Change Password',
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
                            // SizedBox(height: 12),
                            // MyButton(
                            //     label: 'Send Email',
                            //     onTap: () {
                            //       if (_formKey.currentState!.validate()) {
                            //         _formKey.currentState!.save();
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (context) => OtpScreen(
                            //                       myauth: myauth,
                            //                     )));
                            //       }
                            //     }),
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
