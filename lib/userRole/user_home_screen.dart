import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:production_schedule/widgets/widgets.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addappBar(),
      body: Column(children: [
        _scheduleButton(),
        _addDatebar(),
      ]),
      drawer: Drawer(
          child: UserSidebar(
        profileImageUrl: 'assets/images/logo.png',
        username: 'Jacfar Mohaz',
        email: 'jacfarmohaz@gmail.com',
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
