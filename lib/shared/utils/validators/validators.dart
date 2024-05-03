import 'package:flutter/material.dart';

String? validateCheckoutTime(TextEditingController checkoutTimeController,
    TextEditingController checkinTimeController) {
  if (checkoutTimeController.text.isNotEmpty) {
    if (DateTime.parse(checkoutTimeController.text)
        .isBefore(DateTime.parse(checkinTimeController.text))) {
      return 'Must be after checkin';
    }
  }
  return null;
}

String? validatePlate(String? value) {
  if (value == null || value.isEmpty) {
    return 'The plate can not be empty.';
  }
  if (value.length < 7) {
    return 'The plate is invalid';
  }
  return null;
}
