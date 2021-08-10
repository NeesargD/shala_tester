import 'localization.dart';

class LocalizationEN implements Localization {
  @override
  String get appName => "Base Project";

  @override
  String get ok => "OK";

  @override
  String get cancel => "Cancel";

  @override
  String get alertPermissionNotRestricted =>
      "Please grant permission from settings to access this feature";

  @override
  String get internetNotConnected =>
      "No internet connection. Please check your internet connection";

  @override
  String get poorInternetConnection =>
      "Poor internet connection. Please check your internet connection";

  @override
  String get delete => "Delete";

  @override
  String get edit => "Edit";

  @override
  String get done => "Done";

  @override
  String get cameraTitle => "Camera";

  @override
  String get galleryTitle => "Gallery";

  @override
  String get no => "No";

  @override
  String get yes => "Yes";

  @override
  String get logout => "Logout";

  @override
  String get save => "Save";

  @override
  String get search => "Search";
}
