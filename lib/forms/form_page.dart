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
import 'package:report_app/pages/listForm.dart';
import 'package:report_app/sign/signature_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int currentStep = 0;
  bool isCompleted = false;
  final user = FirebaseAuth.instance.currentUser!;

  CollectionReference _referencemyForms = FirebaseFirestore.instance.collection('myForms');


  //for dropdown widget, initial selected value

  //text editing controllers
  final dateinput = TextEditingController();
  final timeinput = TextEditingController();
  final clientName = TextEditingController();
  final clientAddress = TextEditingController();
  final clientState = TextEditingController();
  final clientPostcode = TextEditingController();
  final problemReport = TextEditingController();
  final equipment = TextEditingController();
  final model = TextEditingController();
  final serialNo = TextEditingController();
  final task = TextEditingController();
  final technical = TextEditingController();
  final remarks = TextEditingController();



  List<String> _serviceValues = ['Project', 'Maintenance', 'Ad-Hoc', 'Others'];
  String _selectedValue = "Project";

  List<String> _stateValues = [
    'Johor',
    'Kedah',
    'Kelantan',
    'Perak',
    'Selangor',
    'Malacca',
    'Negeri Sembilan',
    'Pahang',
    'Perlis',
    'Penang',
    'Sabah',
    'Sarawak',
    'Terengganu'
  ];
  String _selectedValue1 = "Johor";


  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text(
            'Date',
            style: GoogleFonts.ubuntu(),
          ),
          //ada clientname, date and time, key sales order
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: dateinput,
                decoration: InputDecoration(
                 // enabledBorder: OutlineInputBorder(
                   // borderSide: BorderSide(
                      //  width: 2, color: Colors.indigo),
                  //),
                  icon: Icon(Icons.calendar_today),
                  labelText: 'Date',
                  labelStyle: GoogleFonts.ubuntu(
                    fontSize: 15,
                  ),
  ),
                  readOnly: true,  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context, initialDate: DateTime.now(),
                        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101)
                    );

                    if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateinput.text = formattedDate; //set output date to TextField value.
                      });
                    }else{
                      print("Date is not selected");
                    }
                  },
                ),
                ],
                ),
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

    Step(
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 1,
      title: Text(
        'Time',
        style: GoogleFonts.ubuntu(),
      ),
      //ada clientname, date and time, key sales order
      content: Column(
        children: <Widget>[
          TextFormField(
            controller: timeinput,
            decoration: InputDecoration(
              icon: Icon(Icons.timer),
              labelText: 'Time',
              labelStyle: GoogleFonts.ubuntu(
                fontSize: 15,
              ),
            ),
            readOnly: true,  //set it true, so that user will not able to edit text
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());

              if(pickedTime != null ){
                print(pickedTime.format(context));  //pickedDate output format => 2021-03-10 00:00:00.000
                DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                //converting to DateTime so that we can further format on different pattern.
                print(parsedTime); //output 1970-01-01 22:53:00.000
                String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                print(formattedTime); //output 14:59:00

                setState(() {
                  timeinput.text = formattedTime; //set the value of text field.
                });
              }else{
                print("Time is not selected");
              }
            },
          ),
        ],
      ),
    ),


    //name
    Step(
      state: currentStep > 2 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 2,
      title: Text(
        'Client Name',
        style: GoogleFonts.ubuntu(),
      ),
      //ada clientname, date and time, key sales order
      content: Column(
        children: <Widget>[
          TextFormField(
            controller: clientName,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(
                 width: 1, color: Colors.black),
                ),
              //contentPadding: EdgeInsets.all(20.0),
              //icon: Icons.calendar_today,
              labelText: 'Name',
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
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: Text(
            'Address',
            style: GoogleFonts.ubuntu(),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: clientAddress,
                maxLines: 2,
                decoration: InputDecoration(
                    //floatingLabelBehavior: FloatingLabelBehavior.never,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.black),
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    //EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    labelText: 'Address'),
              ),
             // TextFormField(
               // controller: clientState,
                //decoration: InputDecoration(labelText: 'State'),
              //),
              SizedBox(height: 20),
              TextFormField(
                controller: clientPostcode,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.black),
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    labelText: 'Postcode'),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1, color: Colors.black),

                  ),
                ),
                //disabledHint: Text("Select state"),
                  //hint: Text('Select state'),
                  //value: _selectedValue1,
                //hint: Text("Choose an item"),
                hint: Text("Select state"),
                  onChanged: (newValue) {
                    setState(() => _selectedValue1 = newValue as String);
                  },
                  items: _stateValues.map((stateValue) {
                    return DropdownMenuItem(
                      child: new Text(stateValue),
                      value: stateValue,
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
        Step(
            isActive: currentStep >= 4,
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
                    maxLines: 4,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Colors.black),
                        ),
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                        labelText: 'Problem Reported'),
                  ),
                SizedBox(height: 20),
                //  Row(
                  //  crossAxisAlignment: CrossAxisAlignment.center,
                    //children: <Widget>[
                      //Expanded(
                        //child: Padding(
                          //padding: const EdgeInsets.only(),
                          //child:
                  TextFormField(
                            controller: equipment,
                            decoration:
                                InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black),
                                    ),
                                    contentPadding:
                                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                                    labelText: 'Equipment'),
                          ),
                  SizedBox(height: 20),
                      TextFormField(
                            controller: model,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black),
                                ),
                                contentPadding:
                                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                                labelText: 'Model '),

),
                  SizedBox(height: 20),
              TextFormField(
                            controller: serialNo,
                            decoration:
                                InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black),
                                    ),
                                    contentPadding:
                                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                                    labelText: 'Serial No '),
                          ),


                    ],
                  ),

                //textfield for Problem reported

                //Row for model equipment, serial no
              ),
            ),

        //dropdown for service type
        Step(
          isActive: currentStep >= 5,
          title: Text(
            'Service Type',
            style: GoogleFonts.ubuntu(),
          ),
          content: Container(
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: Colors.black),
                ),
              ),
              hint: Text('Select'),
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
          isActive: currentStep >= 6,
          title: Text(
            'Report Issues',
            style: GoogleFonts.ubuntu(),
          ),
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: task,
                maxLines: 3,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.black),
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    labelText: 'Task Completed',
                    hintText: 'Implementation Details'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: technical,
                maxLines: 3,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.black),
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    labelText: 'Technical Issues'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: remarks,
                maxLines: 3,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.black),
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    labelText: 'Remarks'),
              ),
            ],
          ),
        ),

        Step(
          isActive: currentStep >= 7,
          title: Text(
            'Verification',
            style: GoogleFonts.ubuntu(),
          ),
          content:  Container(
            width: 200,
            child: OutlinedButton.icon(
              // <-- OutlinedButton
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignaturePage()));
              },
              label: Align(alignment: Alignment.centerLeft, child: new Text('Provide Signature')),
              icon: Icon(
                Icons.verified,
                size: 24.0,
              ),
            ),
          ),
        ),

        Step(
          isActive: currentStep >= 8,
          title: Text(
            'Complete',
            style: GoogleFonts.ubuntu(),
          ),
          content: ElevatedButton(
            child: Text('Submit'),
            onPressed: () {
              final user = UserData(
                date: DateTime.parse(dateinput.text),
                //time: DateTime.parse(timeinput.text),
                name: clientName.text,
                address: clientAddress.text,
                //state: clientState.value,
                //postcode: int.parse(clientPostcode.text)
              );
              createUserData(user);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserForms()));
            }
          ),

),


      ];

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60.10, //set your height
        //flexibleSpace: SafeArea(
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserForms()));
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
      body:
      //Scrollbar(child:
      Theme(
        data: ThemeData(
            accentColor: Colors.indigo[900],
            primarySwatch: Colors.indigo,
            backgroundColor: Colors.white,
            colorScheme: ColorScheme.light(primary: Colors.indigo)),

          child: Scrollbar(
        thumbVisibility: true, //always show scrollbar
        thickness: 10, //width of scrollbar
        radius: Radius.circular(20), //corner radius of scrollbar
        scrollbarOrientation: ScrollbarOrientation.right,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5),
          Text("Signed in as: " + user.email!, textAlign: TextAlign.left),
              Expanded (
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
                        Navigator.of(context).pop(FormPage());
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
                              onPressed:

                              controls.onStepContinue,
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
            ],
          ),



          ),
        ),


    );

  Future createUserData(UserData user) async {
    final docUserData = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUserData.id;

    final json = user.toJson();
    await docUserData.set(json);

  }
}

class UserData {
  String id;
  final DateTime date;
  //final DateTime time;
  final String name;
  final String address;


  UserData({
    this.id = '',
    required this.date,
    //required this.time,
    required this.name,
    required this.address
  });

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'date': date,
        //'time': time,
        'name': name,
        'address': address,
      };

  static UserData fromJson(Map<String, dynamic>json) => UserData(
      id: json['id'],
      date: (json['date'] as Timestamp).toDate(),
      name: json['name'],
      address: json['address']
  );
}

