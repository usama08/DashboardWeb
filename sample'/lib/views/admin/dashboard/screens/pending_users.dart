//ignore_for_file: deprecated_member_use, depend_on_referenced_packages
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../../../../enums/dependencies.dart';
import '../source/user_source.dart';

class PendingUsers extends StatefulWidget {
  const PendingUsers({super.key});

  @override
  State<PendingUsers> createState() => _PendingUsersState();
}

class _PendingUsersState extends State<PendingUsers> {
  @override
  Widget build(BuildContext context) {

    var dashController = Get.put(DashController());
    var orderSource = UserDataSource(dashController.userData);

    return Obx((){

      return Scaffold(
          backgroundColor:dashController.userData.isNotEmpty? const Color(0xFFF7F7F7):Colors.white,
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
            title: TextWidget(text: "Pending User Approvals", size: 20, fontFamily: "bold", color: AppColors.primaryDark),
          ),
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: dashController.userData.isNotEmpty? Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 10,bottom: 20,left: 10,right: 10),
                      width: MediaQuery.of(context).size.width,
                      color: const Color(0xFFF7F7F7),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            children:dashController.userFilters.map((data)=>
                                GestureDetector(
                                    onTap: (){
                                      dashController.changeUserFilter(data);
                                      orderSource.clearFilters();
                                      if(data!="All"){
                                        orderSource.addFilter('userType',
                                            FilterCondition(type: FilterType.equals, value: data.toString(),
                                                filterBehavior: FilterBehavior.stringDataType));
                                      }

                                    },
                                    child: Container(
                                        width: 110,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: dashController.selectedUserFilter.value==data? AppColors.primaryColor:AppColors.fieldColor,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        alignment: Alignment.center,
                                        child: TextWidget(text: data.toString(), size: 12, fontFamily: "regular", color: dashController.selectedUserFilter.value==data? AppColors.whiteColor:
                                        AppColors.primaryDark)
                                    )
                                )
                            ).toList(),
                          )
                      )
                  ),
                  Expanded(child: SfDataGridTheme(
                      data: SfDataGridThemeData(
                          selectionColor: AppColors.primaryColor.withOpacity(0.2),
                          gridLineColor: AppColors.greyLight.withOpacity(0.2),
                          gridLineStrokeWidth: 0.5
                      ),
                      child:CheckboxTheme(
                          data: CheckboxThemeData(
                            fillColor: MaterialStateProperty.resolveWith((states) {
                              if (!states.contains(MaterialState.selected)) {
                                return Colors.transparent;
                              }
                              return AppColors.primaryColor;
                            }),
                            checkColor: MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return Colors.white;
                              }
                              return null;
                            }),
                          ),
                          child: SfDataGrid(
                            controller: dashController.dataGridController2,
                            key: dashController.key2,
                            source: orderSource,
                            showCheckboxColumn: true,
                            checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)
                            ),
                            checkboxColumnSettings: const DataGridCheckboxColumnSettings(showCheckboxOnHeader: false),
                            selectionMode: SelectionMode.multiple,
                            columns: dashController.columns2,
                            columnWidthMode: ColumnWidthMode.auto,
                            gridLinesVisibility: GridLinesVisibility.horizontal,
                            rowHeight: 50,
                            allowSorting: true,
                            allowFiltering: false,
                            headerGridLinesVisibility:GridLinesVisibility.horizontal,
                          )
                      )
                  )),
                  MyFancyButton(
                      isIconButton: false,
                      fontSize: 16,
                      family: "OpenSans-SemiBold",
                      fontColor: AppColors.whiteColor,
                      text: "Approve Selected Users",
                      tap: (){
                        if(dashController.dataGridController2.selectedIndex==-1){
                          BotToast.showSimpleNotification(title: "Please select at least one user",titleStyle: MyTextStyle.openSansRegular(14,AppColors.whiteColor),
                              borderRadius: 12.0,backgroundColor: Colors.red);
                        }
                        else{
                          dashController.userApproval(context);
                          setState(() {

                          });
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
                  image: AppImages.pending,
                  title:"No Pending Users",
                  description:"No Pending Users Approval Data Found",
                  imageHeight:250,
                  titleStyle: MyTextStyle.openSansBold(22, AppColors.primaryDark),
                  descriptionStyle: MyTextStyle.openSansRegular(16, AppColors.primaryDark))
          )
      );
    });
  }
}
