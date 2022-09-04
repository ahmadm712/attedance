import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GlobalFunctions {
  bool validate({required GlobalKey<FormState> formkey}) {
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

  TextTheme textTheme({required BuildContext context}) {
    return Theme.of(context).textTheme;
  }

  static clearField({required TextEditingController controller}) {
    return controller.clear();
  }

  static DateTime convertFromJson(Timestamp value) {
    return value.toDate();
  }

  static dynamic convertToJson(DateTime value) {
    return value.toUtc();
  }
}
