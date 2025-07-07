import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/constants/assets.dart';
import 'package:fuelmate/view/navigation_bars/bottom_bar.dart';
import 'package:get/get.dart';

import '../global_widgets/custom_button.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    Size size= MediaQuery.of(context).size;
    return PopScope(
     canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                      Assets.onboard,
                    )),
          Text(
            "Track Your Fuel Usage!",
            style: theme.textTheme.bodyLarge,
          ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Easy maintain your fuel consumption and expenses with Us",
                  style: theme.textTheme.bodySmall,
                ),
                SizedBox(
                  height: 50.h,
                ),
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Custom_Button(
                        font: 16,
                        title: "Get Started",
                        wid: size.width/1.2,
                        BoxColor: colorScheme.primary,
                        BorderColor: Colors.transparent,
                        TextColor: theme.cardColor,
                        onPressed: (){
                          Get.off(()=> const BottomBar(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 300),
                          );
      
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}