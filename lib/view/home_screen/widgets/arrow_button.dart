import 'package:flutter/material.dart';
import 'package:fuelmate/view/addtrip_screen/addtrip_screen.dart';
import 'package:get/get.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: (){
       Get.to(()=>const AddTripScreen());

      },
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: theme.cardColor,
        ),

        child:const Icon(Icons.arrow_forward_sharp, size: 20,)
      ),
    );
  }
}
