import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Options extends StatelessWidget {
  final String Img;
  final String Tag;
  final VoidCallback onpress;
  const Options({super.key, required this.Img, required this.Tag, required this.onpress});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return GestureDetector(
      onTap: onpress,
      child: Container(

        padding: const EdgeInsets.only(top: 20,bottom: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.primaryColor
        ),
        child: Column(
          children: [
            Image.asset(Img,height: 40),
            const SizedBox(height: 15,),
            Text(
              textAlign: TextAlign.center,
              Tag,
              style: GoogleFonts.poppins(color:Colors.white, fontSize: 12.sp),
            ),
          ],
        ),

      ),
    );
  }
}
