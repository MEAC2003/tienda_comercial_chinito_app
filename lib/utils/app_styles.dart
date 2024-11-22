import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static TextStyle h1({Color? color, FontWeight? fontWeight}) =>
      TextStyle(fontSize: 32.sp, color: color, fontWeight: fontWeight);

  static TextStyle h2({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 24.sp,
        color: color ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.w400,
      );

  static TextStyle h3p5({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 18.sp,
        color: color,
        fontWeight: fontWeight ?? FontWeight.w400,
      );

  static TextStyle h3({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 16.sp,
        color: color,
        fontWeight: fontWeight ?? FontWeight.w400,
      );

  static TextStyle h4({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 14.sp,
        color: color,
        fontWeight: fontWeight ?? FontWeight.w400,
      );

  static TextStyle h5({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 12.sp,
        color: color,
        fontWeight: fontWeight ?? FontWeight.w400,
      );
}
