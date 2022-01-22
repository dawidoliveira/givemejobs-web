import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_web/app/core/app_text_styles.dart';

class ButtonWidget extends StatefulWidget {
  final void Function()? onPressed;
  final String label;
  final Store? store;
  const ButtonWidget({
    Key? key,
    this.onPressed,
    required this.label,
    this.store,
  }) : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
      ),
      child: widget.store != null
          ? TripleBuilder(
              store: widget.store!,
              builder: (context, triple) {
                if (triple.isLoading) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    width: 30,
                    height: 30,
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  );
                }
                return Text(
                  widget.label,
                  style: AppTextStyles.button,
                );
              },
            )
          : Text(
              widget.label,
              style: AppTextStyles.button,
            ),
    );
  }
}
