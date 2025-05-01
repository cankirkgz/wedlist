import 'package:flutter/material.dart';

class AppSizes {
  // Font Sizes
  static const double fontXs = 10.0;
  static const double fontSm = 12.0;
  static const double fontMd = 14.0;
  static const double fontLg = 16.0;
  static const double fontXl = 20.0;
  static const double fontXxl = 24.0;
  static const double fontHuge = 32.0;

  // Font Weights
  static const FontWeight weightLight = FontWeight.w300;
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemiBold = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;
  static const FontWeight weightExtraBold = FontWeight.w800;

  // Border Radius
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusCircle = 999.0;

  // Border with
  static const double borderWidthMd = 1.0;
  static const double borderWidthLg = 2.0;

  // Padding
  static const double paddingXs = 4.0;
  static const double paddingSm = 8.0;
  static const double paddingMd = 16.0;
  static const double paddingLg = 20.0;
  static const double paddingXl = 24.0;
  static const double paddingXxl = 32.0;

  // Symmetric Padding Helpers
  static const EdgeInsets horizontalPaddingSm =
      EdgeInsets.symmetric(horizontal: paddingSm);
  static const EdgeInsets horizontalPaddingMd =
      EdgeInsets.symmetric(horizontal: paddingMd);
  static const EdgeInsets horizontalPaddingLg =
      EdgeInsets.symmetric(horizontal: paddingLg);

  static const EdgeInsets verticalPaddingSm =
      EdgeInsets.symmetric(vertical: paddingSm);
  static const EdgeInsets verticalPaddingMd =
      EdgeInsets.symmetric(vertical: paddingMd);
  static const EdgeInsets verticalPaddingLg =
      EdgeInsets.symmetric(vertical: paddingLg);

  // All Padding Helpers
  static const EdgeInsets paddingAllSm = EdgeInsets.all(paddingSm);
  static const EdgeInsets paddingAllMd = EdgeInsets.all(paddingMd);
  static const EdgeInsets paddingAllLg = EdgeInsets.all(paddingLg);

  // SizedBoxes
  static const SizedBox gap4 = SizedBox(height: 4.0, width: 4.0);
  static const SizedBox gap8 = SizedBox(height: 8.0, width: 8.0);
  static const SizedBox gap12 = SizedBox(height: 12.0, width: 12.0);
  static const SizedBox gap16 = SizedBox(height: 16.0, width: 16.0);
  static const SizedBox gap24 = SizedBox(height: 24.0, width: 24.0);
  static const SizedBox gap32 = SizedBox(height: 32.0, width: 32.0);

  // Elevation (Shadow Depth)
  static const double elevationLow = 2.0;
  static const double elevationMed = 4.0;
  static const double elevationHigh = 8.0;

  // Heights
  static const double heightXs = 32.0;
  static const double heightSm = 40.0;
  static const double heightMd = 48.0;
  static const double heightLg = 56.0;
  static const double heightXl = 64.0;
  static const double heightXxl = 80.0;

  // Widths
  static const double widthXs = 32.0;
  static const double widthSm = 40.0;
  static const double widthMd = 48.0;
  static const double widthLg = 56.0;
  static const double widthXl = 64.0;
  static const double widthXxl = 80.0;
}
