// import 'package:flutter/material.dart';
//
// import 'constants/app_constant.dart';
// import 'localization/localization.dart';

// class Utils {
//   static bool isEmailValid(String value) {
//     if (!RegExp(validEmailRegex).hasMatch(value)) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   static String isValidEmail(BuildContext context, String value) {
//     if (value.isEmpty) {
//       return Localization.of(context).msgEnterEmailAddress;
//     } else if (Utils.isEmailValid(value.trim())) {
//       return Localization.of(context).msgEnterValidEmailAddress;
//     } else {
//       return null;
//     }
//   }

//   static String isEmpty(BuildContext context, String value, String message) {
//     if (value.trim().isEmpty) {
//       return message;
//     } else {
//       return null;
//     }
//   }

//   static bool isPasswordValidate(String value) {
//     if (value.isEmpty) {
//       return false;
//     } else if (!RegExp(validPasswordRegex).hasMatch(value)) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   static String isValidNewPassword(BuildContext context, String value) {
//     if (value.isEmpty) {
//       return Localization.of(context).msgEnterNewPassword;
//     } else if (Utils.isPasswordValidate(value.trim())) {
//       return Localization.of(context).msgEnterValidPassword;
//     } else {
//       return null;
//     }
//   }

//   static String isValidConfirmPassword(
//       BuildContext context, String newPassword, String confirmPasswod) {
//     if (confirmPasswod.trim().isEmpty) {
//       return Localization.of(context).msgEnterConfirmPassword;
//     } else if (newPassword.trim() != confirmPasswod.trim()) {
//       return Localization.of(context).msgEnterValidConfirmPassword;
//     } else {
//       return null;
//     }
//   }

//   static String isMobileNumberValid(BuildContext context, String value) {
//     if (value.trim().isEmpty) {
//       return Localization.of(context).msgEnterMobile;
//     } else if (!RegExp(validMobileRegex).hasMatch(value.trim())) {
//       return Localization.of(context).msgEnterValidMobile;
//     }
//     return null;
//   }
// }