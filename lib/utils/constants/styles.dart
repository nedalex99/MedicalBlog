import 'package:flutter/cupertino.dart';
import 'package:medical_blog/utils/constants/colors.dart';

import 'colors.dart';

const kTutorialTitleTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.normal,
);
const kTutorialDescriptionTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
);
const kNoFocusNoErrorHintTextStyle = TextStyle(
  fontSize: 14.0,
  fontStyle: FontStyle.normal,
  color: kHintColor,
);
const kFocusedNoErrorHintTextStyle = TextStyle(
  fontStyle: FontStyle.normal,
  fontSize: 14.0,
  color: kBlueSideColor,
);
const kFocusedWithErrorTextStyle = TextStyle(
  fontStyle: FontStyle.normal,
  fontSize: 14.0,
  color: kRedErrorColor,
);
const kNoFocusWithErrorTextStyle = TextStyle(
  fontStyle: FontStyle.normal,
  fontSize: 14.0,
  color: kRedErrorColor,
);
const kErrorHintTextStyle = TextStyle(
  fontStyle: FontStyle.normal,
  fontSize: 14.0,
  color: kRedErrorColor,
);
const kLoadingTextStyle = TextStyle(
  fontStyle: FontStyle.normal,
  fontSize: 13,
  color: kTextBlack1C,
);
const kDialogErrorStyle = TextStyle(
  color: Color(0xFF1c1c1c),
  fontSize: 14.0,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.3,
  height: 1.3,
);
