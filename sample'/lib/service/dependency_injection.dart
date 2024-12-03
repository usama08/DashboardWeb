import 'package:charity_life/enums/dependencies.dart';

class DependencyInjection{
 static Future<void> init() async{
    Get.lazyPut(()=> AuthController(),fenix: true);
    Get.lazyPut(()=> DashController(),fenix: true);
  }
}