import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:production_schedule/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class ScheduleReport extends StatefulWidget {
  const ScheduleReport({super.key});

  @override
  State<ScheduleReport> createState() => _ScheduleReportState();
}

class _ScheduleReportState extends State<ScheduleReport> {
  List<dynamic> _data = [];
  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse(scheduleReport));
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
          'Schedule Report',
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
              DataColumn(label: Text("Title")),
              DataColumn(label: Text("Start Date")),
              DataColumn(label: Text("End Date")),
              DataColumn(label: Text("Employee Name")),
              DataColumn(label: Text("Machine Name")),
            ],
            rows: _data
                .map((item) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text(item["schID"].toString())),
                        DataCell(Text(item["title"])),
                        DataCell(Text(item["StartDate"])),
                        DataCell(Text(item["EndDate"])),
                        DataCell(Text(item["empolyeeID"])),
                        DataCell(Text(item["mechineID"])),
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
