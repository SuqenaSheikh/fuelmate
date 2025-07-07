import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../global_widgets/custom_appbar.dart';

class generalAboutScreen extends StatelessWidget {
  final String appBarText;
  final String heading;
  final String description;

  const generalAboutScreen(
      {super.key,
        required this.appBarText,
        required this.heading,
        required this.description});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Custom_AppBar(title: appBarText),
              SizedBox(
                height: 30.h,
              ),
              Text(
                  textAlign: TextAlign.start,
                  heading, style:theme.textTheme.bodyMedium ),

              const SizedBox(
                height: 20,
              ),
              Text(description, style:theme.textTheme.bodySmall )
            ],
          ),
        ),
      ),
    );
  }
}