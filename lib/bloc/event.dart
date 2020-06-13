abstract class OtpState {}

class OtpInitState extends OtpState {}

class OtpOtpState extends OtpState {}

class OtpFormState extends OtpState {}

class OtpFormSubmitState extends OtpState {}

class OtpLoadState extends OtpState {}

class OtpErrorState extends OtpState {
  String errMsg;

  OtpErrorState({this.errMsg});
}

class OtpSuccessState extends OtpState {
  String successMsg;

  OtpSuccessState({this.successMsg});
}
