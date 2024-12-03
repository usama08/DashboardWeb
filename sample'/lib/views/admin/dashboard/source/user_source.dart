import 'package:charity_life/enums/dependencies.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class UserDataSource extends DataGridSource {
  UserDataSource(this.gymModel) {
    _buildDataRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<UserData> gymModel;
  var dashController = Get.put(DashController());

  void _buildDataRow() {
    dataGridRows = gymModel
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'userType', value: e.groupName),
      DataGridCell<String>(columnName: 'name', value: "${e.firstName} ${e.lastName}"),
      DataGridCell<String>(columnName: 'email', value: e.email),
      DataGridCell<String>(columnName: 'status', value:"${e.status}~${e.userId}"),
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
            TextWidget(text:e.columnName=="status"? e.value.toString().split("~").first:
              e.value.toString(), size: 13, fontFamily: "regular",
              color: e.columnName.toString()=="status"? const Color(0xFFFFB200):
              AppColors.greyDark));
        }).toList());
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}