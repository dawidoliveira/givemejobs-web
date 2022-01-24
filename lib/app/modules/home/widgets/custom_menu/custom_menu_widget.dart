import 'package:flutter/material.dart';
import 'package:give_me_jobs_web/app/core/app_images.dart';
import 'package:give_me_jobs_web/app/core/app_responsive.dart';
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
        height: AppResponsive.isWeb(context) ? 150 : 200,
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Image.asset(
          AppImages.logo,
        ),
      ),
      destinations: const <NavigationRailDestination>[
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
