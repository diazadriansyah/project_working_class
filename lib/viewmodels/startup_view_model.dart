import 'dart:async';

import 'package:project_working_class/constants/route_name.dart';
import 'package:project_working_class/locator.dart';
import 'package:project_working_class/services/navigation_service.dart';
import 'package:project_working_class/services/storage_service.dart';
import 'package:project_working_class/viewmodels/base_model.dart';
import 'package:package_info/package_info.dart';

class StartUpViewModel extends BaseModel {
  final StorageService _storageService = locator<StorageService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    final data = await _storageService.getString('guid');
    final role = await _storageService.getString('role');

    // PackageInfo packageInfo =  await PackageInfo.fromPlatform();
    // String packageName = packageInfo.packageName;

    if(data == null){
      _navigationService.replaceTo(LoginViewRoute);
    } else {
      if (role == "aparat") {
        _navigationService.replaceTo(DashboardViewRoute);
      } else {
        _navigationService.replaceTo(LoginViewRoute);
      }
    }
  }

  startUpTimer() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, handleStartUpLogic);
  }



}