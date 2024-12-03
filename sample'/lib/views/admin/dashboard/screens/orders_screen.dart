//ignore_for_file: deprecated_member_use, depend_on_referenced_packages
import 'package:charity_life/enums/dependencies.dart';
import 'package:charity_life/views/admin/dashboard/screens/select_delivery_volunteer.dart';
import 'package:charity_life/views/admin/dashboard/source/orders_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class OrdersScreen extends StatelessWidget {
  final String title;
  const OrdersScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var dashController = Get.put(DashController());

    var orderSource = OrderDataSource(dashController.orderData);

    return Obx(()=> Scaffold(
        backgroundColor:dashController.orderData.isNotEmpty? const Color(0xFFF7F7F7):Colors.white,
        appBar: AppBar(
          backgroundColor:const Color(0xFFF7F7F7),
          elevation: 0,
          surfaceTintColor: const Color(0xFFF7F7F7),
          leading: GestureDetector(
            onTap: ()=> Get.back(),
            child: const HeroIcon(HeroIcons.chevronLeft,style: HeroIconStyle.solid,),
          ),
          actions: [
            dashController.selectedFilter.value==""? const SizedBox():
                GestureDetector(
                  onTap: (){
                    orderSource.clearFilters();
                    dashController.changeFilter("");
                  },
                  child: const Padding(padding: EdgeInsets.only(right: 10),child: HeroIcon(HeroIcons.xMark,style: HeroIconStyle.solid))
                )
          ],
          title: TextWidget(text: title, size: 20, fontFamily: "bold", color: AppColors.primaryDark),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child:dashController.orderData.isNotEmpty?  Column(
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
                        children:dashController.filters.map((data)=>
                            GestureDetector(
                                onTap: (){
                                  dashController.changeFilter(data);
                                  orderSource.clearFilters();
                                  orderSource.addFilter('status',
                                      FilterCondition(type: FilterType.equals, value: data,
                                          filterBehavior: FilterBehavior.stringDataType));
                                },
                                child: Container(
                                    width: 110,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: dashController.selectedFilter.value==data? AppColors.primaryColor:AppColors.fieldColor,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    alignment: Alignment.center,
                                    child: TextWidget(text: data.toString(), size: 12, fontFamily: "regular", color: dashController.selectedFilter.value==data? AppColors.whiteColor:
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
                        controller: dashController.dataGridController,
                        key: dashController.key,
                        source: orderSource,
                        showCheckboxColumn: true,
                        checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                        ),
                        checkboxColumnSettings: const DataGridCheckboxColumnSettings(showCheckboxOnHeader: false),
                        selectionMode: SelectionMode.multiple,
                        columns: dashController.columns,
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
                    text: "Select delivery volunteer",
                    tap: (){
                      if(dashController.dataGridController.selectedIndex==-1){
                        BotToast.showSimpleNotification(title: "Please select at least one order",titleStyle: MyTextStyle.openSansRegular(14,AppColors.whiteColor),
                            borderRadius: 12.0,backgroundColor: Colors.red);
                      }
                      else{
                        Get.to(()=>const SelectDeliveryVolunteerScreen(title: "Select Delivery Volunteer"));
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
                image: AppImages.orders,
                title:"No Pending Orders",
                description:"No Pending Orders Data Found",
                imageHeight:250,
                titleStyle: MyTextStyle.openSansBold(22, AppColors.primaryDark),
                descriptionStyle: MyTextStyle.openSansRegular(16, AppColors.primaryDark))
        )
    ));

  }
}
