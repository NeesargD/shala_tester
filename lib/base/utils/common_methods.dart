import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'constants/app_constant.dart';
import 'constants/color_constant.dart';
import 'constants/fontsize_constant.dart';

// Get Text Widget
Widget getTextWidget({required String title, Color textColor = ColorRes.primaryTextColor, double textFontSize = fontSize14, FontWeight? textFontWeight, TextAlign? textAlign, int? maxLines}) => Text(
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
Widget getBottomSheetAction({required BuildContext context, required IconData icon, required String title, required Function onTap}) => GestureDetector(
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
Future<String?> getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }
}

Future<String> getBundleId() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  return packageName;
}

// Common Date Picker
Future<DateTime?> pickDate({required BuildContext context, DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
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

Widget safeAreaWidget(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).padding.top,
  );
}

void launchURL(String url) async => await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future<void> handleGoogleSignIn() async {
  googleSignIn.signOut();
  try {
    await googleSignIn.signIn().then((value) {
      print(value);
      if (value != null) {
        var param = {
          "social_type": "1",
          "social_id": value.id,
          "name": value.displayName,
          "user_type": 2,
          "email": value.email
        };
      }
    });
  } catch (error) {
    print(error);
  }
}

Future<AuthorizationCredentialAppleID> signInWithApple() async {
  final credential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
  );
  final _appleUser = AuthorizationCredentialAppleID(
    authorizationCode: credential.authorizationCode,
    email: credential.email,
    familyName: credential.familyName,
    givenName: credential.givenName,
    identityToken: credential.identityToken,
    state: credential.state,
    userIdentifier: credential.userIdentifier,
  );
  var param = {
    "social_type": "3",
    "social_id": _appleUser.userIdentifier,
    "name": "${_appleUser.givenName} ${_appleUser.familyName}",
    "user_type": 2,
    "email": _appleUser.email
  };
  return _appleUser;
  //_callSocialLoginAPI(param);
}


