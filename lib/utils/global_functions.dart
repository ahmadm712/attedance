import 'package:flutter/material.dart';

class GlobalFunctions {
  static bool validate({required GlobalKey<FormState> formkey}) {
    if (formkey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  static scafoldMessage(
      {required BuildContext context,
      required String message,
      required Color color}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          message,
        ),
      ),
    );
  }

  static Size screenSize({required BuildContext context}) {
    return MediaQuery.of(context).size;
  }

  static TextTheme textTheme({required BuildContext context}) {
    return Theme.of(context).textTheme;
  }

  static clearField({required TextEditingController controller}) {
    return controller.clear();
  }
}
