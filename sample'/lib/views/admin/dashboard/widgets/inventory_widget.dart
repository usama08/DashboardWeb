import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../enums/dependencies.dart';

class InventoryWidget extends StatelessWidget {
  const InventoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var dashController = Get.put(DashController());


    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(text: "Inventory Levels", size: 16, fontFamily: "bold", color: AppColors.primaryDark),
                  const SizedBox(height: 5),
                  TextWidget(text: "Product Categories", size: 12, fontFamily: "regular", color: AppColors.greyLight),
                ],
              ),
              HeroIcon(HeroIcons.arrowPath,style: HeroIconStyle.solid,
                color: AppColors.primaryDark,
              )
            ],
          ),
          SfCircularChart(
              legend: Legend(isVisible: true,
              position: LegendPosition.bottom,
              textStyle: MyTextStyle.openSansRegular(14, AppColors.greyDark)),
              palette: const [
                Color(0xFFFF4838),
                Color(0xFFFFBA19),
                Color(0xFF48B54D),
              ],
              series: <CircularSeries>[
                DoughnutSeries<InvenInventoryLevel, String>(
                    dataSource: dashController.dashboardModel.data.invenInventoryLevels,
                    xValueMapper: (InvenInventoryLevel data, _) => data.category,
                    yValueMapper: (InvenInventoryLevel data, _) => data.value,
                      dataLabelMapper: (InvenInventoryLevel data, _) {
                        double total = dashController.dashboardModel.data.invenInventoryLevels.fold(0, (sum, item) => sum + item.value);
                        double percentage = (data.value / total) * 100;
                        return '${percentage.toStringAsFixed(1)}% (${data.value.toInt()})';
                      },
                    innerRadius: '70%',
                    explode: true,
                    explodeAll: true,
                    explodeOffset: "1%",
                    dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    margin: const EdgeInsets.all(3.0),
                    textStyle: MyTextStyle.openSansRegular(12, AppColors.greyDark),
                    labelPosition: ChartDataLabelPosition.outside,
                    connectorLineSettings: const ConnectorLineSettings(
                       type: ConnectorType.curve
                     )
                    ),
                )
              ]
          )
        ],
      ),
    );
  }
}
