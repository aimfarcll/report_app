// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report_app/auth/auth_page.dart';
import 'package:report_app/auth/main_page.dart';
import 'package:report_app/main.dart';
import 'package:report_app/pages/dashboard_page.dart';
import 'package:report_app/pages/home_page.dart';
import 'package:report_app/sign/signature_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int currentStep = 0;
  bool isCompleted = false;
  final user = FirebaseAuth.instance.currentUser!;


  //for dropdown widget, initial selected value

  //text editing controllers
  final clientName = TextEditingController();
  final clientAddress = TextEditingController();
  final clientState = TextEditingController();
  final clientPostcode = TextEditingController();
  final problemReport = TextEditingController();
  final equipment = TextEditingController();
  final model = TextEditingController();
  final serialNo = TextEditingController();


  List<String> _serviceValues = ['Project', 'Maintenance', 'Ad-Hoc', 'Others'];
  String _selectedValue = "Project";

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text(
            'Client Details',
            style: GoogleFonts.ubuntu(),
          ),
          //ada clientname, date and time, key sales order
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: clientName,
                decoration: InputDecoration(
                  labelText: 'Client Name',
                  labelStyle: GoogleFonts.ubuntu(
                    fontSize: 15,
                  ),
                  /*errorMaxLines: 2,
                  contentPadding: EdgeInsets.all(20),
                  filled: true,
                  fillColor: Colors.indigo[100],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.indigo,
                      width: 1.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),*/
  ),
  ),
        ],
  ),
  ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text(
            'Address',
            style: GoogleFonts.ubuntu(),
          ),
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: clientAddress,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: clientState,
                decoration: InputDecoration(labelText: 'State'),
              ),
              TextFormField(
                controller: clientPostcode,
                decoration: InputDecoration(labelText: 'Postcode'),
              ),
            ],
          ),
        ),
        Step(
            isActive: currentStep >= 2,
            title: Text(
              'Service Description',
              style: GoogleFonts.ubuntu(),
            ),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: problemReport,
                    decoration: InputDecoration(labelText: 'Problem Reported'),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(),
                          child: TextFormField(
                            controller: equipment,
                            decoration:
                                InputDecoration(labelText: 'Equipment:'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: model,
                            decoration: InputDecoration(labelText: 'Model: '),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: serialNo,
                            decoration:
                                InputDecoration(labelText: 'Serial No: '),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                //textfield for Problem reported

                //Row for model equipment, serial no
              ),
            )),

        //dropdown for service type
        Step(
          isActive: currentStep >= 3,
          title: Text(
            'Service Type',
            style: GoogleFonts.ubuntu(),
          ),
          content: Container(
            child: DropdownButton(
              //hint: Text('-Select-'),
              value: _selectedValue,
              onChanged: (newValue) {
                setState(() => _selectedValue = newValue as String);
              },
              items: _serviceValues.map((serviceValue) {
                return DropdownMenuItem(
                  child: new Text(serviceValue),
                  value: serviceValue,
                );
              }).toList(),
            ),
          ),
        ),

        Step(
          isActive: currentStep >= 4,
          title: Text(
            'Report Issues',
            style: GoogleFonts.ubuntu(),
          ),
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: clientAddress,
                decoration: InputDecoration(
                    labelText: 'Task Completed',
                    hintText: 'Implementation Details'),
              ),
              TextFormField(
                controller: clientState,
                decoration: InputDecoration(labelText: 'Technical Issues'),
              ),
              TextFormField(
                controller: clientPostcode,
                decoration: InputDecoration(labelText: 'Remarks'),
              ),
            ],
          ),
        ),

        Step(
          isActive: currentStep >= 5,
          title: Text(
            'Verification',
            style: GoogleFonts.ubuntu(),
          ),
          content:  OutlinedButton.icon( // <-- OutlinedButton
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignaturePage()));
            },
            icon: Icon(
              Icons.verified,
              size: 24.0,
            ),
            label: Text('Verify Report'),
          ),
        ),

        Step(
          isActive: currentStep >= 6,
          title: Text(
            'Complete',
            style: GoogleFonts.ubuntu(),
          ),
          content: Container(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title:
            Text(
              'Weekly Status Report',
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.bold,
                color: Colors.indigo[900],
              ),
            ),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => myForm()));
                },
                icon: Icon(Icons.arrow_back_ios,
                color: Colors.indigo[900],),
              ),

             actions: [
              IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthPage()));
    },
    icon: Icon(Icons.logout_outlined,
      color: Colors.indigo[900],
    ),
              ),
  ],



  //bawah ni for icon menu (TBC)
          /*iconTheme: IconThemeData(color: Colors.indigo[900]),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],*/
          backgroundColor: Colors.white),

      //Stepper widget
      body: Theme(
        data: ThemeData(
            accentColor: Colors.indigo[900],
            primarySwatch: Colors.indigo,
            colorScheme: ColorScheme.light(primary: Colors.indigo)),
        child: Stepper(
          type: StepperType.vertical,
          steps: getSteps(),
          //add current step
          currentStep: currentStep,
          //everytime click on continue button akan change state
          onStepContinue: () {
            //this is to know if we are at the last step
            final isLastStep = currentStep == getSteps().length - 1;
            //send data to server & display Submit notification
            if (isLastStep) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Submitted!'),
                  duration: Duration(seconds: 2),
                ),
              );
              setState(() => isCompleted = true);
              print('Completed!');
              //delay 3 seconds, then go back to home page
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context).pop(SignaturePage());
              });
            } else {
              setState(() => currentStep += 1);
            }
            ;
          },
          //utk switch between steps just by clicking
          onStepTapped: (step) => setState(() => currentStep = step),

          onStepCancel:
              //to make sure if we are at the first step, cancel button is unclickable
              currentStep == 0 ? null : () => setState(() => currentStep -= 1),

          //make button utk back and next
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            //checking function to see if were at the last step
            final isLastStep = currentStep == getSteps().length - 1;

            return Container(
              margin: EdgeInsets.only(top: 50),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      //if last step this function will display SUBMIT, if not just NEXT
                      //child: Text(isLastStep ? 'SUBMIT' : 'NEXT'),
                      onPressed: controls.onStepContinue,
                      child: isLastStep
                          ? isCompleted
                              ? CircularProgressIndicator()
                              : Text('SUBMIT')
                          : Text('NEXT'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  //hide back button if were at the first step, if not display back
                  if (currentStep != 0 && !isCompleted)
                    Expanded(
                      child: ElevatedButton(
                        child: Text('BACK'),
                        onPressed: controls.onStepCancel,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
