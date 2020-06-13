import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otplogin/bloc/bloc.dart';
import 'package:otplogin/bloc/event.dart';
import 'package:otplogin/bloc/state.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

void main() {
  runApp(
    MaterialApp(home: OtpLogin(), debugShowCheckedModeBanner: false),
  );
}

class OtpLogin extends StatefulWidget {
  @override
  _OtpLoginState createState() => _OtpLoginState();
}

class _OtpLoginState extends State<OtpLogin> {
  TextEditingController phoneNumberController = TextEditingController(),
      otpController = TextEditingController();
  OtpLoginBloc bloc = OtpLoginBloc();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name, age, gender;
  String otpString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification App'),
        backgroundColor: Colors.redAccent,
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, state) {
          print(state);
          if (state is OtpInitState) {
            return getInitUi();
          } else if (state is OtpOtpState) {
            return getOtpUI();
          } else if (state is OtpFormState) {
            return getformUi();
          } else if (state is OtpSuccessState) {
            return getSuccessUi(state.successMsg);
          } else if (state is OtpErrorState) {
            return getErrorUi(state.errMsg);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget getInitUi() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.number,
            maxLength: 10,
            controller: phoneNumberController,
            decoration: InputDecoration(hintText: 'Enter Phone Number'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              backgroundColor: Colors.white24,
              fontStyle: FontStyle.normal,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () {
              bloc.add(OtpOnPhoneNoEvent());
              print(phoneNumberController.text);
              print(otpController.text);
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(15.0),
              child: const Text('Get OTP', style: TextStyle(fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }

  Widget getOtpUI() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Text(
                'Enter OTP',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              PinEntryTextField(
                showFieldAsBox: true,
                fieldWidth: 55.0,
                fontSize: 28.0,
                onSubmit: (String pin) {
                  otpString = pin;
                  print(pin);
                  print(phoneNumberController.text);
                  //end showDialog()
                  bloc.add(OtpOnOtpEvent(
                    phoneNo: phoneNumberController.text,
                    otp: otpString,
                  ));
                }, // end onSubmit
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Didn't got OTP",
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.lightBlue,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  RaisedButton(
                    color: Colors.white,
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.lightBlue,
                      ),
                    ),
                    onPressed: () {
                      bloc.add(OtpOnPhoneNoEvent());
                    },
                  )
                ],
              ),
              SizedBox(
                height: 150.0,
              ),
              Text(
                'Your Phone Number is ${phoneNumberController.text}',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                color: Colors.white,
                child: Text(
                  'Change Phone Number',
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                ),
                onPressed: () {
                  bloc.add(OtpInitEvent());
                },
              ),
            ],
          ),
        ), // end PinEntryTextField()
      ), // end Padding()
    );
  }

  Widget getErrorUi(String errMsg) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 200.0,
          ),
          Text(
            errMsg,
            style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.redAccent,
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          RaisedButton(
            child: Text(
              'Retry',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {
              bloc.add(OtpOnPhoneNoEvent());
              print('Retry clicked');
            },
          )
        ],
      ),
    );
  }

  Widget getformUi() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                maxLength: 15,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gender'),
                maxLength: 15,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  gender = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                maxLength: 2,
                keyboardType: TextInputType.number,
                validator: (String value) {
                  int age = int.tryParse(value);
                  if (age == null || age <= 0) {
                    return 'Correct Age is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  age = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                focusColor: Colors.lightBlue,
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                onPressed: () {
                  if (!formKey.currentState.validate()) {
                    return;
                  }
                  formKey.currentState.save();
                  print(name);
                  print(age);
                  bloc.add(OtpFormSubmitEvent(name: name));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSuccessUi(String successMsg) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              successMsg,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                fontStyle: FontStyle.normal,
                fontSize: 25.0,
                color: Colors.teal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
