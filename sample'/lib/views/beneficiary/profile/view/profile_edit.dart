import '../../../../enums/dependencies.dart';
import '../../checkOut/widget/dropDown_widget.dart';
import '../controller/profile_controller.dart';
import '../widget/selection_field.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final profileController = Get.put(ProfileController());
  int dependents = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          leading: IconButton(
            icon: HeroIcon(
              HeroIcons.chevronLeft,
              color: AppColors.blackColor,
              size: 24,
              style: HeroIconStyle.solid,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Edit Profile',
                        size: 28,
                        fontFamily: 'bold',
                        color: AppColors.primaryDark,
                        textAlign: TextAlign.start,
                      ),
                      const CircleAvatar(
                        radius: 36,
                        backgroundImage:
                            NetworkImage('https://via.placeholder.com/150'),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.green,
                            child: Icon(Icons.check,
                                color: Colors.white, size: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextWidget(
                    text: 'Personal information',
                    size: 16,
                    fontFamily: 'semi',
                    color: AppColors.primaryDark,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 24),
                  CustomField(
                    hint: 'Full name',
                    labelText: 'Full name',
                    controller: profileController.nameController,
                    onChanged: (val) {
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Please enter your name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomField(
                    hint: 'Identity number (ID)',
                    labelText: 'Identity number (ID)',
                    controller: profileController.idController,
                    onChanged: (val) {
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Please enter your ID number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CoustomDropdown(
                    countries: profileController.countries,
                    selectedCountry: profileController.selectedCountry,
                    showBorder: false,
                    hint: 'Country of birth',
                    onChanged: (val) {
                      profileController.selectedCountry = val;
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 10),
                  SelecTionField(
                    initialDependents: 0,
                    controller: profileController.dependentcontroller,
                    labelText: 'Number of dependents',
                    placeholderText: 'Number of dependents',
                  ),
                  const SizedBox(height: 24),
                  TextWidget(
                    text: 'Contact information',
                    size: 16,
                    fontFamily: 'semi',
                    color: AppColors.primaryDark,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 16),
                  CustomField(
                    hint: 'Phone number',
                    labelText: 'Phone number',
                    controller: profileController.phoneController,
                    onChanged: (val) {
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Please enter your ID number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomField(
                    hint: 'Address',
                    labelText: 'Address',
                    controller: profileController.addressController,
                    onChanged: (val) {
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Please enter your ID number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomField(
                    hint: 'Apartment, Suite, etc.',
                    labelText: 'Apartment, Suite, etc.',
                    controller: profileController.apartmentController,
                    onChanged: (val) {
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Please enter your ID number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CoustomDropdown(
                    countries: profileController.cities,
                    selectedCountry: profileController.selectedCity,
                    showBorder: false,
                    hint: 'City',
                    onChanged: (val) {
                      profileController.selectedCity = val;
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomField(
                    hint: 'Postal code',
                    labelText: 'Postal code',
                    controller: profileController.postalController,
                    onChanged: (val) {
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Please enter your Postal code";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextWidget(
                    text: 'Other',
                    size: 16,
                    fontFamily: 'semi',
                    color: AppColors.primaryDark,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 16),
                  SelecTionField(
                    initialDependents: 0,
                    controller: profileController.monthlyIncome,
                    labelText: 'Monthly income in Saudi Riyal',
                    placeholderText: 'Monthly income in Saudi Riyal',
                  ),
                  const SizedBox(height: 10),
                  CustomField(
                    hint: 'Disability (if any)',
                    labelText: 'Disability (if any)',
                    controller: profileController.desiabilityController,
                    onChanged: (val) {
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "* Please enter your Postal code";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: TextWidget(
                      text: 'Save information',
                      size: 16,
                      fontFamily: 'semi',
                      color: AppColors.whiteColor,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ));
  }
}
