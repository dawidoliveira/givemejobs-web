import 'package:flutter/material.dart';
import 'package:give_me_jobs_web/app/core/app_colors.dart';
import 'package:give_me_jobs_web/app/core/app_text_styles.dart';

class CustomMenuItemWidget extends StatefulWidget {
  const CustomMenuItemWidget({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final void Function()? onTap;

  @override
  _CustomMenuItemWidgetState createState() => _CustomMenuItemWidgetState();
}

class _CustomMenuItemWidgetState extends State<CustomMenuItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.drawer,
      child: ListTile(
        enableFeedback: true,
        onTap: widget.onTap,
        leading: Icon(
          widget.icon,
          color: Colors.white,
        ),
        title: Text(
          widget.label,
          style: AppTextStyles.tileTitle,
        ),
      ),
    );
  }
}
