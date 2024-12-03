import 'package:dashboarweb/screens/controller/globalApp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPolicies extends StatefulWidget {
  const MyPolicies({super.key});

  @override
  State<MyPolicies> createState() => _MyPoliciesState();
}

class _MyPoliciesState extends State<MyPolicies> {
  final policyController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    policyController.insurancePolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Insurance Policies"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (policyController.allpolicy.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: policyController.allpolicy.length,
            itemBuilder: (context, index) {
              final policy = policyController.allpolicy[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade300, Colors.blue.shade800],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon and policy details
                      Row(
                        children: [
                          Icon(
                            Icons.policy,
                            color: Colors.white,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                policy.insuranceName ?? 'Unknown Insurance',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Status: ${policy.userStatus ?? 'Unknown Status'}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[200],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // "Get PDF" button on the right
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                        ),
                        icon: const Icon(Icons.picture_as_pdf),
                        label: const Text('Get PDF'),
                        onPressed: () {
                          // Add functionality to download or view the PDF
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
