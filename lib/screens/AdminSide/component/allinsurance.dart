import 'package:dashboarweb/screens/AdminSide/component/card.dart';
import 'package:dashboarweb/screens/AdminSide/screen/motoruser.dart';
import 'package:dashboarweb/screens/AdminSide/screen/travelling_policies.dart';
import 'package:dashboarweb/screens/dashboard/components/viewall/travelling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../../responsive.dart';
import '../model/model.dart';
import '../screen/allusers.dart';
import '../screen/usernotifications.dart';

class AdminBox extends StatefulWidget {
  const AdminBox({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminBox> createState() => _AdminBoxState();
}

class _AdminBoxState extends State<AdminBox> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "",
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
                print('press');
                Get.to(UserNotifications());
              },
              icon: Icon(Icons.notification_add),
              label: Text("Notifications"),
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
      itemCount: adminData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          // Navigate only if the title is "Seller"
          if (adminData[index].title == "All Users") {
            Get.to(UsersScreen());
          } else if (adminData[index].title == "Motor Policies") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MotorUserStatus()),
            );
          } else if (adminData[index].title == "Travelling Policies") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TravellingPoliciesUser()),
            );
          } else if (adminData[index].title == "Health Policies") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TravellingInsurance()),
            );
          }
        },
        child: CardInfo(info: adminData[index]),
      ),
    );
  }
}
