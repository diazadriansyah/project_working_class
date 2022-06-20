import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_working_class/locator.dart';
import 'package:project_working_class/services/navigation_service.dart';
import 'package:project_working_class/ui/router.dart';
import 'package:project_working_class/ui/views/login_view.dart';
import 'package:project_working_class/ui/views/startup_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runZoned(() {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      home: StartUpView(),
      onGenerateRoute: generateRoute,
      navigatorKey: locator<NavigationService>().navigationKey,
    );
  }
}
