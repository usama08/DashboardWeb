// ignore_for_file: library_private_types_in_public_api
import 'package:charity_life/enums/dependencies.dart';

class CustomLoading extends StatefulWidget {
  final CancelFunc cancelFunc;

  const CustomLoading({super.key,required this.cancelFunc});

  @override
  _CustomLoadingState createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> {

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20)
      ), 
      child:  Padding(
        padding: const EdgeInsets.all(25.0),
        child: LoadingAnimationWidget.threeArchedCircle(color: AppColors.primaryColor, size: 40),
      ),
    );
  }
}
