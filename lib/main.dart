import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stepper',
      home: StepperSample(title: 'Stepper Home Page'),
    );
  }
}

class StepperSample extends StatefulWidget {
  StepperSample({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StepperSample> {
  List<Step> steps = [
    customStep("Paso1", "Paso 1"),
    customStep("Paso2", "Paso 2"),
    customStep("Paso3", "Paso 3"),
  ];

  static Step customStep(String title, String contentText) {
    return Step(
      title: Text(title),
      content: CustomContentStep(contentText),
    );
  }

  void onStepContinue() {
    setState(() {
      _currentStep++;

      if (_currentStep == steps.length) _currentStep = 0;
    });
  }

  void onStepTapped(int value) {
    setState(() {
      _currentStep = value;
    });
  }

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Stepper(
          steps: steps,
          currentStep: _currentStep,
          onStepContinue: onStepContinue,
          onStepTapped: onStepTapped,
          controlsBuilder: (BuildContext context,
              {onStepContinue, onStepCancel}) {
            return Row(
              children: <Widget>[
                FlatButton(
                  onPressed: onStepContinue,
                  child: Text("Continue"),
                  color: Colors.amber,
                  textColor: Colors.white,
                ),
                FlatButton(onPressed: onStepCancel, child: Text("Cancel"))
              ],
            );
          },
        ),
      ),
    );
  }
}

class CustomContentStep extends StatelessWidget {
  String text;

  CustomContentStep(
    String text, {
    Key key,
  }) : super(key: key) {
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }
}
