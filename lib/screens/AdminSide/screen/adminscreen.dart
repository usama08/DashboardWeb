import 'package:dashboarweb/screens/AdminSide/component/allinsurance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/admincontroller.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final adminStatus = Get.put(AdminController());

  @override
  void initState() {
    super.initState();
    adminStatus.allinsuranceuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202336),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E3152),
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://yourimageurl.com'),
              radius: 20,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Insurance Policy",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AdminBox(),
              const SizedBox(height: 10),
              const Text(
                "Recent Files",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildRecentFilesTable(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentFilesTable() {
    return Obx(() {
      // Wrap with Obx to reactively update the UI
      if (adminStatus.motoruser.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2E3152),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
          },
          children: List.generate(adminStatus.motoruser.length, (index) {
            final user = adminStatus.motoruser[index];
            return TableRow(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white24)),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.insert_drive_file, color: Colors.blue),
                      const SizedBox(width: 10),
                      Text(user.fullName.toString(),
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(user.insuranceName.toString(),
                      style: const TextStyle(color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(user.userStatus.toString(),
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            );
          }),
        ),
      );
    });
  }

  Widget buildStorageItem(
      String label, String size, IconData icon, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      trailing: Text(size, style: const TextStyle(color: Colors.white)),
    );
  }
}
