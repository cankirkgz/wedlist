import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  // Font Sizes
  static double get fontXs => 10.sp;
  static double get fontSm => 12.sp;
  static double get fontMd => 14.sp;
  static double get fontLg => 16.sp;
  static double get fontXl => 20.sp;
  static double get fontXxl => 24.sp;
  static double get fontHuge => 32.sp;

  // Font Weights
  static const FontWeight weightLight = FontWeight.w300;
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemiBold = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;
  static const FontWeight weightExtraBold = FontWeight.w800;

  // Border Radius
  static double get radiusSm => 6.r;
  static double get radiusMd => 10.r;
  static double get radiusLg => 14.r;
  static double get radiusXl => 20.r;
  static double get radiusCircle => 999.r;

  // Border Widths
  static double get borderWidthMd => 1.w;
  static double get borderWidthLg => 2.w;
  static double get borderWidthXl => 3.w;

  // Padding
  static double get paddingXs => 4.w;
  static double get paddingSm => 8.w;
  static double get paddingMd => 16.w;
  static double get paddingLg => 20.w;
  static double get paddingXl => 24.w;
  static double get paddingXxl => 32.w;
  static double get paddingHuge => 64.w;

  // Symmetric Padding Helpers
  static EdgeInsets get horizontalPaddingSm =>
      EdgeInsets.symmetric(horizontal: paddingSm);
  static EdgeInsets get horizontalPaddingMd =>
      EdgeInsets.symmetric(horizontal: paddingMd);
  static EdgeInsets get horizontalPaddingLg =>
      EdgeInsets.symmetric(horizontal: paddingLg);

  static EdgeInsets get verticalPaddingSm =>
      EdgeInsets.symmetric(vertical: paddingSm);
  static EdgeInsets get verticalPaddingMd =>
      EdgeInsets.symmetric(vertical: paddingMd);
  static EdgeInsets get verticalPaddingLg =>
      EdgeInsets.symmetric(vertical: paddingLg);

  // All Padding Helpers
  static EdgeInsets get paddingAllSm => EdgeInsets.all(paddingSm);
  static EdgeInsets get paddingAllMd => EdgeInsets.all(paddingMd);
  static EdgeInsets get paddingAllLg => EdgeInsets.all(paddingLg);

  // SizedBoxes
  static SizedBox get gap4 => SizedBox(width: 4.w, height: 4.h);
  static SizedBox get gap8 => SizedBox(width: 8.w, height: 8.h);
  static SizedBox get gap12 => SizedBox(width: 12.w, height: 12.h);
  static SizedBox get gap16 => SizedBox(width: 16.w, height: 16.h);
  static SizedBox get gap24 => SizedBox(width: 24.w, height: 24.h);
  static SizedBox get gap32 => SizedBox(width: 32.w, height: 32.h);

  // Elevation
  static double get elevationLow => 2;
  static double get elevationMed => 4;
  static double get elevationHigh => 8;

  // Heights
  static double get heightXxs => 20.h;
  static double get heightXs => 32.h;
  static double get heightSm => 40.h;
  static double get heightMd => 48.h;
  static double get heightLg => 56.h;
  static double get heightXl => 64.h;
  static double get heightXxl => 80.h;
  static double get heightSemiHuge => 100.h;
  static double get heightHuge => 160.h;

  // Widths
  static double get widthXxs => 20.w;
  static double get widthXs => 32.w;
  static double get widthSm => 40.w;
  static double get widthMd => 48.w;
  static double get widthLg => 56.w;
  static double get widthXl => 64.w;
  static double get widthXxl => 80.w;

  // Image Sizes
  static double get imageSizeXs => 40.w;
  static double get imageSizeSm => 64.w;
  static double get imageSizeMd => 100.w;
  static double get imageSizeLg => 160.w;
  static double get imageSizeXl => 240.w;

  // Letter Spacing
  static double get letterSpacingXs => 2.w;
  static double get letterSpacingSm => 4.w;
  static double get letterSpacingMd => 6.w;
  static double get letterSpacingLg => 8.w;
  static double get letterSpacingXl => 10.w;

  // Icon Sizes
  static double get iconSizeSm => 16.w;
  static double get iconSizeMd => 24.w;
  static double get iconSizeLg => 32.w;
  static double get iconSizeXl => 48.w;
}
