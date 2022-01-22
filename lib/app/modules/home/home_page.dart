import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_web/app/core/app_responsive.dart';
import 'package:give_me_jobs_web/app/modules/home/home_state.dart';
import 'package:give_me_jobs_web/app/modules/home/widgets/content/content_widget.dart';
import 'package:give_me_jobs_web/app/modules/home/widgets/custom_menu/custom_menu_widget.dart';
import 'package:give_me_jobs_web/app/modules/home/widgets/my_vacancies/my_vacancies_widget.dart';
import 'package:give_me_jobs_web/app/modules/home/widgets/register_vacancy/register_vacancy_widget.dart';
import 'home_store.dart';
import 'widgets/header/header_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: store.state.scaffoldKey,
      extendBodyBehindAppBar: true,
      drawer: LayoutBuilder(
        builder: (context, constraints) {
          return Visibility(
            visible: !AppResponsive.isWeb(context),
            child: CustomMenuWidget(
              store: store,
            ),
          );
        },
      ),
      body: TripleBuilder<HomeStore, Exception, HomeState>(
        store: store,
        builder: (context, triple) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return Visibility(
                  visible: AppResponsive.isWeb(context),
                  child: CustomMenuWidget(
                    store: store,
                  ),
                );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HeaderWidget(
                      store: store,
                      scaffoldKey: store.state.scaffoldKey,
                    ),
                    if (triple.state.selectPage == 0)
                      ContentWidget(
                        store: store,
                        scaffoldKey: store.state.scaffoldKey,
                      ),
                    if (triple.state.selectPage == 1)
                      RegisterVacancyWidget(
                        store: store,
                        scaffoldKey: store.state.scaffoldKey,
                      ),
                    if (triple.state.selectPage == 2)
                      MyVacanciesWidget(
                        store: store,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
