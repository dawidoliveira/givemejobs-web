import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_web/app/modules/home/home_state.dart';
import 'package:give_me_jobs_web/app/modules/home/home_store.dart';
import 'package:give_me_jobs_web/app/modules/home/widgets/content/content_widget.dart';
import 'package:give_me_jobs_web/app/modules/home/widgets/custom_menu/custom_menu_widget.dart';
import 'package:give_me_jobs_web/app/modules/home/widgets/my_vacancies/my_vacancies_widget.dart';
import 'package:give_me_jobs_web/app/modules/home/widgets/register_vacancy/register_vacancy_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: store.state.scaffoldKey,
      body: TripleBuilder<HomeStore, Exception, HomeState>(
        store: store,
        builder: (context, triple) => Row(
          children: [
            CustomMenuWidget(
              store: store,
            ),
            Expanded(
              child: PageView(
                controller: store.state.pageController,
                children: [
                  ContentWidget(
                    store: store,
                    scaffoldKey: store.state.scaffoldKey,
                  ),
                  RegisterVacancyWidget(
                    store: store,
                    scaffoldKey: store.state.scaffoldKey,
                  ),
                  MyVacanciesWidget(
                    store: store,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
