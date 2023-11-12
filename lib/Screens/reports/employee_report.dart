import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:production_schedule/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class EmployeeReport extends StatefulWidget {
  const EmployeeReport({super.key});

  @override
  State<EmployeeReport> createState() => _EmployeeReportState();
}

class _EmployeeReportState extends State<EmployeeReport> {
  List<dynamic> _data = [];
  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse(employeeReport));
    if (response.statusCode == 200) {
      setState(() {
        _data = jsonDecode(response.body);
      });
    } else {
      print("Failed to fetch data");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

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
          'Employee Report',
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
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          DataTable(
            columns: <DataColumn>[
              DataColumn(label: Text("ID")),
              DataColumn(label: Text("Name")),
              DataColumn(label: Text("Address")),
              DataColumn(label: Text("Phone")),
              DataColumn(label: Text("Gender")),
              DataColumn(label: Text("Date of Birth")),
              DataColumn(label: Text("Reg-Date")),
            ],
            rows: _data
                .map((item) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text(item["empolyeeID"].toString())),
                        DataCell(Text(item["empName"])),
                        DataCell(Text(item["addressID"])),
                        DataCell(Text(item["tell"])),
                        DataCell(Text(item["gender"])),
                        DataCell(Text(item["dateofbirth"])),
                        DataCell(Text(item["regdate"])),
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
