import 'package:charity_life/enums/dependencies.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class OrderDataSource extends DataGridSource {
  OrderDataSource(this.gymModel) {
    _buildDataRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<OrderModel> gymModel;
  var dashController = Get.put(DashController());

  void _buildDataRow() {
    dataGridRows = gymModel
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'orderID', value: e.orderNo),
      DataGridCell<String>(columnName: 'beneficiary', value: e.beneficiaryName),
      DataGridCell<double>(columnName: 'amount', value: e.paidAmount),
      DataGridCell<DateTime>(columnName: 'date', value: e.orderDate),
      DataGridCell<String>(columnName: 'status', value: e.status),
    ])).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(
      DataGridRow row,
      ) {
    return DataGridRowAdapter(

        cells: row.getCells().map<Widget>((e) {
          return Padding(padding: const EdgeInsets.only(left: 20,top: 15),child:
          e.columnName.toString()=="beneficiary"?
              SizedBox(
                width: 10,
                child: TextWidget(text: e.value.toString(), size: 13, fontFamily: "regular",
                    color: e.value.toString()=="Dispatch"? const Color(0xFF5C33CF):
                    e.value.toString()=="In Process"? const Color(0xFFFFB200):
                    e.value.toString()=="Completed"? AppColors.primaryColor:
                    AppColors.greyDark,overflow: TextOverflow.ellipsis,)
              ):
          e.columnName.toString()=="date"?
          TextWidget(text: DateFormat("MMM dd, yyyy hh:mm:ss a").format(e.value), size: 13, fontFamily: "regular",
            color: e.value.toString()=="Dispatch"? const Color(0xFF5C33CF):
            e.value.toString()=="In Process"? const Color(0xFFFFB200):
            e.value.toString()=="Completed"? AppColors.primaryColor:
            AppColors.greyDark,overflow: TextOverflow.ellipsis,):
          TextWidget(text: e.value.toString(), size: 13, fontFamily: "regular",
              color: e.value.toString()=="Dispatch"? const Color(0xFF5C33CF):
              e.value.toString()=="In Process"? const Color(0xFFFFB200):
              e.value.toString()=="Completed"? AppColors.primaryColor:
              AppColors.greyDark));
        }).toList());
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}