import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final int? maxLength;
  final String? Function(String?)? validator;
  final bool read;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.validator,
    this.read=false
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall,
          ),
          TextFormField(
            readOnly: read,
            controller: controller,
            keyboardType: keyboardType,
            maxLength: maxLength,
            style: theme.textTheme.bodySmall,
            decoration: InputDecoration(
              hintText: hint,

              hintStyle: theme.textTheme.bodySmall,
              border: const UnderlineInputBorder(),
            ),
            validator: validator
          )
        ],
      ),
    );
  }
}
