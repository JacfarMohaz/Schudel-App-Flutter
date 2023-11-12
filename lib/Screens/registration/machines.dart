import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
import 'package:production_schedule/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class AddMachine extends StatefulWidget {
  const AddMachine({super.key});

  @override
  State<AddMachine> createState() => _AddMachineState();
}

class _AddMachineState extends State<AddMachine> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;

  TextEditingController name = TextEditingController();

  void Save() async {
    try {
      var res = await http.post(Uri.parse(addMachine),
          body: {'name': name.text.trim(), 'type': _selectedGender});

      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        if (response['success'] == true) {
          Fluttertoast.showToast(msg: "Congratulations,Machine Successfully.");

          setState(() {
            name.clear();
            _selectedGender = null;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ViewMachines()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Center(
            child: Text(
          'Machines Form',
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
              children: <Widget>[
                Text(
                  'Machine Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    // labelText: 'Machine name',
                    hintText: 'Enter machine name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter machine name';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Machine name can only contain letters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // _machineNameController = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Machine Type',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  hint: Text('Select Machine'),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                  items: <String>['Mashiinka Biyaha', 'Mashiinka Caagadaha']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ButtonPrimary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
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

//Edit Section

class EditMachine extends StatefulWidget {
  final id, name, type;
  const EditMachine({super.key, this.id, this.name, this.type});

  @override
  State<EditMachine> createState() => _EditMachineState();
}

class _EditMachineState extends State<EditMachine> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();

  void edit() async {
    try {
      var res = await http.post(Uri.parse(editMachine), body: {
        'id': id.text.trim(),
        'name': name.text.trim(),
        'type': _selectedGender,
      });

      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        if (response['Update'] == true) {
          Fluttertoast.showToast(
              msg: "Congratulations,Edit Machine Successfully.");

          setState(() {
            id.clear();
            name.clear();
            _selectedGender = null;
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
    id.text = widget.id.toString();
    name.text = widget.name.toString();
    _selectedGender.toString();
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
                MaterialPageRoute(builder: (context) => ViewMachines()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Center(
            child: Text(
          'Machines Form',
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
              children: <Widget>[
                Text(
                  'Machine ID',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  readOnly: true,
                  controller: id,
                  decoration: InputDecoration(
                    // labelText: 'Machine name',
                    hintText: 'machine ID',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter machine name';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Machine name can only contain Number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // _machineNameController = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Machine Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    // labelText: 'Machine name',
                    hintText: 'Enter machine name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter machine name';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Machine name can only contain letters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // _machineNameController = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Machine Type',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  hint: Text('Select Gender'),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                  items: <String>['Mashiinka Biyaha', 'Mashiinka Caagadaha']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ButtonPrimary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        edit();
                      }
                    },
                    child: Text(
                      'SAVE Changes',
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
