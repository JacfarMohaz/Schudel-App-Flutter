import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:production_schedule/Screens/vew_items.dart';
// import 'package:get/get.dart';
import 'package:production_schedule/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class AddItems extends StatefulWidget {
  const AddItems({super.key});

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController quanty = TextEditingController();
  TextEditingController supplier = TextEditingController();

  int _counter = 0;

  // Create a new record in the database
  void Save() async {
    try {
      var res = await http.post(Uri.parse(addItem), body: {
        'name': name.text.trim(),
        'quanty': quanty.text.trim(),
        'supplier': supplier.text.trim(),
      });

      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        if (response['success'] == true) {
          Fluttertoast.showToast(msg: "Congratulations,Machine Successfully.");

          setState(() {
            name.clear();
            quanty.clear();
            supplier.clear();
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => ViewItems()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Center(
            child: Text(
          'Item Form',
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
                  'Item Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    // labelText: 'Item name',
                    hintText: 'Enter item name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter item name';
                    }
                    if (!RegExp(r'^[a-zA-Z, ]+$').hasMatch(value)) {
                      return 'Please enter only letters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Quantity',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: quanty,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    // labelText: 'Quantity',
                    hintText: 'Enter quantity',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          _counter++;
                          quanty.text = _counter.toString();
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter quantity';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter only numbers';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Supplier',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: supplier,
                  decoration: InputDecoration(
                    // labelText: 'Supplier',
                    hintText: 'Enter supplier name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter supplier name';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Please enter only letters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ButtonPrimary,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Save();
                      // TODO: Save form data to database or do something with it
                    }
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 20),
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

//Edit section

class EditItems extends StatefulWidget {
  final id, name, quanty, supplier;
  const EditItems({super.key, this.id, this.name, this.quanty, this.supplier});

  @override
  State<EditItems> createState() => _EditItemsState();
}

class _EditItemsState extends State<EditItems> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController quanty = TextEditingController();
  TextEditingController supplier = TextEditingController();

  int _counter = 0;

  // Create a new record in the database
  void edit() async {
    try {
      var res = await http.post(Uri.parse(editItem), body: {
        'id': id.text.trim(),
        'name': name.text.trim(),
        'quanty': quanty.text.trim(),
        'supplier': supplier.text.trim(),
      });

      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        if (response['Update'] == true) {
          Fluttertoast.showToast(msg: "Congratulations,Edit Successfully.");

          setState(() {
            id.clear();
            name.clear();
            quanty.clear();
            supplier.clear();
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
    quanty.text = widget.quanty.toString();
    supplier.text = widget.supplier.toString();
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
                context, MaterialPageRoute(builder: (context) => ViewItems()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Center(
            child: Text(
          'Item Form',
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
                  'Item ID',
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
                      return 'Please enter item ID';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter only letters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Item Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    // labelText: 'Item name',
                    // hintText: 'Enter item name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter item name';
                    }
                    if (!RegExp(r'^[a-zA-Z, ]+$').hasMatch(value)) {
                      return 'Please enter only letters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Quantity',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: quanty,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    // labelText: 'Quantity',
                    // hintText: 'Enter quantity',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          _counter++;
                          quanty.text = _counter.toString();
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter quantity';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter only numbers';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Supplier',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: supplier,
                  decoration: InputDecoration(
                    // labelText: 'Supplier',
                    // hintText: 'Enter supplier name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter supplier name';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Please enter only letters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ButtonPrimary,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      edit();
                      // TODO: Save form data to database or do something with it
                    }
                  },
                  child: Text(
                    'Save Change',
                    style: TextStyle(fontSize: 20),
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
