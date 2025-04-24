import 'package:flutter/material.dart';

import 'font_weight.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color ) {
  return TextStyle(
    fontSize: fontSize,
    color: color ,
    fontWeight: fontWeight,
  );
}

// regular style

TextStyle getRegularStyle({double? fontSize, required Color color}) {
  return _getTextStyle(
    fontSize ?? FontSize.s14,
    FontWeighManager.regular,
    color,
  );
}

// medium style

TextStyle getMediumStyle({double? fontSize, required Color color}) {
  return _getTextStyle(
    fontSize ?? FontSize.s16,
    FontWeighManager.medium,
    color ,
  );
}

// light style

TextStyle getLightStyle({double? fontSize, required Color color}) {
  return _getTextStyle(
    fontSize ?? FontSize.s18,
    FontWeighManager.semiBold,
    color,
  );
}

// bold style

TextStyle getBoldStyle({double? fontSize, required Color color}) {
  return _getTextStyle(
    fontSize ?? FontSize.s20,
    FontWeighManager.bold,
    color,
  );
}

// semibold style

TextStyle getSemiBoldStyle({double? fontSize, required Color color}) {
  return _getTextStyle(
    fontSize ?? FontSize.s19,
    FontWeighManager.semiBold,
    color,
  );
}