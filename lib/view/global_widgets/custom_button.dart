import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Custom_Button extends StatelessWidget {
  final double font;
  final String title;
  final double wid;
  final Color BoxColor;
  final Color BorderColor;
  final Color TextColor;
  final VoidCallback? onPressed;

  const Custom_Button(
      {super.key,
        required this.font,
        required this.title,
        required this.wid,
        required this.BoxColor,
        required this.BorderColor,
        required this.TextColor,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        //  width: size.width * 0.8,
        width: wid,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: BoxColor,
          border: Border.all(color: BorderColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: font.sp,
              fontWeight: FontWeight.w500,
              color: TextColor,
            ),
          ),
        ),
      ),
    );
  }
}