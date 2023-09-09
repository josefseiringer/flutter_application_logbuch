import 'package:get/get.dart';
import './pages/car/car_view.dart';
import './pages/car/car_binding.dart';
import './pages/login/login_bindings.dart';
import './pages/log/log_view.dart';
import './pages/login/login_view.dart';
import './pages/entry/entry_view.dart';
import './pages/entry/entry_binding.dart';
import './pages/settings/settings_view.dart';
import './pages/settings/settings_binding.dart';

class SampleRoutes {
  static List<GetPage<dynamic>> samplePages = [
    GetPage(
        name: LoginPage.namedRoute,
        page: ((() => const LoginPage())),
        binding: LoginBinding()),
    GetPage(
        name: SettingsPage.namedRoute,
        page: ((() => const SettingsPage())),
        binding: SettingsBinding()),
    GetPage(
        name: CarPage.namedRoute,
        page: ((() => const CarPage())),
        binding: CarBinding()),
    GetPage(
        name: LogPage.namedRoute,
        page: ((() => const LogPage())),
        binding: LoginBinding()),
    GetPage(
        name: EntryPage.namedRoute,
        page: ((() => const EntryPage())),
        binding: EntryBinding()),
  ];
}
