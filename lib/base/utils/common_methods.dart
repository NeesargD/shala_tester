import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'constants/app_constant.dart';
import 'constants/color_constant.dart';
import 'constants/dic_params.dart';
import 'constants/fontsize_constant.dart';
import 'dialog_utils.dart';
import 'localization/localization.dart';

// Get Text Widget
Widget getTextWidget(
        {required String title,
        Color textColor = ColorRes.primaryTextColor,
        double textFontSize = fontSize14,
        FontWeight? textFontWeight,
        TextAlign? textAlign,
        int? maxLines}) =>
    Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
        fontSize: textFontSize,
        color: textColor,
        fontWeight: textFontWeight,
      ),
    );

// Get Bottom Sheet
Widget getBottomSheetAction(
        {required BuildContext context,
        required IconData icon,
        required String title,
        required Function onTap}) =>
    GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            ClipOval(
              child: Container(
                color: ColorRes.primaryColor,
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
            getTextWidget(title: title, textFontSize: fontSize14),
          ],
        ),
      ),
    );

// Pick Image From Gallery
// Future<File> getImageFromGallery(BuildContext context) async {
//   final _picker = ImagePicker();
//   var _file;
//   try {
//     final pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: imageQuality,
//     );
//     if (pickedFile != null) {
//       _file = File(pickedFile.path);
//     }
//   } on PlatformException catch (e) {
//     if (e.code == permissionTypePhotos) {
//       openSettings(context);
//     }
//   }
//   return _file;
// }

// Pick Image From Camera
// Future<File> getImageFromCamera(BuildContext context) async {
//   final _picker = ImagePicker();
//   var _file;
//   try {
//     final pickedFile = await _picker.pickImage(
//       source: ImageSource.camera,
//       preferredCameraDevice: CameraDevice.rear,
//       imageQuality: imageQuality,
//     );
//     if (pickedFile != null) {
//       _file = File(pickedFile.path);
//     }
//   } on PlatformException catch (e) {
//     if (e.code == permissionTypeCamera) {
//       openSettings(context);
//     }
//   }
//   return _file;
// }

// To Open App Settings
// void openSettings(BuildContext context) {
//   showOkCancelAlertDialog(
//     context: context,
//     message: Localization.of(context)!.alertPermissionNotRestricted,
//     cancelButtonTitle: Localization.of(context)!.cancel,
//     okButtonTitle: Localization.of(context)!.ok,
//     okButtonAction: () {
//       AppSettings.openAppSettings();
//     },
//   );
// }

// To Get the Device ID
Future<String> getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }
}

// Common Date Picker
Future<DateTime?> pickDate(
    {required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate}) async {
  final picked = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime.now(),
    lastDate: lastDate ?? DateTime(DateTime.now().year + lastYear),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light().copyWith(primary: ColorRes.primaryColor),
        ),
        child: child!,
      );
    },
  );
  return picked ?? initialDate;
}

double screenHeight({required BuildContext context, double percent = 1}) {
  return MediaQuery.of(context).size.height * percent;
}

double screenWidth({required BuildContext context, double percent = 1}) {
  return MediaQuery.of(context).size.width * percent;
}