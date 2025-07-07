import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Map<String, String>> notifications = [
      {
        'title': 'Fuel Added',
        'body': 'You added 20L of fuel to your default vehicle.',
        'time': 'Just now'
      },
      {
        'title': 'Trip Completed',
        'body': 'You completed a trip of 15 km.',
        'time': '10 min ago'
      },
      {
        'title': 'Maintenance Reminder',
        'body': 'Your vehicle is due for maintenance this week.',
        'time': '1 hour ago'
      },
      {
        'title': 'New Feature!',
        'body': 'Dark mode is now available in settings.',
        'time': '2 days ago'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: ListView.separated(
          itemCount: notifications.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            final item = notifications[index];
            return Container(
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.notifications, size: 28.sp, color: theme.primaryColor),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['title']!, style: theme.textTheme.bodyMedium),
                        SizedBox(height: 4.h),
                        Text(item['body']!, style: theme.textTheme.bodySmall),
                        SizedBox(height: 4.h),
                        Text(item['time']!, style: theme.textTheme.titleSmall),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
