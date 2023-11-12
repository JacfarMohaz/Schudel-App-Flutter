// import 'package:flutter/material.dart';
// import 'package:production_schedule/widgets/widgets.dart';

const Address = 'http://172.20.10.3/schedule_api';

//folder Items

const ItemsFolder = '$Address/items';

const addItem = '$ItemsFolder/add.php';
const editItem = '$ItemsFolder/edit.php';
const deleteItem = '$ItemsFolder/delete.php';
const readItems = '$ItemsFolder/read.php';

//folder Machines

const MachineFolder = '$Address/machines';

const addMachine = '$MachineFolder/add.php';
const editMachine = '$MachineFolder/edit.php';
const deleteMachine = '$MachineFolder/delete.php';
const readMachine = '$MachineFolder/read.php';

//Folder Address

const AddressFolder = '$Address/address';

const addAddress = '$AddressFolder/add.php';
const editAddress = '$AddressFolder/edit.php';
const deleteAddress = '$AddressFolder/delete.php';
const readAddress = '$AddressFolder/read.php';

//Folder Employee

const EmployeeFolder = '$Address/employee';

const addEmployee = '$EmployeeFolder/add.php';
const editEmployee = '$EmployeeFolder/edit.php';
const deleteEmployee = '$EmployeeFolder/delete.php';
const readEmployee = '$EmployeeFolder/read.php';
const dropdownreadEmployee = '$EmployeeFolder/dropdown_reading.php';

//Folder Schedule

const ScheduleFolder = '$Address/schedule';

const addSchedule = '$ScheduleFolder/add.php';
const editSchedule = '$ScheduleFolder/edit.php';
const deleteSchedule = '$ScheduleFolder/delete.php';
const readSchedule = '$ScheduleFolder/read.php';
const drpEmpSchedule = '$ScheduleFolder/drp_employee.php';
const drpMchSchedule = '$ScheduleFolder/drp_machine.php';
const completeSchedule = '$ScheduleFolder/complete.php';

//Folder Users

const UserFolder = '$Address/users';

const loginUser = '$UserFolder/login.php';
const validateUser = '$UserFolder/validate.php';
const addUser = '$UserFolder/add.php';
const editUser = '$UserFolder/edit.php';
const deleteUser = '$UserFolder/delete.php';
const readUser = '$UserFolder/read.php';
const drpEmpUser = '$UserFolder/drp_employee.php';

//Folder Login

const SecuretyFolder = '$Address/securety';

const APIlogin = '$SecuretyFolder/login.php';
const APIsignup = '$SecuretyFolder/signup.php';
const CheckEmail = '$SecuretyFolder/check_email.php';

//Folder Reports

const ReportFolder = '$Address/reports';

const employeeReport = '$ReportFolder/employee_report.php';
const scheduleReport = '$ReportFolder/schedule_report.php';
