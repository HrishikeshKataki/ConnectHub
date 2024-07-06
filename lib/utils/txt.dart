import 'package:flutter/material.dart';
import 'package:connecthub/utils/my_colors.dart';
import 'clr.dart';

class txt {
  static const _textScaleFactor = 1.1;

  static const textSizeLarge = 24.0 * _textScaleFactor;
  static const textSizeMedium = 20.0 * _textScaleFactor;
  static const textSizeDefault = 16.0 * _textScaleFactor;
  static const textSizeSmall = 12.0 * _textScaleFactor;

  static const String _fontBody = 'Yeseva';
  static const String _fontTitle = 'JosefinSans';

  static const appBarTitle = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.normal,
    fontSize: textSizeLarge,
    color: white,
  );

  static const dialogOptions = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.bold,
    fontSize: textSizeDefault,
    color: primary,
  );

  static const smallTextButton = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: textSizeDefault,
    color: primary,
  );

  static const mediumTextButton = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: textSizeMedium,
    color: primary,
  );

  static const button = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.normal,
    fontSize: textSizeMedium,
    color: clr.light,
  );

  static final error = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: textSizeSmall,
    color: clr.error,
  );

  // TEXT ON DARK

  static const titleLight = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: textSizeLarge,
    color: clr.light,
  );

  static const subTitleLight = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: textSizeMedium,
    color: clr.light,
  );

  static const body1Light = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: textSizeSmall,
    color: clr.light,
  );

  static const body2Light = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: textSizeDefault,
    color: clr.light,
  );

  static const labelLight = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: textSizeDefault,
    color: clr.light,
  );

  static const floatingLabelLight = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: textSizeDefault * 1.25,
    color: primary,
  );

  static const fieldLight = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: textSizeDefault,
    color: clr.light,
  );

  //
  // TEXT ON LIGHT
  //

  static const titleDark = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: textSizeLarge,
    color: secondaryText,
  );

  static const subTitleDark = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: textSizeMedium,
    color: secondaryText,
  );

  static const body1Dark = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: textSizeSmall,
    color: secondaryText,
  );

  static const body2Dark = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: textSizeDefault,
    color: secondaryText,
  );

  static const labelDark = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: textSizeDefault,
    color: secondaryText,
  );

  static const floatingLabelDark = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: textSizeDefault * 1.25,
    color: primary,
  );

  static const fieldDark = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: textSizeDefault,
    color: secondaryText,
  );
}
