// ignore_for_file: file_names

import '../../../../enums/dependencies.dart';

class CheckOutController extends GetxController {
  TextEditingController fullname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController addresoptional = TextEditingController();

  String? selectedCountry;
  String? selectedCity;
  String? selectedState;
  final List<String> countries = ['Saudi Arabia', 'United States', 'Canada'];
  final List<String> cities = ['Riyadh', 'Jeddah', 'Dammam'];
  final List<String> states = ['Eastern Province', 'Western Province'];
}
