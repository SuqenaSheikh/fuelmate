import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/view/global_widgets/arrow_back.dart';
import 'package:get/get.dart';

class Custom_AppBar extends StatelessWidget {
  final String title;
  final bool ishome;
  VoidCallback? onpressed;
  VoidCallback? onpressed1;
  IconData? ic;

  Custom_AppBar(
      {super.key,
      required this.title,
      this.ishome = false,
      this.onpressed,
      this.onpressed1,
      this.ic});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ishome
            ? IconButton(
                onPressed: onpressed,
                icon: Icon(Icons.menu, color: theme.iconTheme.color))
            : BackArrow(
                onPressed: () {
                  Get.back();
                },
              ),
        Text(
          title,
          style: theme.textTheme.bodyMedium,
        ),
        if (ishome && ic != null)
          IconButton(
            onPressed: onpressed1,
            icon: Icon(ic, color: theme.iconTheme.color),
          )
        else
          SizedBox(width: 20.w),

      ],
    );
  }
}
