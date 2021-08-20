import 'package:intl/intl.dart';

class AppState {
  static final AppState _singleton = AppState._internal();

  factory AppState() {
    return _singleton;
  }

  AppState._internal();





  DateFormat format = DateFormat('yyyy-MM-dd');
  DateFormat formatDD = DateFormat('dd-MM-yyyy');
  DateFormat formatDT = DateFormat('dd-MM-yyyy HH:mm');

}