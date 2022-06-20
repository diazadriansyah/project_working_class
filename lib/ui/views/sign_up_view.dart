import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:project_working_class/ui/widgets/signups/form_image_data.dart';
import 'package:project_working_class/ui/widgets/signups/form_location_data.dart';
import 'package:project_working_class/ui/widgets/signups/form_personal_data.dart';
import 'package:project_working_class/viewmodels/sign_up_view_model.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatefulWidget {

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<SignUpViewModel>.reactive(
        viewModelBuilder: () => SignUpViewModel(),
        onModelReady: (model) => model.initState(),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: new Text(
              'Daftar',
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
              onPressed: (){
                model.backToLogin();
              },
            ),
            elevation: 0,
            backgroundColor: Color(0xffFAFAFA),
            centerTitle: true,
          ),
          body: LoadingOverlay(
            isLoading: model.busy,
            child: new Column(
              children: [
                Expanded(
                    child: Theme(
                      data: ThemeData(primarySwatch: Colors.red),
                      child: Stepper(
                        type: StepperType.horizontal,
                        currentStep: _currentStep,
                        controlsBuilder: (BuildContext context, ControlsDetails controls) {
                          return Row(
                            children: <Widget>[
                              Expanded(
                                child: TextButton(
                                onPressed: controls.onStepCancel,
                                  child: const Text('Kembali'),
                               )),
                               Expanded(
                                   child: TextButton(
                                 onPressed: controls.onStepContinue,
                                 child: const Text('Selanjutnya'),
                                ),
                              )
                            ],
                          );
                        },
                        onStepTapped: (int step) =>
                            setState(() => _currentStep = step),
                        onStepContinue: _currentStep < 2
                            ? () => setState(() => _currentStep += 1)
                            : null,
                        onStepCancel: _currentStep > 0
                            ? () => setState(() => _currentStep -= 1)
                            : null,
                        steps: <Step>[
                          new Step(
                              title: new Text('Pribadi'),
                            content: FormPersonalData(model: model),
                            isActive: _currentStep >= 0,
                            state: _currentStep >= 0
                                ? StepState.complete
                                : StepState.disabled
                          ),
                          new Step(
                              title: new Text('Gambar'),
                              content: FormImageData(model: model,),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 1
                                  ? StepState.complete
                                  : StepState.disabled
                          ),
                          new Step(
                              title: new Text('Lokasi'),
                              content: FormLocationData(model: model,),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 2
                                  ? StepState.complete
                                  : StepState.disabled
                          ),
                        ],
                      ),
                    )
                ),
                (_currentStep >= 2) ? Container(
                  child: ElevatedButton(
                    onPressed: () => model.register(context),
                    child: Text('Daftar'),
                  ),
                  width: size.width,
                ) : Container()
              ],
            ),
          ),
        ),
    );
  }
}