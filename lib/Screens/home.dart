import 'dart:convert';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:production_schedule/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custombutton.dart';
import '../widgets/schedule_item.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  void deleteDataSchedule(String schID) async {
    try {
      var res = await http.post(Uri.parse(deleteSchedule), body: {
        'id': schID,
      });

      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        if (response['success'] == true) {
          Fluttertoast.showToast(
              msg: "Congratulations,Schedule Deleted Successfully.");
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          setState(() {
            fetchDataSchedule();
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

  void completeDataSchedule(String schID) async {
    try {
      var res = await http.post(Uri.parse(completeSchedule), body: {
        'id': schID,
      });

      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        if (response['success'] == true) {
          Fluttertoast.showToast(
              msg: "Congratulations,Schedule Complete Successfully.");
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          setState(() {
            fetchDataSchedule();
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

  Future<List<dynamic>> fetchDataSchedule() async {
    var response = await http.post(
      Uri.parse(readSchedule),
    );
    var data = json.decode(response.body);

    return data;
  }

  DateTime selectedDate = DateTime.now();
  final userdata = GetStorage();
  @override
  void initState() {
    super.initState();
    userdata.getValues();
    userdata.getKeys();
    fetchDataSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addappBar(),
      body: Column(children: [
        _scheduleButton(),
        _addDatebar(),
        SizedBox(
          height: 25,
        ),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: fetchDataSchedule(),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.hasData) {
                List<dynamic> data = snapshot.data!;
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return schedule_item(
                                          onTap: () {
                                            var snackBar = SnackBar(
                                                content: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              height: 200,
                                              width: double.infinity,
                                              child: Column(
                                                children: [
                                                  Custombutton(
                                                    color: kCardColor,
                                                    text: 'Task Complete',
                                                    onTap: () {
                                                      completeDataSchedule(
                                                          data[index]['schID']
                                                              .toString());
                                                    },
                                                  ),
                                                  Custombutton(
                                                    color: kPinkColor,
                                                    text: 'Delete Task',
                                                    onTap: () {
                                                      deleteDataSchedule(
                                                          data[index]['schID']
                                                              .toString());
                                                    },
                                                  )
                                                ],
                                              ),
                                            ));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                          title: data[index]['title'],
                                          startdate: data[index]['StartDate'],
                                          enddate: data[index]['EndDate'],
                                          status: data[index]['status'],
                                          color: index == 0
                                              ? kCardColor
                                              : index == 2
                                                  ? kPinkColor
                                                  : index == 4
                                                      ? kCardColor
                                                      : index == 6
                                                          ? kPinkColor
                                                          : index == 8
                                                              ? kCardColor
                                                              : kYelowColor,
                                        );
                                      }),
                                )
                              ])),
                    ),
                  ],
                );
              }
              return const Center(child: Text('No data found.'));
            },
          ),
        ),
      ]),
      drawer: Drawer(
          child: Sidebar(
        profileImageUrl: 'assets/images/logo.png',
        username: 'Jacfar Mohaz',
        email: 'jacfarmohaz@gmail.com',
        onTap: () {
          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Center(
                    child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
                content: const SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Are you sure to logout?',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('isLoggedIn', true);
                      prefs.clear();
                      userdata.write('isLogged', false);
                      userdata.remove('username');

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false);
                    },
                  ),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      )),
    );
  }

  _addDatebar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: kCardColor,
        selectedTextColor: Colors.white,
        dateTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey[300],
        ),
        dayTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey[300],
        ),
        monthTextStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.grey[300],
        ),
        onDateChange: (date) {
          selectedDate = date;
        },
      ),
    );
  }

  _scheduleButton() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  'Today',
                  style: HeadingStyle,
                )
              ],
            ),
          ),
          MyButton(
              label: 'Make Schedule',
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => makeSchedule()));
              }),
        ],
      ),
    );
  }

  _addappBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      // actions: [
      //   // Padding(
      //   //   padding: const EdgeInsets.only(right: 10),
      //   //   child: CircleAvatar(
      //   //     foregroundImage: AssetImage('assets/images/profile.jpg'),
      //   //   ),
      //   // ),
      // ],
    );
  }
}
