import 'package:flutter/material.dart';
import 'package:give_me_jobs_web/app/core/app_text_styles.dart';

class InputFieldWidget extends StatefulWidget {
  final String hintText;
  final TextInputType textInputType;
  final bool isPass;
  final TextEditingController textController;

  const InputFieldWidget({
    Key? key,
    required this.hintText,
    required this.textInputType,
    this.isPass = false,
    required this.textController,
  }) : super(key: key);

  const InputFieldWidget.pass({
    required this.hintText,
    this.textInputType = TextInputType.visiblePassword,
    this.isPass = true,
    required this.textController,
  });

  @override
  _InputFieldWidgetState createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      keyboardType: widget.textInputType,
      obscureText: widget.isPass && _obscureText,
      style: AppTextStyles.input,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        suffixIcon: widget.isPass
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: const Icon(
                  Icons.visibility_off,
                ),
              )
            : null,
      ),
    );
  }
}
