import 'package:charity_life/enums/dependencies.dart';

class AppColors {
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
  static Color primaryColor = const Color(0xFF44A349);
  static Color primaryLight = const Color(0xFF9CD99F);
  static Color primaryDark = const Color(0xFF0E2510);
  static Color greyLight = const Color(0xFF78808A);
  static Color greyDark = const Color(0xFF78808A);
  static Color fieldColor = const Color(0xFFEDEFF3);
  static Color fieldColorDark = const Color(0xFFE1E3E7);
  static Color hintColor = const Color(0xFF78808A);
  static Color background = const Color(0xff1E1E1E);

  static Color addtocart = const Color(0xffEDEFF3);
  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}
