import 'package:flutter/material.dart';
import 'package:give_me_jobs_web/app/core/app_colors.dart';
import 'package:give_me_jobs_web/app/core/app_images.dart';
import 'package:give_me_jobs_web/app/core/app_text_styles.dart';
import 'package:give_me_jobs_web/app/modules/home/home_store.dart';
import 'package:give_me_jobs_web/app/modules/home/widgets/custom_menu_item/custom_menu_item_widget.dart';

class CustomMenuWidget extends StatelessWidget {
  final HomeStore store;
  const CustomMenuWidget({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.drawer,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    height: 62,
                    color: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.logo,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'UFAL',
                          style:
                              AppTextStyles.title.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: AppColors.drawer,
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          store.user.name,
                          style: AppTextStyles.content
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: AppColors.sectionDrawer,
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Menu',
                      style: AppTextStyles.content.copyWith(color: Colors.grey),
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      CustomMenuItemWidget(
                        icon: Icons.dashboard,
                        label: 'Home',
                        onTap: () {
                          store.changePage = 0;
                        },
                      ),
                      CustomMenuItemWidget(
                        icon: Icons.dashboard,
                        label: 'Cadastrar vaga',
                        onTap: () {
                          store.changePage = 1;
                        },
                      ),
                      CustomMenuItemWidget(
                        icon: Icons.dashboard,
                        label: 'Minhas vagas',
                        onTap: () {
                          store.changePage = 2;
                        },
                      ),
                      CustomMenuItemWidget(
                        icon: Icons.dashboard,
                        label: 'Sobre',
                        onTap: () {
                          store.changePage = 3;
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
