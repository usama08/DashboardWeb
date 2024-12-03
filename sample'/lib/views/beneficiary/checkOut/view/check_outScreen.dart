// ignore_for_file: file_names
import 'package:charity_life/views/beneficiary/checkOut/controller/check_outController.dart';
import '../../../../enums/dependencies.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  var checkOutController = Get.put(CheckOutController());
  var loginController = Get.put(AuthController());

  // Controllers for the form fields

  @override
  void initState() {
    super.initState();
    // Populate fields with login data if available
    checkOutController.fullname.text = loginController.loginData.fullName;
    checkOutController.address.text = loginController.loginData.address1;
    checkOutController.phone.text = loginController.loginData.phone;
    checkOutController.addresoptional.text = loginController.loginData.address2;
  }

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
          onPressed: () => Navigator.pop(context),
        ),
        title: TextWidget(
          text: 'Checkout',
          size: 20,
          fontFamily: 'bold',
          color: AppColors.primaryDark,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Show order summary',
                        size: 16,
                        fontFamily: 'bold',
                        color: AppColors.primaryColor,
                        textAlign: TextAlign.center,
                      ),
                      HeroIcon(
                        HeroIcons.chevronDown,
                        color: AppColors.primaryColor,
                        size: 20,
                        style: HeroIconStyle.solid,
                      )
                    ],
                  ),
                  const Text(
                    'SAR 59.50',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 25),
              TextWidget(
                text: 'Your details',
                size: 16,
                fontFamily: 'bold',
                color: AppColors.blackColor,
                textAlign: TextAlign.start,
              ),
              TextWidget(
                text: 'shahzaibam234@gmail.com',
                size: 14,
                fontFamily: 'regular',
                color: AppColors.primaryDark,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 25),
              CustomField(
                hint: 'Full name',
                controller: checkOutController.fullname,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter your Full Name";
                  }
                  return null;
                },
                borderWidth: 0.5,
              ),
              const SizedBox(height: 10),
              CustomField(
                hint: 'Address',
                controller: checkOutController.address,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "* Please Enter your Address";
                  }
                  return null;
                },
                borderRadius: 12.0,
              ),
              const SizedBox(height: 10),
              CustomField(
                hint: 'Apartment, suite, etc. (optional)',
                controller: checkOutController.addresoptional,
                validator: (value) {
                  return null; // Optional field, no validation
                },
                borderWidth: 0.5,
              ),
              const SizedBox(height: 10),
              CustomField(
                hint: 'Phone number',
                controller: checkOutController.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "* Please Enter your Phone Number";
                  }
                  return null;
                },
                borderWidth: 0.5,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add logic to handle checkout submission
                  print("Full Name: ${checkOutController.fullname.text}");
                  print("Address: ${checkOutController.address.text}");
                  print("Phone: ${checkOutController.phone.text}");
                  print(
                      "Address (Optional): ${checkOutController.addresoptional.text}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: TextWidget(
                  text: 'Pay now',
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
    );
  }
}
