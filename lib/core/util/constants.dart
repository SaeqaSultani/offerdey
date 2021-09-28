import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String DAWAI_HAZIR_API = 'https://dawai-hazir-webapp.herokuapp.com/api/';

const Color kLightPrimary = Color(0xFF0D60C6);
const Color kLightAccent = Color(0xFF438ae0);
const Color kLightTextColor = Color(0xFF192D4D);
const Color kLightPlaceholder = Color(0xFFE8EAF0);
const Color kLightPlaceholderText = Color(0xFF83b7f7);
const Color kLightBg = Color(0xFFFFFFFF);
const Color kLightError = Color(0xFFFF7971);

const Color kDarkPrimary = Color(0xFF4CC49B);
const Color kDarkAccent = Color(0xFF4CC49B);
const Color kDarkTextColor = Colors.white;
const Color kDarkPlaceholder = Color(0xFF2D3655);
const Color kDarkPlaceholderText = Color(0xFF525C7C);
const Color kDarkBg = Color(0xFF2D3251);
const Color kDarkError = Color(0xFFD0524A);

const Duration kAnimationDuration = Duration(milliseconds: 300);
const Curve kAnimationCurve = Curves.easeInOut;

EdgeInsets kPagePadding = EdgeInsets.symmetric(
  horizontal: 24.w,
);

EdgeInsets kCardPadding = EdgeInsets.symmetric(
  horizontal: 16.w,
  vertical: 16.h,
);

EdgeInsets kInputFieldPadding = EdgeInsets.symmetric(
  horizontal: 16.w,
  vertical: 16.h,
);

BorderRadiusGeometry kCardBorderRadius = BorderRadius.circular(
  16.r,
);

BorderRadius kAppIconBorderRadius = BorderRadius.circular(
  8.r,
);

BorderRadiusGeometry kBottomSheetBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(16.r),
  topRight: Radius.circular(16.r),
);
