import 'package:url_launcher/url_launcher.dart';

// Creating the calls and messages services by this Class
class CallsAndMessagesService {
  void call(String number) => launch("tel://$number");
  void sendSms(String number) => launch("sms:$number");
  void sendEmail(String email) => launch("mailto:$email");
}
