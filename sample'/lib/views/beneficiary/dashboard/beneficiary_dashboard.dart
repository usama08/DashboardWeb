// ignore_for_file: prefer_const_constructors
import 'package:charity_life/views/beneficiary/dashboard/widgets/balance_section.dart';
import 'package:charity_life/views/beneficiary/dashboard/widgets/category_section.dart';
import 'package:charity_life/views/beneficiary/dashboard/widgets/middle_section.dart';
import 'package:charity_life/views/beneficiary/dashboard/widgets/products_section.dart';
import '../../../enums/dependencies.dart';

class BeneficiaryDashboard extends StatefulWidget {
  const BeneficiaryDashboard({super.key});

  @override
  State<BeneficiaryDashboard> createState() => _BeneficiaryScreenState();
}

class _BeneficiaryScreenState extends State<BeneficiaryDashboard> {
  var beneficiaryController = Get.put(BeneficiaryController());

  @override
  void initState() {
    beneficiaryController.getProductListing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Column(
          children: const [
            BalanceSection(),
            Expanded(
                child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        MiddleSection(),
                        CategorySection(),
                        SizedBox(height: 15),
                        ProductsSection(),
                        SizedBox(height: 15),
                      ],
                    )))
          ],
        ));
  }
}
