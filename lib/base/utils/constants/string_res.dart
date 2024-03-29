import 'app_state.dart';

AppState appState = AppState();
bool iHealthAuthorized = false;

class StringRes {
  //error
  static const error = 'error';
  static const success = 'success';

  static const pleasWait = 'Please wait';
  static const discoveringBleDevice1 = 'While we discovering your selected device';

  // Network
  static const errorGeneral = 'errorGeneral';
  static const errorRequestCancelled = 'errorRequestCancelled';
  static const errorRequestTimeout = 'Unable to connect to server. Kindly check your internet connection!';
  static const noInternetMessage = 'Slow or no internet connection. Please check your internet settings.';
  static const somethingWentWrong = 'Something went wrong..! Please try again later';
  static const serverTimeout = 'Server timeout';
  static const errorTitle = 'Oops! something\'s missing...';
  static const errorDescription =
      'It seems like we can\'t find what you searched. The page you are looking for doesn\'t exist, isn\'t available or was loading incorrectly.';

  // Instructors_Screen

  static const String instructor = "Instructors";

  static const String arabic_language = "AR";
  static const String english_language = "EN";

  static const String style1 = "style1";
  static const String style2 = "style2";

  //TAGS
  static const String tagInstructor = 'tag_instructor';

  //language change
  static const String selectedLanguage = 'selected_language';
}
