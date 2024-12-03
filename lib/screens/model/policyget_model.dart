class InsurancePolicy {
  final String insuranceName;
  final String userStatus;

  InsurancePolicy({
    required this.insuranceName,
    required this.userStatus,
  });

  // Factory method to create an InsurancePolicy instance from JSON data with null safety
  factory InsurancePolicy.fromJson(Map<String, dynamic> json) {
    return InsurancePolicy(
      insuranceName:
          json['insuranceName'] ?? 'Unknown Insurance', // Provide default value
      userStatus:
          json['userStatus'] ?? 'Unknown Status', // Provide default value
    );
  }

  // Method to convert an InsurancePolicy instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'insuranceName': insuranceName,
      'userStatus': userStatus,
    };
  }
}
