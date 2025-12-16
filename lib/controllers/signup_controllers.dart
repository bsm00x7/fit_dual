import 'package:flutter/cupertino.dart';

import '../service/auth.dart';

class SignupControllers  extends ChangeNotifier{

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool isLoading = false;




  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال البريد الإلكتروني ';
    }
    // Check if it's an email or phone number
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return 'الرجاء إدخال بريد إلكتروني أو رقم هاتف صحيح';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال كلمة المرور';
    }

    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    if (confPasswordController.text.trim() != passwordController.text.trim()){
      return 'الرجاء إدخال كلمة المرور';

    }
    return null;
  }
  Future<void> handleLogin({required BuildContext context}) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();

      await Auth.createAccountWithEmailAndPasswordAndName(
        name: userNameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          context: context
      );

      isLoading = false;
      notifyListeners();
    }
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}