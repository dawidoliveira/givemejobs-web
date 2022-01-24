import 'package:flutter/material.dart';
import 'package:give_me_jobs_web/app/core/app_images.dart';
import 'package:give_me_jobs_web/app/core/app_responsive.dart';
import 'package:give_me_jobs_web/app/core/app_text_styles.dart';
import 'package:give_me_jobs_web/app/modules/home/home_store.dart';

class CustomMenuWidget extends StatelessWidget {
  final HomeStore store;
  const CustomMenuWidget({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      elevation: 1,
      onDestinationSelected: store.changePage,
      labelType: AppResponsive.isWeb(context)
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.selected,
      extended: AppResponsive.isWeb(context),
      leading: Container(
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
              style: AppTextStyles.title.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.dashboard),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.edit),
          label: Text('Cadastrar vaga'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.wallet_travel_rounded),
          label: Text('Minhas vagas'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.dashboard),
          label: Text('Sobre'),
        ),
      ],
      selectedIndex: store.state.selectPage,
    );
  }
}
