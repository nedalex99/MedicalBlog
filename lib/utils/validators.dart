import 'package:medical_blog/utils/constants/strings.dart';

String hasMoreThenThreeCharacters(String value) {
  if (value.length >= 3) {
    return null;
  } else {
    return "The value has to have more characters.";
  }
}

String isValidEmail(String text, String label) {
  if (text.length < 3) return kInvalidEmail;
  if (text.length > 50) return kTooLong;
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(text)) ? kInvalidEmail : null;
}

String isValidName(String text, String label) {
  if (text.startsWith(' ')) {
    return kFirstCharWhiteSpace;
  }
  if (text.length < 3) return (label + " " + kTooShortName);
  if (text.length > 30) return kTooLong;
  RegExp regex = RegExp(r'[^a-zA-Z\s]');
  return !regex.hasMatch(text) ? null : (label + "  " + kInvalidString);
}

String isValidPassword(String text, String label) {
  if (text.length < 8) return kPasswordMinOneDigit;
  if (text.length > 30) return kTooLong;
  return text.contains(RegExp(r'[0-9]')) ? null : kPasswordMinOneDigit;
}