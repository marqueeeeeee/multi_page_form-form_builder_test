import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:multi_page_form/multi_page_form.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Test(),
    );
  }
}

class Test extends StatefulWidget {
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _fbKey,
        initialValue: {
          'date': DateTime.now(),
          'accept_terms': false,
        },
        autovalidate: true,
        child: MultiPageForm(
          totalPage: 3,
          pageList: <Widget>[page1(), page2(), page3()],
          onFormSubmitted: () {
            if (_fbKey.currentState.saveAndValidate()) {
              print(_fbKey.currentState.value);
            }
          },
        ),
      ),
    );
  }

  Widget page1() {
    return Container(
      child: ListView(
        children: [
          FormBuilderDateTimePicker(
            attribute: "date",
            inputType: InputType.date,
            format: DateFormat("yyyy-MM-dd"),
            decoration:
                InputDecoration(labelText: "Appointment Time"),
          ),
        ],
      ),
    );
  }

  Widget page2() {
    return Container(
      child: ListView(
        children: [
          FormBuilderSlider(
            attribute: "slider",
            validators: [FormBuilderValidators.min(6)],
            min: 0.0,
            max: 10.0,
            initialValue: 1.0,
            divisions: 20,
            decoration:
                InputDecoration(labelText: "Number of things"),
          ),
        ],
      ),
    );
  }

  Widget page3() {
    return Container(
      child: ListView(
        children: [
          FormBuilderCheckbox(
            attribute: 'accept_terms',
            label: Text(
                "I have read and agree to the terms and conditions"),
            validators: [
              FormBuilderValidators.requiredTrue(
                errorText:
                    "You must accept terms and conditions to continue",
              ),
            ],
          ),   FormBuilderDropdown(
            attribute: "gender",
            decoration: InputDecoration(labelText: "Gender"),
            // initialValue: 'Male',
            hint: Text('Select Gender'),
            validators: [FormBuilderValidators.required()],
            items: ['Male', 'Female', 'Other']
              .map((gender) => DropdownMenuItem(
                 value: gender,
                 child: Text("$gender")
            )).toList(),
          ),
          FormBuilderTextField(
            attribute: "age",
            decoration: InputDecoration(labelText: "Age"),
            validators: [
              FormBuilderValidators.numeric(),
              FormBuilderValidators.max(70),
            ],
          ),
          FormBuilderSegmentedControl(
            decoration:
                InputDecoration(labelText: "Movie Rating (Archer)"),
            attribute: "movie_rating",
            options: List.generate(5, (i) => i + 1)
                .map(
                    (number) => FormBuilderFieldOption(value: number))
                .toList(),
          ),
          FormBuilderSwitch(
            label: Text('I Accept the tems and conditions'),
            attribute: "accept_terms_switch",
            initialValue: true,
          ),
          FormBuilderStepper(
            decoration: InputDecoration(labelText: "Stepper"),
            attribute: "stepper",
            initialValue: 10,
            step: 1,
          ),
          FormBuilderRate(
            decoration: InputDecoration(labelText: "Rate this form"),
            attribute: "rate",
            iconSize: 32.0,
            initialValue: 1,
            max: 5,
          ),
          FormBuilderCheckboxList(
            decoration:
            InputDecoration(labelText: "The language of my people"),
            attribute: "languages",
            initialValue: ["Dart"],
            options: [
              FormBuilderFieldOption(value: "Dart"),
              FormBuilderFieldOption(value: "Kotlin"),
              FormBuilderFieldOption(value: "Java"),
              FormBuilderFieldOption(value: "Swift"),
              FormBuilderFieldOption(value: "Objective-C"),
            ],
          ),
          FormBuilderSignaturePad(
            decoration: InputDecoration(labelText: "Signature"),
            attribute: "signature",
            height: 100,
          ),
        ],
      ),
    );
  }
}
