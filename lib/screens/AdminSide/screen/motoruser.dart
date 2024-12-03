import 'package:dashboarweb/screens/AdminSide/controller/admincontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MotorUserStatus extends StatefulWidget {
  const MotorUserStatus({super.key});

  @override
  State<MotorUserStatus> createState() => _MotorUserStatusState();
}

class _MotorUserStatusState extends State<MotorUserStatus> {
  var adminStatus = Get.put(AdminController());

  @override
  void initState() {
    adminStatus.alluserstatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motor User Status'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (adminStatus.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (adminStatus.userStatusList.isEmpty) {
            return const Center(
              child: Text('No users listed'), // Display when no users
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(label: Text('Index')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('User ID')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Phone')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Policy ID')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: List.generate(adminStatus.userStatusList.length, (index) {
                  final user = adminStatus.userStatusList[index];

                  return DataRow(cells: [
                    DataCell(Text((index + 1).toString())),
                    DataCell(Text(user['fullName'] ?? 'N/A')),
                    DataCell(Text(user['userID'].toString())),
                    DataCell(Text(user['email'] ?? 'N/A')),
                    DataCell(Text(user['phone'].toString())),
                    DataCell(Text(user['userStatus'] ?? 'N/A')),
                    DataCell(Text(user['policyID'].toString() ?? 'N/A')),
                    DataCell(Row(
                      children: [
                        // Pending Button

                        // Approve Button
                        ElevatedButton(
                          onPressed: user['userStatus'] == 'approved'
                              ? null // Disable button if already approved
                              : () {
                                  adminStatus.updateMotorStatus(
                                    user['userID'],
                                    user['policyID'].toString(),
                                    'approved',
                                  );
                                },
                          child: Text(user['userStatus'] == 'approved'
                              ? 'Already Approved'
                              : 'Approve'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: user['userStatus'] == 'approved'
                                ? Colors.grey
                                : Colors.green,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: user['userStatus'] == 'pending'
                              ? null // Disable button if already approved
                              : () {
                                  adminStatus.updateMotorStatus(
                                    user['userID'],
                                    user['policyID'].toString(),
                                    'pending',
                                  );
                                },
                          child: Text(user['userStatus'] == 'pending'
                              ? 'Already pending'
                              : 'Approve'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: user['userStatus'] == 'pending'
                                ? Colors.grey
                                : Colors.orange,
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Delete Button
                        ElevatedButton(
                          onPressed: () {
                            adminStatus.deleteUserPolicies(
                              user['userID'],
                              user['policyID'].toString(),
                            );
                          },
                          child: const Text('Delete'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ],
                    ))
                  ]);
                }),
              ),
            ),
          );
        }),
      ),
    );
  }
}
