import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:window_manager/window_manager.dart';
import 'constants.dart';
import './routes.dart';
import './pages/login/login_view.dart';
import './sample_bindings.dart';

void main() async {
  SampleBindings().dependencies();
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowManager.instance.setMinimumSize(const Size(1100, 768));
    WindowManager.instance.setMaximumSize(const Size(1100, 768));
  }
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Oldtimer',
        theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade700,
            centerTitle: true,
            foregroundColor: Colors.grey.shade300,
          ),
          textTheme: TextTheme(
            displayLarge: kMyTextStyle,
            bodyLarge: kMybodyTextStyleLarge,
            bodyMedium: kMybodyTextStyleMedium,
            bodySmall: kMybodyTextStyleSmall,
            labelMedium: kMyLabelFormFieldStyleMedium,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.namedRoute,
        getPages: SampleRoutes.samplePages);
  }
}
