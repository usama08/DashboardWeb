class MotorUser {
  final int id;
  final int insuranceID;
  final String fullName;
  final String email;
  final String insuranceName;
  final String userStatus;
  final String phone;
  final String policyID;

  MotorUser({
    required this.id,
    required this.insuranceID,
    required this.fullName,
    required this.email,
    required this.insuranceName,
    required this.userStatus,
    required this.phone,
    required this.policyID,
  });

  // Updated fromJson method to handle 'phone' field as int or String
  factory MotorUser.fromJson(Map<String, dynamic> json) {
    return MotorUser(
      id: json['userID'] ?? 0, // Handle missing userID
      insuranceID: json['insuranceID'] ?? 0, // Handle missing userID
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      insuranceName: json['insuranceName'] ?? '',
      userStatus: json['userStatus'] ?? '',
      // Convert phone to String regardless of whether it's int or String
      phone: json['phone']?.toString() ?? '0',
      policyID: json['policyID']?.toString() ?? 'No id',
    );
  }
}
