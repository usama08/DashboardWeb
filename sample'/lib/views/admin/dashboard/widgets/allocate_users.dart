import 'package:charity_life/views/admin/dashboard/screens/allocation_success.dart';

import '../../../../enums/dependencies.dart';

class AllocateUsers extends StatelessWidget {
  const AllocateUsers({super.key});

  @override
  Widget build(BuildContext context) {
    var dashController = Get.put(DashController());

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                  color:AppColors.primaryDark.withOpacity(0.30),
                  borderRadius: BorderRadius.circular(100)
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(padding: const EdgeInsets.only(left: 15),
              child: TextWidget(text: "Auto-allocate Donations", size: 20, fontFamily: "bold", color: AppColors.blackColor)),
          const SizedBox(height: 10),
          Expanded(child: ListView.builder(itemBuilder: (context,index){
            bool isColored = index % 2 == 0;
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              color:isColored? const Color(0xFFF3FAF3):Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: dashController.allocateUsers[index], size: 14, fontFamily: "regular", color: AppColors.primaryDark.withOpacity(0.6)),
                  TextWidget(text: "SAR465.00", size: 14, fontFamily: "bold", color: AppColors.primaryDark.withOpacity(0.6))
                ],
              ),
            );
          },
            shrinkWrap: true,
            itemCount: dashController.allocateUsers.length,)),

          MyFancyButton(
            margin: const EdgeInsets.all(15),
            isIconButton: false,
            fontSize: 14,
            text: 'Allocate Donations',
            tap:(){
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context){
                  return DialogBox(
                    isConfirm: true,
                    type: "Warning",
                    onTap: (){
                      Get.offAll(()=>const AllocationSuccess());
                    },
                    heading: 'Confirm donations allocation?',
                    body: 'Do you confirm these donations allocation to Muhammad Jameel?',
                  );
                },
              );

            },
            buttonColor: AppColors.primaryColor,
            hasShadow: true,
            borderRadius: 99,
            family: 'OpenSans-Bold',
            fontColor: AppColors.whiteColor,
            blurRadius: 24,
            offset: const Offset(1, 2),
            shadowColor: AppColors.primaryColor.withOpacity(0.24),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
