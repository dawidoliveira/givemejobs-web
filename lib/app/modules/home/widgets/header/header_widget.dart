import 'package:flutter/material.dart';
import 'package:give_me_jobs_web/app/core/app_responsive.dart';
import 'package:give_me_jobs_web/app/core/app_text_styles.dart';
import 'package:give_me_jobs_web/app/modules/home/home_store.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.store,
    required this.scaffoldKey,
  }) : super(key: key);

  final HomeStore store;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: double.infinity,
      color: const Color(0xFF435877),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: !AppResponsive.isWeb(context),
            child: IconButton(
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: store.signOut,
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            label: Text(
              'logout',
              style: AppTextStyles.button.copyWith(color: Colors.white),
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
