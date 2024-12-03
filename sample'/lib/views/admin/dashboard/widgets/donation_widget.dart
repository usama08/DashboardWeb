//ignore_for_file: deprecated_member_use
import 'package:intl/intl.dart';
import '../../../../enums/dependencies.dart';

class DonationWidget extends StatefulWidget {
  final int donationIndex;
  final DonationData data;
  const DonationWidget({super.key, required this.donationIndex, required this.data});

  @override
  State<DonationWidget> createState() => _DonationWidgetState();
}

class _DonationWidgetState extends State<DonationWidget> {
  @override
  Widget build(BuildContext context) {
    var dashController = Get.put(DashController());

    return Padding(padding: const EdgeInsets.only(bottom: 10),
       child: Row(
          children: [
            CheckboxTheme(
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
               child:widget.data.isPost==true? Padding(padding: const EdgeInsets.only(left: 8,right: 12),child: HeroIcon(HeroIcons.checkBadge,color: AppColors.primaryColor,style: HeroIconStyle.solid,
               size: 30)):
               Checkbox(value: dashController.selectedDonationList.contains(widget.data.voucherId)?true:false, onChanged: (val){
                 dashController.selectDonation(widget.data.voucherId);
                 setState(() {
                 });
              }, shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(4)
                ))),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    color: dashController.selectedDonationList.contains(widget.data.voucherId) ? const Color(0xffE3F5E3): Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(text: 'Donor Name', size: 11, fontFamily: 'bold', color: AppColors.primaryDark),
                                TextWidget(text: widget.data.donorName.toString(), size: 13, fontFamily: 'regular', color: AppColors.primaryDark.withOpacity(0.6)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(text: 'Receipt', size: 11, fontFamily: 'bold', color: AppColors.primaryDark),
                                TextWidget(text: widget.data.voucherNo.toString(), size: 13, fontFamily: 'regular', color: AppColors.primaryDark.withOpacity(0.6)),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(text: 'Amount', size: 11, fontFamily: 'bold', color: AppColors.primaryDark),
                                TextWidget(text: "SAR ${widget.data.debit.toString()}", size: 13, fontFamily: 'regular', color: AppColors.primaryDark.withOpacity(0.6)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(text: 'Status', size: 11, fontFamily: 'bold', color: AppColors.primaryDark),
                                TextWidget(text: widget.data.isPost==true?"Posted":"Un-posted", size: 13, fontFamily: 'regular',
                                  color:
                                  widget.data.isPost==true? AppColors.primaryColor :
                                  Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(text: 'Date', size: 11, fontFamily: 'bold', color: AppColors.primaryDark),
                            TextWidget(text: DateFormat("dd-MM-yyyy").format(widget.data.voucherDate), size: 13, fontFamily: 'regular', color: AppColors.primaryDark.withOpacity(0.6)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
    ));
  }
}
