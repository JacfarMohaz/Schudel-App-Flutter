import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:production_schedule/Screens/view_address.dart';
import 'package:production_schedule/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class Add_Address extends StatefulWidget {
  const Add_Address({super.key});

  @override
  State<Add_Address> createState() => _Add_AddressState();
}

class _Add_AddressState extends State<Add_Address> {
  final _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  String? _area;
  // ignore: unused_field
  String? _village;
  // ignore: unused_field
  String? _city;
  // ignore: unused_field
  String? _contry;

  TextEditingController district = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();

  void Save() async {
    try {
      var res = await http.post(Uri.parse(addAddress), body: {
        'district': district.text.trim(),
        'city': city.text.trim(),
        'country': country.text.trim(),
      });

      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        if (response['success'] == true) {
          Fluttertoast.showToast(msg: "Congratulations,Machine Successfully.");

          setState(() {
            district.clear();
            city.clear();
            country.clear();
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
                MaterialPageRoute(builder: (context) => View_Address()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Center(
            child: Text(
          'Address Form',
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
                  'District',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: district,
                  decoration: InputDecoration(
                    // labelText: 'Machine name',
                    hintText: 'Enter the District',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the District';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'District can only contain letters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _village = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'City',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: city,
                  decoration: InputDecoration(
                    // labelText: 'Machine name',
                    hintText: 'Enter the city',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the city';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'City can only contain letters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _city = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Country',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: country,
                  decoration: InputDecoration(
                    // labelText: 'Machine name',
                    hintText: 'Enter the Country',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the Country';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Country can only contain letters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _contry = value;
                  },
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ButtonPrimary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Save();
                        // Save the form values to the database or perform other actions
                        // print('Employee Name: $_employeeName');
                        // print('Address: $_selectedAddress');
                        // print('Tell: $_tell');
                        // print('Gender: $_selectedGender');
                        // print('Date of Birth: $_dateOfBirth');
                        // print('Register Date: $_registerDate');
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

class Edit_Address extends StatefulWidget {
  final id, district, city, country;
  const Edit_Address(
      {super.key, this.id, this.district, this.city, this.country});

  @override
  State<Edit_Address> createState() => _Edit_AddressState();
}

class _Edit_AddressState extends State<Edit_Address> {
  final _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  String? _area;
  // ignore: unused_field
  String? _village;
  // ignore: unused_field
  String? _city;
  // ignore: unused_field
  String? _contry;

  TextEditingController id = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();

  void edit() async {
    try {
      var res = await http.post(Uri.parse(editAddress), body: {
        'id': id.text.trim(),
        'district': district.text.trim(),
        'city': city.text.trim(),
        'country': country.text.trim(),
      });

      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        if (response['Update'] == true) {
          Fluttertoast.showToast(msg: "Congratulations,Edit Successfully.");

          setState(() {
            id.clear();
            district.clear();
            city.clear();
            country.clear();
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
    district.text = widget.district.toString();
    city.text = widget.city.toString();
    country.text = widget.country.toString();
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
                MaterialPageRoute(builder: (context) => View_Address()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Center(
            child: Text(
          'Address Form',
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
                  'Address ID',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  readOnly: true,
                  controller: id,
                  decoration: InputDecoration(
                    // labelText: 'Machine name',
                    hintText: 'Enter the Address ID',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the ID';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'ID can only contain Numbers';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _village = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'District',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: district,
                  decoration: InputDecoration(
                    // labelText: 'Machine name',
                    hintText: 'Enter the District',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the District';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'District can only contain letters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _village = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'City',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: city,
                  decoration: InputDecoration(
                    // labelText: 'Machine name',
                    hintText: 'Enter the city',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the city';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'City can only contain letters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _city = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Country',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: country,
                  decoration: InputDecoration(
                    // labelText: 'Machine name',
                    hintText: 'Enter the Country',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the Country';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Country can only contain letters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _contry = value;
                  },
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ButtonPrimary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        edit();
                        // Save the form values to the database or perform other actions
                        // print('Employee Name: $_employeeName');
                        // print('Address: $_selectedAddress');
                        // print('Tell: $_tell');
                        // print('Gender: $_selectedGender');
                        // print('Date of Birth: $_dateOfBirth');
                        // print('Register Date: $_registerDate');
                      }
                    },
                    child: Text(
                      'Save Changes',
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
