import 'package:flutter/material.dart';
import 'package:give_me_jobs_web/app/core/app_text_styles.dart';
import 'package:give_me_jobs_web/app/modules/home/home_store.dart';
import 'package:give_me_jobs_web/app/shared/models/vacancy_model.dart';

class ContentVacancyTileWidget extends StatelessWidget {
  const ContentVacancyTileWidget({
    Key? key,
    required this.store,
    required this.vacancy,
    required this.index,
  }) : super(key: key);

  final HomeStore store;
  final VacancyModel vacancy;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            Tooltip(
              message: 'Ver os candidatos',
              child: IconButton(
                onPressed: () {
                  store.showCandidates(index: index);
                },
                icon: Icon(
                  Icons.visibility,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Tooltip(
              message: 'Clique aqui para deletar esta vaga',
              child: IconButton(
                onPressed: () async {
                  await store.removeVacancy(
                    courseId: vacancy.course.id,
                    vacancyId: vacancy.id!,
                  );
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ),
          ],
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Descrição da vaga:',
            style: AppTextStyles.tileTitle.copyWith(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            vacancy.desc,
            style: AppTextStyles.content.copyWith(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Quantidade de vagas: ${vacancy.qntVacancy}',
            style: AppTextStyles.tileTitle.copyWith(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (vacancy.urlFile != null && vacancy.urlFile!.isNotEmpty)
            Text(
              'Mais informações:',
              style: AppTextStyles.tileTitle.copyWith(
                color: Colors.black,
              ),
            ),
          if (vacancy.urlFile != null && vacancy.urlFile!.isNotEmpty)
            const SizedBox(
              height: 10,
            ),
          if (vacancy.urlFile != null && vacancy.urlFile!.isNotEmpty)
            TextButton.icon(
              onPressed: () {
                store.downloadEdital(vacancy.urlFile!);
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Baixe o edital clicando aqui'),
            )
        ],
      ),
    );
  }
}
