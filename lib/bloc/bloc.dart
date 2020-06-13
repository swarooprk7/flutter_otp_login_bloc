import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otplogin/bloc/event.dart';
import 'package:otplogin/bloc/state.dart';

class OtpLoginBloc extends Bloc<OtpEvent, OtpState> {
  @override
  OtpState get initialState => OtpInitState();

  @override
  Stream<OtpState> mapEventToState(OtpEvent event) async* {
    print(event);
    if (event is OtpOnPhoneNoEvent) {
      yield OtpOtpState();
    } else if (event is OtpOnOtpEvent) {
      if (event.otp == '1234') {
        yield OtpFormState();
      } else {
        yield OtpErrorState(errMsg: 'OTP Mismatch');
      }
    } else if (event is OtpInitEvent) {
      yield OtpInitState();
    } else if (event is OtpFormSubmitEvent) {
      yield OtpSuccessState(successMsg: 'Welcome Mr.${event.name}');
    }
  }
}
