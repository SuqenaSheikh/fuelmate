import 'package:flutter/material.dart';
import 'package:fuelmate/model/trip_model.dart';
import 'package:fuelmate/view/tripsummary_screen/trip_summary.dart';
import 'package:get/get.dart';

class TripSummaryCard extends StatelessWidget {
  final NewTripModel trip;

  const TripSummaryCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: (){
        Get.to(()=>TripSummaryScreen(trip: trip,));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Left side (icon + text info)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.location_on_sharp,
                    color: theme.colorScheme.primary, size: 27),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     "${(trip.tripName).toString().capitalizeFirst}",
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${trip.distance.toStringAsFixed(1)} km | ${trip.mileage.toStringAsFixed(1)} km/l',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),

            /// Right side (date)
            Text(
              trip.date,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
