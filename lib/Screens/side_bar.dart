import 'package:flutter/material.dart';
import 'package:production_schedule/Screens/view_record/view_employee.dart';
// import 'package:production_schedule/Screens/vew_items.dart';
// import 'package:production_schedule/Screens/view_address.dart';
import 'package:production_schedule/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sidebar extends StatelessWidget {
  final String profileImageUrl;
  final String username;
  final String email;
  final VoidCallback onTap;

  Sidebar({
    required this.profileImageUrl,
    required this.username,
    required this.email, required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xff3982D7)),
            accountName: Text(username),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              foregroundImage: AssetImage(profileImageUrl),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // _createListTile(
                //   context,
                //   icon: Icons.person,
                //   title: 'Profile',
                //   onTap: () {
                //     // TODO: Implement profile page navigation
                //   },
                // ),
                ExpansionTile(
                  leading: Icon(Icons.assignment),
                  title: Text('Registration'),
                  children: [
                    _createListTile(
                      context,
                      icon: Icons.people,
                      title: 'Employees',
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewEmployee()));
                      },
                    ),
                    _createListTile(
                      context,
                      icon: Icons.inventory,
                      title: 'Items',
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewItems()));
                      },
                    ),
                    _createListTile(
                      context,
                      icon: Icons.local_shipping,
                      title: 'Machines',
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewMachines()));
                      },
                    ),
                    _createListTile(
                      context,
                      icon: Icons.location_on,
                      title: 'Addresses',
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => View_Address()));
                      },
                    ),
                    _createListTile(
                      context,
                      icon: Icons.person_2,
                      title: 'Users',
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewUsers()));
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  children: [
                    _createListTile(
                      context,
                      icon: Icons.password,
                      title: 'Change Password',
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePassword()));
                      },
                    ),
                    _createListTile(
                      context,
                      icon: Icons.help,
                      title: 'Help Center',
                      onTap: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => UsersPage()));
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: Icon(Icons.report),
                  title: Text('Reports'),
                  children: [
                    _createListTile(
                      context,
                      icon: Icons.people,
                      title: 'Employee Report',
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmployeeReport()));
                      },
                    ),
                    _createListTile(
                      context,
                      icon: Icons.schedule,
                      title: 'Schedule Report',
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScheduleReport()));
                      },
                    ),
                  ],
                ),
                _createListTile(
                  context,
                  icon: Icons.logout_outlined,
                  title: 'Logout',
                  onTap: onTap
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _createListTile(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
