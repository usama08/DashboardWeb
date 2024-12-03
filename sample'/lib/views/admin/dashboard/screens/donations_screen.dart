import 'package:charity_life/enums/dependencies.dart';
import 'package:charity_life/views/admin/dashboard/widgets/donation_widget.dart';

class DonationsScreen extends StatelessWidget {
  final String title;
  const DonationsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var dashController = Get.put(DashController());
    return Obx((){
      return Scaffold(
          backgroundColor:dashController.donationData.isNotEmpty? const Color(0xFFF7F7F7):Colors.white,
          appBar: AppBar(
            backgroundColor:const Color(0xFFF7F7F7),
            elevation: 0,
            surfaceTintColor: const Color(0xFFF7F7F7),
            leading: GestureDetector(
              onTap: ()=> Get.back(),
              child: const HeroIcon(HeroIcons.chevronLeft,style: HeroIconStyle.solid,),
            ),
            actions: [
              GestureDetector(
                  onTap: (){
                  },
                  child: const Padding(padding: EdgeInsets.only(right: 10),child: HeroIcon(HeroIcons.ellipsisVertical,style: HeroIconStyle.solid))
              )
            ],
            title: TextWidget(text: title, size: 20, fontFamily: "bold", color: AppColors.primaryDark),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child:  dashController.donationData.isNotEmpty? Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 10,bottom: 20,right: 10,left: 10),
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xFFF7F7F7),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              children:dashController.donationFilters.map((data)=>
                                  GestureDetector(
                                      onTap: (){
                                        dashController.changeDonationFilter(data);
                                      },
                                      child: Container(
                                          width: 110,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: dashController.selectedDonationFilter.value==data? AppColors.primaryColor:AppColors.fieldColor,
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          alignment: Alignment.center,
                                          child: TextWidget(text: data.toString(), size: 12, fontFamily: "regular", color: dashController.selectedDonationFilter.value==data? AppColors.whiteColor:
                                          AppColors.primaryDark)
                                      )
                                  )
                              ).toList(),
                            )
                        )
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: dashController.selectedDonationFilter.value=="Posted"? dashController.donationData.where((e)=> e.isPost==true).toList().length:
                        dashController.selectedDonationFilter.value=="Unposted"? dashController.donationData.where((e)=> e.isPost==false|| e.isPost==null).toList().length
                            :dashController.donationData.length,
                        itemBuilder: (BuildContext context, int index){
                          var data = dashController.selectedDonationFilter.value=="Posted"? dashController.donationData.where((e)=> e.isPost==true).toList()[index]:
                          dashController.selectedDonationFilter.value=="Unposted"? dashController.donationData.where((e)=> e.isPost==false || e.isPost==null).toList()[index]
                              :dashController.donationData[index];
                          return DonationWidget(
                            donationIndex: index,
                            data: data,
                          );
                        },
                      ),
                    ),
                    MyFancyButton(
                        isIconButton: false,
                        fontSize: 16,
                        family: "OpenSans-SemiBold",
                        fontColor: AppColors.whiteColor,
                        text: "Post Donations",
                        tap: (){
                          if(dashController.selectedDonationList.isEmpty){
                            BotToast.showSimpleNotification(title: "Please select at least one item",titleStyle: MyTextStyle.openSansRegular(14,AppColors.whiteColor),
                                borderRadius: 12.0,backgroundColor: Colors.red);
                          }
                          else{
                            dashController.submitDonation(context);
                          }
                        },
                        borderRadius: 100,
                        height: 50,
                        width: MediaQuery.of(context).size.width*0.9,
                        buttonColor: AppColors.primaryColor,
                        hasShadow: false),
                    const SizedBox(height: 20),
                  ],
                ):
                NoData(
                    image: AppImages.donation,
                    title:"No Donations",
                    description:"No Donations Data Found",
                    imageHeight:250,
                    titleStyle: MyTextStyle.openSansBold(22, AppColors.primaryDark),
                    descriptionStyle: MyTextStyle.openSansRegular(16, AppColors.primaryDark))
            ),
          )
      );
    });
  }
}