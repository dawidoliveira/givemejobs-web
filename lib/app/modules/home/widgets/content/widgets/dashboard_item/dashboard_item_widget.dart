import 'package:flutter/material.dart';
import 'package:give_me_jobs_web/app/core/app_colors.dart';
import 'package:give_me_jobs_web/app/core/app_responsive.dart';
import 'package:give_me_jobs_web/app/core/app_text_styles.dart';

class DashboardItemWidget extends StatelessWidget {
  const DashboardItemWidget({
    Key? key,
    this.onPressed,
    required this.labelButton,
    required this.labelCount,
    required this.labelDescription,
    required this.icon,
  }) : super(key: key);

  final void Function()? onPressed;
  final String labelButton;
  final String labelCount;
  final String labelDescription;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppResponsive.isWeb(context)
          ? MediaQuery.of(context).size.width * .2
          : MediaQuery.of(context).size.width,
      height: 160,
      child: Card(
        elevation: 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: GridTile(
            footer: TextButton.icon(
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xFF037292),
                ),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
              icon: const Icon(
                Icons.more,
                color: Colors.white,
              ),
              label: Text(
                labelButton,
                style: AppTextStyles.button.copyWith(color: Colors.white),
              ),
            ),
            child: Container(
              color: AppColors.card1,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            labelCount,
                            style: AppTextStyles.content.copyWith(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            labelDescription,
                            style: AppTextStyles.content.copyWith(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.work_outline_rounded,
                        color: Colors.grey.withOpacity(.6),
                        size: 80,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
