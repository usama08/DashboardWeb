// ignore_for_file: file_names

import 'package:charity_life/enums/dependencies.dart';

class ChangepassController extends GetxController {
  TextEditingController oldpassController = TextEditingController();
  TextEditingController newpassController = TextEditingController();
  TextEditingController newConfirmpassController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var pass = true.obs;
  togglePassword() {
    pass.value = !pass.value;
    update();
  }

  var pass2 = true.obs;
  togglePassword2() {
    pass2.value = !pass2.value;
    update();
  }

  var pass3 = true.obs;
  togglePassword3() {
    pass3.value = !pass3.value;
    update();
  }
}
