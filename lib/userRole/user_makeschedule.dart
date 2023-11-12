import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:production_schedule/widgets/widgets.dart';

class UserMakeSchedule extends StatefulWidget {
  const UserMakeSchedule({super.key});

  @override
  State<UserMakeSchedule> createState() => _UserMakeScheduleState();
}

class _UserMakeScheduleState extends State<UserMakeSchedule> {
  final _formKey = GlobalKey<FormState>();

  List employeeData = [];
  String? selectedEmployee;

  List machineData = [];
  String? selectedMachine;

  TextEditingController title = TextEditingController();
  TextEditingController sDate = TextEditingController();
  TextEditingController eDate = TextEditingController();

  DateTime selectedDate = DateTime.now();

  // ignore: unused_field
  int _selectedColor = 0;

  Future<void> getMachineData() async {
    final response = await http.get(Uri.parse(drpMchSchedule));

    if (response.statusCode == 200) {
      setState(() {
        machineData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> getEmployeeData() async {
    final response = await http.get(Uri.parse(drpEmpSchedule));

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
      var res = await http.post(Uri.parse(addSchedule), body: {
        'title': title.text.trim(),
        'sDate': sDate.text.trim(),
        'color': _selectedColor.toString(),
        'eDate': eDate.text.trim(),
        'empID': selectedEmployee.toString(),
        'mchID': selectedMachine.toString(),
      });

      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        if (response['success'] == true) {
          Fluttertoast.showToast(msg: "Congratulations,Employee Successfully.");

          setState(() {
            title.clear();
            sDate.clear();
            eDate.clear();
            selectedEmployee = null;
            selectedMachine = null;
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
    getMachineData();
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
                MaterialPageRoute(builder: (context) => UserHomeScreen()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Center(
            child: Text(
          'Make Schedule',
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
                Text(
                  'Title',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: 'Enter title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter title';
                    }
                    if (!RegExp(r'^[a-zA-Z, ]+$').hasMatch(value)) {
                      return 'Title can only contain letters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Start Date',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a Start Date';
                    }
                    return null;
                  },
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2050),
                    );
                    sDate.text = picked!.toString().substring(0, 10);
                  },
                  controller: sDate,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    label: Text("StartDate"),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'End Date',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a End Date';
                    }
                    return null;
                  },
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2050),
                    );
                    eDate.text = picked!.toString().substring(0, 10);
                  },
                  controller: eDate,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    label: Text("EndDate"),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Employee',
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
                Text(
                  'Machine',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField(
                  value: selectedMachine,
                  hint: Text('Select Machine'),
                  items: machineData.map((item) {
                    return DropdownMenuItem(
                      value: item['mechineID'].toString(),
                      child: Text(item['mechineName']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMachine = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Color',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Wrap(
                  children: List<Widget>.generate(3, (int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          print(" Color is $_selectedColor");
                          _selectedColor = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: index == 0
                              ? kCardColor
                              : index == 1
                                  ? kPinkColor
                                  : kYelowColor,
                          child: _selectedColor == index
                              ? Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 16,
                                )
                              : Container(),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ButtonPrimary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // TODO: Save form data to database or do something with it
                        Save();
                      }
                    },
                    child: Text(
                      'Add',
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
