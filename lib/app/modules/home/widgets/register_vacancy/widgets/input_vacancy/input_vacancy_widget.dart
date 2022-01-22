import 'package:flutter/material.dart';

class InputVacancyWidget extends StatelessWidget {
  const InputVacancyWidget({
    Key? key,
    required this.labelText,
    this.maxLines = 1,
    required this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) : super(key: key);

  final String labelText;
  final int? maxLines;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        validator: validator,
        controller: controller,
        textCapitalization: textCapitalization,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        maxLines: maxLines,
      ),
    );
  }
}
