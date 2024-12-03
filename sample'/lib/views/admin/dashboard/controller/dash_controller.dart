import 'package:charity_life/enums/dependencies.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DashController extends GetxController {
  APIService apiService = APIService();
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  final GlobalKey<SfDataGridState> key2 = GlobalKey<SfDataGridState>();
  final DataGridController dataGridController = DataGridController();
  final DataGridController dataGridController2 = DataGridController();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refreshData() {
    return getDashboard().then((user) {});
  }

  var loginController = Get.put(AuthController());

  List<GridColumn> columns = [
    GridColumn(
        columnName: 'orderID',
        label: Container(
            padding: const EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            child: TextWidget(
                text: "Order ID",
                size: 14,
                fontFamily: "bold",
                color: AppColors.primaryDark))),
    GridColumn(
        columnName: 'beneficiary',
        label: Container(
            padding: const EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            child: TextWidget(
                text: "Beneficiary",
                size: 14,
                fontFamily: "bold",
                color: AppColors.primaryDark))),
    GridColumn(
        columnName: 'amount',
        label: Container(
            padding: const EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            child: TextWidget(
                text: "Amount",
                size: 14,
                fontFamily: "bold",
                color: AppColors.primaryDark))),
    GridColumn(
        columnName: 'date',
        label: Container(
            padding: const EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            child: TextWidget(
                text: "Order Date",
                size: 14,
                fontFamily: "bold",
                color: AppColors.primaryDark))),
    GridColumn(
        columnName: 'status',
        label: Container(
            padding: const EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            child: TextWidget(
                text: "Status",
                size: 14,
                fontFamily: "bold",
                color: AppColors.primaryDark))),
  ];

  List<GridColumn> columns2 = [
    GridColumn(
        columnName: 'userType',
        label: Container(
            padding: const EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            child: TextWidget(
                text: "User Type",
                size: 14,
                fontFamily: "bold",
                color: AppColors.primaryDark))),
    GridColumn(
        columnName: 'name',
        label: Container(
            padding: const EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            child: TextWidget(
                text: "Name",
                size: 14,
                fontFamily: "bold",
                color: AppColors.primaryDark))),
    GridColumn(
        columnName: 'email',
        label: Container(
            padding: const EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            child: TextWidget(
                text: "Email",
                size: 14,
                fontFamily: "bold",
                color: AppColors.primaryDark))),
    GridColumn(
        columnName: 'status',
        label: Container(
            padding: const EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            child: TextWidget(
                text: "Status",
                size: 14,
                fontFamily: "bold",
                color: AppColors.primaryDark))),
  ];

  var filters = ["In Process", "Completed", "Dispatch", "Cancelled"];
  var selectedFilter = "".obs;

  changeFilter(filterValue) {
    selectedFilter.value = filterValue;
    update();
  }

  resetOrders() {
    selectedFilter.value = "";
    update();
  }

  var userFilters = [
    "All",
    "Admin",
    "Donor",
    "Beneficiary",
    "Delivery",
    "Supplier"
  ];
  var selectedUserFilter = "All".obs;

  changeUserFilter(filterValue) {
    selectedUserFilter.value = filterValue;
    update();
  }

  var donationFilters = ["All", "Posted", "Unposted"];
  var selectedDonationFilter = "All".obs;

  changeDonationFilter(filterValue) {
    selectedDonationFilter.value = filterValue;
    update();
  }

  DashboardModel dashboardModel = DashboardModel(
      success: false,
      message: "Error",
      data: Data(
          totalDonations: "0.0",
          growthRateDonation: 0.0,
          invenInventoryLevels: []));
  var isLoading = false.obs;

  ////////// DASHBOARD DATA \\\\\\\\\\
  Future<void> getDashboard() async {
    isLoading.value = true;
    update();

    apiService.dashboardData().then((response) {
      if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == true) {
        dashboardModel = DashboardModel.fromJson(json.decode(response.body));
        update();
        getOrders();
      } else if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == false) {
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        update();
      }
    });
  }

  var orderData = <OrderModel>[].obs;
  ////////// GET ORDERS DATA \\\\\\\\\\
  Future<void> getOrders() async {
    apiService.getOrderData(loginController.loginData.groupId).then((response) {
      if (response != null && response.statusCode == 200) {
        List data = (json.decode(response.body) as List);
        orderData.value =
            data.map((data) => OrderModel.fromJson(data)).toList();
        update();
        getDonations();
      } else {
        isLoading.value = false;
        update();
      }
    });
  }

  var donationData = <DonationData>[].obs;
  ////////// GET DONATIONS DATA \\\\\\\\\\
  Future<void> getDonations() async {
    apiService.donationsData().then((response) {
      if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == true) {
        List data = (json.decode(response.body)["Data"] as List);
        donationData.value =
            data.map((data) => DonationData.fromJson(data)).toList();
        update();
        getUserData();
      } else if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == false) {
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        update();
      }
    });
  }

  var selectedDonationList = [].obs;

  selectDonation(id) {
    if (selectedDonationList.contains(id)) {
      selectedDonationList
          .removeWhere((data) => data.toString() == id.toString());
    } else {
      selectedDonationList.add(id);
    }
    update();
  }

  resetDonations() {
    selectedDonationList.value = [];
    selectedDonationFilter.value = "All";
    update();
  }

  var userData = <UserData>[].obs;
  ////////// GET PENDING USER DATA \\\\\\\\\\
  Future<void> getUserData() async {
    apiService.getPendingUsers().then((response) {
      if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == true) {
        List data = (json.decode(response.body)["Data"] as List);
        userData.value = data.map((data) => UserData.fromJson(data)).toList();
        isLoading.value = false;
        update();
      } else if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == false) {
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        update();
      }
    });
  }

  var selectedVolunteerKey = Rx<String?>(null);

  final Map<String, String> volunteers = {
    '001': 'Muhammad Akbar',
    '002': 'Abdullah Faisal',
    '003': 'Muhammad Akbar',
    '004': 'Adnan Yousuf',
    '005': 'Shahid Anwar',
    '006': 'Muhammad Akbar',
    '007': 'Adnan Yousuf',
    '008': 'Shahid Anwar',
    '009': 'Adnan Yousuf',
    '010': 'Shahid Anwar',
  };

  var allocateUsers = [
    'Muhammad Akbar',
    'Abdullah Faisal',
    'Muhammad Akbar',
    'Adnan Yousuf',
    'Shahid Anwar',
    'Muhammad Akbar',
    'Adnan Yousuf',
    'Shahid Anwar',
    'Adnan Yousuf',
    'Shahid Anwar',
  ];

  ////////// POST DONATION \\\\\\\\\\
  Future<void> submitDonation(context) async {
    BotToast.showCustomLoading(
        clickClose: false,
        allowClick: false,
        backButtonBehavior: BackButtonBehavior.none,
        ignoreContentClick: false,
        animationDuration: const Duration(milliseconds: 200),
        animationReverseDuration: const Duration(milliseconds: 200),
        backgroundColor: const Color(0x42000000),
        align: Alignment.center,
        toastBuilder: (cancelFunc) {
          return CustomLoading(cancelFunc: cancelFunc);
        });

    apiService
        .postDonation(loginController.loginData.userId, selectedDonationList)
        .then((response) {
      if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == true) {
        BotToast.closeAllLoading();
        getDonations();
        getDashboard();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const DialogBox(
              heading: 'Donations posted!',
              body: 'Donation posted successfully.',
            );
          },
        );
      } else if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == false) {
        BotToast.showSimpleNotification(
            title: json.decode(response.body)["message"],
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return DialogBox(
              type: "Error",
              heading: 'Donation Posting Failed!',
              body: json.decode(response.body)["message"],
            );
          },
        );
        BotToast.closeAllLoading();
      } else {
        BotToast.closeAllLoading();
      }
    });
  }

  ////////// APPROVE USERS \\\\\\\\\\
  Future<void> userApproval(context) async {
    BotToast.showCustomLoading(
        clickClose: false,
        allowClick: false,
        backButtonBehavior: BackButtonBehavior.none,
        ignoreContentClick: false,
        animationDuration: const Duration(milliseconds: 200),
        animationReverseDuration: const Duration(milliseconds: 200),
        backgroundColor: const Color(0x42000000),
        align: Alignment.center,
        toastBuilder: (cancelFunc) {
          return CustomLoading(cancelFunc: cancelFunc);
        });

    apiService
        .approveUser(
            loginController.loginData.userId,
            dataGridController2.selectedRows
                .map((data) => int.parse(
                    data.getCells()[3].value.toString().split("~").last))
                .toList())
        .then((response) {
      if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == true) {
        BotToast.closeAllLoading();
        getUserData();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const DialogBox(
              heading: 'Users Approved!',
              body: 'Users approved successfully.',
            );
          },
        );
      } else if (response != null &&
          response.statusCode == 200 &&
          json.decode(response.body)["success"] == false) {
        BotToast.showSimpleNotification(
            title: json.decode(response.body)["message"],
            titleStyle: MyTextStyle.openSansRegular(14, AppColors.whiteColor),
            borderRadius: 12.0,
            backgroundColor: Colors.red);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return DialogBox(
              type: "Error",
              heading: 'User Approval Failed!',
              body: json.decode(response.body)["message"],
            );
          },
        );
        BotToast.closeAllLoading();
      } else {
        BotToast.closeAllLoading();
      }
    });
  }
}
