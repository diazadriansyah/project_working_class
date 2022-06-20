import 'package:flutter/cupertino.dart';
import 'package:project_working_class/constants/route_name.dart';
import 'package:project_working_class/locator.dart';
import 'package:project_working_class/services/alert_service.dart';
import 'package:project_working_class/services/api_service.dart';
import 'package:project_working_class/services/navigation_service.dart';
import 'package:project_working_class/services/storage_service.dart';
import 'package:project_working_class/ui/views/dashboard_view.dart';
import 'package:project_working_class/viewmodels/base_model.dart';

class LoginViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ApiService _apiService = locator<ApiService>();
  final StorageService _storageService = locator<StorageService>();
  final AlertService _alertService = locator<AlertService>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void navigateToSignUpView(){
    _navigationService.navigateTo(SignUpViewRoute);
  }

  void logginAccount(BuildContext context) async {
    setBusy(true);
    if(emailController.text.length > 0 && passwordController.text.length > 0){
      final data = await _apiService.newLogin(
          emailController.text.trim(), passwordController.text.trim());

      if (data != null){
        await _storageService.setString('PHONE_NUMBER', data.data.phoneNumber);
        await _storageService.setString('name', data.data.name);
        await _storageService.setString('email', data.data.email);
        await _storageService.setString('company', data.data.company);
        await _storageService.setString('unit', data.data.unit);
        await _storageService.setString('position', data.data.position);
        await _storageService.setString('local_image', data.data.localImage);
        await _storageService.setString('guid', data.data.guid);
        await _storageService.setString('image', data.data.image);
        await _storageService.setString('app_type', data.data.appType);
        await _storageService.setString('role', data.data.role);

        _navigationService.replaceTo(DashboardViewRoute);
      } else {
        _alertService.showAlert(context, 'Kesalahan', 'Nama atau kata sandi salah', _navigationService.pop);
      }
    } else {
      _alertService.showAlert(context, 'Peringatan', 'Isi semua kolom', _navigationService.pop);
    }
    setBusy(false);
  }


}