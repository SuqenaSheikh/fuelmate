import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/constants/assets.dart';
import 'package:fuelmate/constants/theme.dart';
import 'package:fuelmate/view/home_screen/widgets/arrow_button.dart';


class VBanner extends StatelessWidget {
  const VBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient =
        isDark ? AppThemes.darkCardGradient : AppThemes.lightCard;
    final theme = Theme.of(context);


    return Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 190.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.vehiclebanner), fit: BoxFit.cover),
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              "Don't risk your Trips let us keep track of your fuel for journey",
              style: theme.textTheme.bodySmall,
            ),
            SizedBox(height: 10.h,),
            const ArrowButton(),
            SizedBox(height: 10.h,),
          ],
        ));
  }
}
