import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:production_schedule/Screens/view_record/view_employee.dart';
import 'package:production_schedule/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  String? _employeeName;
  // ignore: unused_field
  String? _tell;
  String? _selectedGender;
  List addressData = [];
  String? selectedAddress;
  DateTime selectedDate = DateTime.now();

  TextEditingController name = TextEditingController();
  TextEditingController tell = TextEditingController();
  TextEditingController dDate = TextEditingController();

  Future<void> getAddressData() async {
    final response = await http.get(Uri.parse(dropdownreadEmployee));

    if (response.statusCode == 200) {
      setState(() {
        addressData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void Save() async {
    try {
      var res = await http.post(Uri.parse(addEmployee), body: {
        'name': name.text.trim(),
        'address_id': selectedAddress,
        'tell': tell.text.trim(),
        'gender': _selectedGender,
        'dDate': dDate.text.trim(),
      });

      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        if (response['success'] == true) {
          Fluttertoast.showToast(msg: "Congratulations,Employee Successfully.");

          setState(() {
            name.clear();
            selectedAddress = null;
            tell.clear();
            _selectedGender = null;
            dDate.clear();
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
    getAddressData();
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
                MaterialPageRoute(builder: (context) => ViewEmployee()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Center(
            child: Text(
          'Employee Form',
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
                  'Employee Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'Enter employee name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter employee name';
                    }
                    if (!RegExp(r'^[a-zA-Z, ]+$').hasMatch(value)) {
                      return 'Please enter only letters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _employeeName = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Address',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField(
                  value: selectedAddress,
                  hint: Text('Select Address'),
                  items: addressData.map((item) {
                    return DropdownMenuItem(
                      value: item['addressID'].toString(),
                      child: Text(item['District']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedAddress = value;
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
                  'Tell',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: tell,
                  decoration: InputDecoration(
                    hintText: 'Enter phone number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _tell = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Gender',
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
                  items: <String>['Male', 'Female'].map((String value) {
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
                SizedBox(height: 16),
                Text(
                  'Date of Birth',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select Date of Birth';
                    }
                    return null;
                  },
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    dDate.text = picked!.toString().substring(0, 10);
                  },
                  controller: dDate,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    // label: Text("Date of Birth"),
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

class EditEmployee extends StatefulWidget {
  final id, name, address_id, tell, gender, dDate;
  const EditEmployee(
      {this.id,
      this.name,
      this.address_id,
      this.tell,
      this.gender,
      this.dDate});
  @override
  _EditEmployeeState createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  final _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  String? _employeeName;
  // ignore: unused_field
  String? _tell;
  String? _selectedGender;
  List addressData = [];
  String? selectedAddress;
  DateTime selectedDate = DateTime.now();

  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController tell = TextEditingController();
  TextEditingController dDate = TextEditingController();

  Future<void> getAddressData() async {
    final response = await http.get(Uri.parse(dropdownreadEmployee));

    if (response.statusCode == 200) {
      setState(() {
        addressData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void edit() async {
    try {
      var res = await http.post(Uri.parse(editEmployee), body: {
        'id': id.text.trim(),
        'name': name.text.trim(),
        'address_id': selectedAddress,
        'tell': tell.text.trim(),
        'gender': _selectedGender,
        'dDate': dDate.text.trim(),
      });

      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        if (response['Update'] == true) {
          Fluttertoast.showToast(
              msg: "Congratulations,Edit Employee Successfully.");

          setState(() {
            id.clear();
            name.clear();
            selectedAddress = null;
            tell.clear();
            _selectedGender = null;
            dDate.clear();
          });
        } else {
          Fluttertoast.showToast(msg: "Employee Not Editted Successfully.");
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
    getAddressData();
    id.text = widget.id.toString();
    name.text = widget.name.toString();
    selectedAddress.toString();
    tell.text = widget.tell.toString();
    _selectedGender.toString();
    dDate.text = widget.dDate.toString();
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
                MaterialPageRoute(builder: (context) => ViewEmployee()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Center(
            child: Text(
          'Employee Form',
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
                  'Employee ID',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  readOnly: true,
                  controller: id,
                  decoration: InputDecoration(
                    // labelText: 'Item name',
                    // hintText: 'Enter item name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Empleyee ID';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter only Numbers';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Employee Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'Enter employee name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter employee name';
                    }
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return 'Please enter only letters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _employeeName = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Address',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField(
                  value: selectedAddress,
                  items: addressData.map((item) {
                    return DropdownMenuItem(
                      value: item['addressID'].toString(),
                      child: Text(item['District']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedAddress = value;
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
                  'Tell',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: tell,
                  decoration: InputDecoration(
                    hintText: 'Enter phone number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _tell = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Gender',
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
                  items: <String>['Male', 'Female'].map((String value) {
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
                SizedBox(height: 16),
                Text(
                  'Date of Birth',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select Date of Birth';
                    }
                    return null;
                  },
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    dDate.text = picked!.toString().substring(0, 10);
                  },
                  controller: dDate,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    // label: Text("Date of Birth"),
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
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      'Save Change',
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
