import 'package:charity_life/enums/dependencies.dart';

class ProfileController extends GetxController {
  String country = 'Saudi Arabia';
  String maritalStatus = 'Married';
  String? selectedCountry;
  String? selectedCity;
  String? selectedState;
  final List<String> countries = ['Saudi Arabia', 'United States', 'Canada'];
  final List<String> cities = ['Riyadh', 'Jeddah', 'Dammam'];
  final List<String> states = ['Eastern Province', 'Western Province'];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController apartmentController = TextEditingController();

  final TextEditingController dependentsController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController postalController = TextEditingController();
  final TextEditingController dependentcontroller = TextEditingController();
  final TextEditingController monthlyIncome = TextEditingController();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController desiabilityController = TextEditingController();
}
