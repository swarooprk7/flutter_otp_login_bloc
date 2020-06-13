abstract class OtpEvent {}

class OtpInitEvent extends OtpEvent {}

class OtpOnPhoneNoEvent extends OtpEvent {}

class OtpOnOtpEvent extends OtpEvent {
  String phoneNo;
  String otp;
  OtpOnOtpEvent({this.phoneNo, this.otp});
}

class OtpFormSubmitEvent extends OtpEvent {
  String name;

  OtpFormSubmitEvent({this.name});
}

//class OtpOnPhoneNoEvent extends OtpEvent {
//  String phoneNumber;
//  String otp;
//  OtpOnPhoneNoEvent({this.phoneNumber, this.otp});
//}

class OtpRetryEvent extends OtpEvent {}
