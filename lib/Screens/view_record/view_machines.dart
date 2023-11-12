import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:production_schedule/widgets/widgets.dart';

class ViewMachines extends StatefulWidget {
  const ViewMachines({super.key});

  @override
  State<ViewMachines> createState() => _ViewMachinesState();
}

class _ViewMachinesState extends State<ViewMachines> {
  Future<List<dynamic>> fetchData() async {
    var response = await http.get(Uri.parse(readMachine));
    var data = json.decode(response.body);
    return data;
  }

  void delete(final id) async {
    try {
      var res = await http.post(Uri.parse(deleteMachine), body: {
        'id': id,
      });

      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        if (response['success'] == true) {
          Fluttertoast.showToast(msg: "Congratulations,Delete Successfully.");

          setState(() {});
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
    fetchData();
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
          'Machines List',
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
      body: Column(
        children: [
          Container(
            child: FutureBuilder(
                future: fetchData(),
                builder: (context, AsyncSnapshot<List<dynamic>> dataSnapShot) {
                  if (dataSnapShot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                      ),
                    );
                  }
                  if (dataSnapShot.data == null) {
                    return const Center(
                      child: Text(
                        "No Data found",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  if (dataSnapShot.data!.isNotEmpty) {
                    List<dynamic> data = dataSnapShot.data!;
                    return ListView.builder(
                      itemCount: dataSnapShot.data!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(
                            data[index]['mechineID'],
                            style: TextStyle(color: Colors.white),
                          ),
                          title: Text(
                            data[index]['mechineName'],
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            data[index]['mechineType'],
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Container(
                            width: 100,
                            height: 50,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible:
                                            false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Center(
                                                child: Text(
                                              'DELETE Machine',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            content:
                                                const SingleChildScrollView(
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    'Are you sure to delete?',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Yes'),
                                                onPressed: () async {
                                                  delete(data[index]
                                                          ['mechineID']
                                                      .toString());
                                                  Navigator.of(context).pop();
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
                                    icon: Icon(Icons.delete)),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditMachine(
                                                  id: data[index]['mechineID']
                                                      .toString(),
                                                  name: data[index]
                                                          ['mechineName']
                                                      .toString(),
                                                  type: data[index]
                                                          ['mechineType']
                                                      .toString(),
                                                )),
                                      );
                                    },
                                    icon: Icon(Icons.edit)),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("Empty, No Data."),
                    );
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMachine()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
