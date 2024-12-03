import 'package:dashboarweb/screens/AdminSide/controller/admincontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  var adminController = Get.put(AdminController());

  @override
  void initState() {
    adminController.allinsuranceuser();
    // adminController.getstatuslist();
    super.initState();
  }

  void refreshScreen() {
    setState(() {
      adminController.allinsuranceuser();
      adminController.getstatuslist();
    });
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (adminController.motoruser.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.blueGrey[50]),
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'No#',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purpleAccent,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Insurance_ID',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Insurance',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Phone',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Policy ID',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
                rows: List.generate(adminController.motoruser.length, (index) {
                  final user = adminController.motoruser[index];
                  return DataRow(
                    cells: [
                      DataCell(Text((index + 1).toString())),
                      DataCell(Text(user.fullName)),
                      DataCell(Text(user.email)),
                      DataCell(Text(user.insuranceID.toString())),
                      DataCell(Text(user.insuranceName)),
                      DataCell(Text(user.phone.toString())),
                      DataCell(Text(user.policyID.toString())),
                      DataCell(
                        Text(
                          user.userStatus,
                          style: TextStyle(
                            color: getStatusColor(user.userStatus),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          );
        }),
      ),
    );
  }
}
