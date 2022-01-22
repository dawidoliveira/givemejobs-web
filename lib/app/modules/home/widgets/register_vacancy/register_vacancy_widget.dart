import 'package:flutter/material.dart';
import 'package:give_me_jobs_web/app/core/app_text_styles.dart';
import 'package:give_me_jobs_web/app/modules/home/home_store.dart';
import 'package:give_me_jobs_web/app/modules/home/widgets/register_vacancy/widgets/input_vacancy/input_vacancy_widget.dart';
import 'package:give_me_jobs_web/app/modules/home/widgets/register_vacancy/widgets/select_input_course/select_input_course_widget.dart';
import 'package:give_me_jobs_web/app/shared/widgets/button/button_widget.dart';

class RegisterVacancyWidget extends StatelessWidget {
  const RegisterVacancyWidget(
      {Key? key, required this.store, required this.scaffoldKey})
      : super(key: key);

  final HomeStore store;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cadastrar vaga',
                style: AppTextStyles.title.copyWith(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: store.state.formKey,
                child: Column(
                  children: [
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InputVacancyWidget(
                                labelText: 'Título da vaga',
                                controller: store.state.titleController,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                validator: store.validator,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SelectInputCourseWidget(store: store),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InputVacancyWidget(
                                labelText: 'Quantidade de vagas',
                                validator: store.validator,
                                controller: store.state.qntVacancyController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        InputVacancyWidget(
                          labelText: 'Descrição da vaga',
                          validator: store.validator,
                          maxLines: 8,
                          controller: store.state.descController,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: store.setFile,
                      child: TextField(
                        enabled: false,
                        mouseCursor: SystemMouseCursors.click,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: store.state.labelFile,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ButtonWidget(
                        label: 'Cadastrar vaga',
                        onPressed: store.registerVacancy,
                        store: store,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
