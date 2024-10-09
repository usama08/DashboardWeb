import 'package:dashboarweb/screens/dashboard/components/viewall/addcredituser.dart';
import 'package:dashboarweb/screens/dashboard/components/viewall/amount.dart';
import 'package:dashboarweb/screens/dashboard/components/viewall/credit.dart';
import 'package:dashboarweb/screens/dashboard/components/viewall/sales.dart';
import 'package:dashboarweb/screens/dashboard/components/viewall/salesform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../../models/my_files.dart';
import '../../../responsive.dart';
import '../../motor/motor_insurance.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Insurance Policy",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                Get.to(CreditFormScreen());
              },
              icon: Icon(Icons.add),
              label: Text("Add New"),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          // Navigate only if the title is "Seller"
          if (demoMyFiles[index].title == "Motor Insurance") {
            Get.to(VehicleFormScreen());
          } else if (demoMyFiles[index].title == "Collections") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AmountCollection()),
            );
          } else if (demoMyFiles[index].title == "Credit") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreditScreen()),
            );
          } else if (demoMyFiles[index].title == "Sales") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SalesScreen()),
            );
          }
        },
        child: FileInfoCard(info: demoMyFiles[index]),
      ),
    );
  }
}
