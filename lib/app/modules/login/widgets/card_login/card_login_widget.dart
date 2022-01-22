import 'package:flutter/material.dart';
import 'package:give_me_jobs_web/app/core/app_responsive.dart';
import 'package:give_me_jobs_web/app/modules/login/login_store.dart';
import 'package:give_me_jobs_web/app/modules/login/widgets/form_login/form_login_widget.dart';
import 'package:give_me_jobs_web/app/modules/login/widgets/header/header_widget.dart';

class CardLoginWidget extends StatelessWidget {
  const CardLoginWidget({
    Key? key,
    required Size size,
    required this.store,
  })  : _size = size,
        super(key: key);

  final Size _size;
  final LoginStore store;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: AppResponsive.isWeb(context) ? _size.width * .4 : _size.width,
        child: Card(
          elevation: 10,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: Column(
              children: [
                HeaderWidget(size: _size),
                const SizedBox(
                  height: 20,
                ),
                FormLoginWidget(
                  size: _size,
                  store: store,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
