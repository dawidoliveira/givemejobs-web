import 'package:flutter/material.dart';
import 'package:give_me_jobs_web/app/core/app_images.dart';
import 'package:give_me_jobs_web/app/core/app_text_styles.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.logo,
          width: _size.width * .05,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "GiveMeJobs - Painel de Controle",
          style: AppTextStyles.title,
        ),
      ],
    );
  }
}
