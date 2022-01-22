import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_web/app/core/app_text_styles.dart';
import 'package:give_me_jobs_web/app/modules/home/home_store.dart';
import 'package:give_me_jobs_web/app/modules/home/widgets/my_vacancies/widgets/content_vacancy_tile/content_vacancy_tile_widget.dart';

class MyVacanciesWidget extends StatelessWidget {
  const MyVacanciesWidget({
    Key? key,
    required this.store,
  }) : super(key: key);

  final HomeStore store;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Minhas vagas',
            style: AppTextStyles.title.copyWith(fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          ScopedBuilder(
            store: store,
            onLoading: (context) => SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            onState: (context, state) => ListView.separated(
              shrinkWrap: true,
              itemCount: store.state.vacancies.length,
              separatorBuilder: (context, index) => const Divider(
                height: 0,
              ),
              itemBuilder: (context, index) {
                final vacancy = store.state.vacancies[index];
                return ExpansionTile(
                  title: Text(
                    vacancy.title,
                    style: AppTextStyles.tileTitle.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text('Curso: ${vacancy.course.name}'),
                  children: [
                    ContentVacancyTileWidget(
                      store: store,
                      vacancy: vacancy,
                      index: index,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
