import 'package:flutter/material.dart';

class BackArrow extends StatelessWidget {
  final VoidCallback? onPressed;
  const BackArrow({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap:  onPressed,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.cardColor
        ),
        child: const Icon(
            Icons.arrow_back_sharp
        ),
      ),
    );
  }
}
