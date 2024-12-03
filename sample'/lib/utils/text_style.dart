import 'package:charity_life/enums/dependencies.dart';

class MyTextStyle {

  ///// OPEN SANS FONT FAMILY
  static openSansRegular(size,color,{TextDecoration? decoration}){
    return TextStyle(
        fontFamily: "OpenSans-Regular",
        fontSize: double.parse(size.toString()),
        color: color,
        decoration: decoration,
        decorationColor: Colors.red
    );
  }

  static openSansBold(size,color,{TextDecoration? decoration}){
    return TextStyle(
        fontFamily: "OpenSans-Bold",
        fontSize: double.parse(size.toString()),
        color: color,
        decoration: decoration,
        decorationColor: Colors.red

    );
  }

  static openSansSemiBold(size,color,{TextDecoration? decoration}){
    return TextStyle(
        fontFamily: "OpenSans-SemiBold",
        fontSize: double.parse(size.toString()),
        color: color,
        decoration: decoration,
        decorationColor: Colors.red
    );
  }

}