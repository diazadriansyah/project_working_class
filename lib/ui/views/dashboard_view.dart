import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_working_class/constants/route_name.dart';
import 'package:project_working_class/ui/shared/ui_helper.dart';
import 'package:project_working_class/viewmodels/dashboard_view_model.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      onModelReady: (model) => model.initData(context),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
                'Beranda'
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Login Berhasil !",
                        style: TextStyle(
                            fontSize: 40
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: (){
                            model.signOut(context);
                          },
                          child: Text(
                              "Keluar"
                          ),
                        ),
                        horizontalSpaceMedium,
                        MaterialButton(
                          onPressed: (){
                            model.goAnotherView(ReportViewRoute);
                          },
                          child: Text(
                              "Pelaporan"
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
