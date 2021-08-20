import 'package:get_it/get_it.dart';
import '../utils/navigation/navigation_utils.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<NavigationUtils>(NavigationUtils());
}
