import 'package:charity_life/enums/dependencies.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SelectDeliveryVolunteerScreen extends StatefulWidget {
  final String title;
  const SelectDeliveryVolunteerScreen({super.key, required this.title});

  @override
  State<SelectDeliveryVolunteerScreen> createState() => _SelectDeliveryVolunteerScreenState();
}

class _SelectDeliveryVolunteerScreenState extends State<SelectDeliveryVolunteerScreen> {
  var dashController = Get.put(DashController());


  @override
  Widget build(BuildContext context) {

    return Obx(()=> Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor:const Color(0xFFF7F7F7),
        elevation: 0,
        surfaceTintColor: const Color(0xFFF7F7F7),
        leading: GestureDetector(
          onTap: ()=> Get.back(),
          child: const HeroIcon(HeroIcons.chevronLeft,style: HeroIconStyle.solid,),
        ),
        centerTitle: true,
        title: TextWidget(text: widget.title, size: 20, fontFamily: "bold", color: AppColors.primaryDark),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:  Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffE1E3E7),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      value: dashController.selectedVolunteerKey.value,
                      items: dashController.volunteers.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      isExpanded: true,
                      hint: TextWidget(text: 'Select Delivery Volunteer',
                        size: 14, fontFamily: 'regular', color: AppColors.primaryDark,
                      ),

                      onChanged: (val){
                        dashController.selectedVolunteerKey.value = val;
                        setState(() {});
                      },
                      style: MyTextStyle.openSansRegular(14, AppColors.primaryDark.withOpacity(0.6)),
                      iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down)),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: MediaQuery.of(context).size.height*0.8,
                        width: MediaQuery.of(context).size.width*0.9,
                        offset: const Offset(-12, -20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xffEDEFF3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              MyFancyButton(
                isIconButton: false,
                fontSize: 14,
                text: 'Assign Order',
                tap:(){
                  if(dashController.selectedVolunteerKey.value==null){
                    BotToast.showSimpleNotification(title: "Select any delivery volunteer first",titleStyle: MyTextStyle.openSansRegular(14,AppColors.whiteColor),
                        borderRadius: 12.0,backgroundColor: Colors.red);
                  }
                  else{
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context){
                        return const DialogBox(
                          heading: 'Order Assigned!',
                          body: 'Orders successfully assigned to Muhammad Jameel.',
                        );
                      },
                    );
                  }

                },
                buttonColor:dashController.selectedVolunteerKey.value==null? AppColors.primaryLight :AppColors.primaryColor,
                hasShadow: true,
                borderRadius: 99,
                family: 'OpenSans-Bold',
                fontColor: AppColors.whiteColor,
                blurRadius: 24,
                offset: const Offset(1, 2),
                shadowColor: AppColors.primaryColor.withOpacity(0.24),
              ),
              const SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    ));
  }
}