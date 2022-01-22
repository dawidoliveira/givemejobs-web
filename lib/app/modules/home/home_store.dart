import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_web/app/modules/home/home_state.dart';
import 'package:give_me_jobs_web/app/repositories/course_repository/course_repository.dart';
import 'package:give_me_jobs_web/app/repositories/user_repository/user_repository.dart';
import 'package:give_me_jobs_web/app/repositories/vacancies_repository/vacancies_repository.dart';
import 'package:give_me_jobs_web/app/services/auth_service/auth_service.dart';
import 'package:give_me_jobs_web/app/shared/models/course_model.dart';
import 'package:give_me_jobs_web/app/shared/models/user_model.dart';
import 'package:give_me_jobs_web/app/shared/models/vacancy_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeStore extends NotifierStore<Exception, HomeState> {
  final AuthService _authService;
  final UserRepository _userRepository;
  final CourseRepository _courseRepository;
  final VacancyRepository _vacancyRepository;

  HomeStore(this._authService, this._userRepository, this._courseRepository,
      this._vacancyRepository)
      : super(HomeState.initialState()) {
    init();
  }

  Future<void> init() async {
    setLoading(true);
    final newState = state.copyWith(
      courses: await _courseRepository.getAllCourses(),
      totalVacancies: await totalVacancies,
      vacancies: await _vacancyRepository.getVacancies(userId: user.id),
    );

    update(newState);
    setLoading(false);
  }

  void downloadEdital(String url) {
    final anchorElement = html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }

  Future<void> removeVacancy(
      {required String courseId, required String vacancyId}) async {
    final response = await showDialog<bool>(
      context: state.scaffoldKey.currentContext!,
      builder: (context) => AlertDialog(
        title: const Icon(
          Icons.dangerous,
          color: Colors.red,
          size: 50,
        ),
        content: const Text('Tem certeza que deseja apagar esta vaga?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Sim'),
          ),
        ],
      ),
    );
    if (response != null && response) {
      await _vacancyRepository.removeVacancy(
        userId: user.id,
        courseId: courseId,
        vacancyId: vacancyId,
      );

      final newState = state.copyWith(
        totalVacancies: state.totalVacancies - 1,
      );
      newState.vacancies.removeWhere((element) => element.id == vacancyId);
      update(newState);
    }
  }

  Future<void> showCandidates({required int index}) async {
    final candidates = state.vacancies[index].candidates ?? [];
    await showDialog(
      context: state.scaffoldKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Candidatos'),
          content: SizedBox(
            width: 350,
            height: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Aqui encontram-se os candidatos a esta vaga.\nToda comunicação será via email!',
                ),
                Visibility(
                  visible: candidates.isEmpty,
                  child: const Expanded(
                    child: Center(
                      child: Text('Não há candidatos para esta vaga!'),
                    ),
                  ),
                ),
                ListView.separated(
                  itemCount: candidates.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(
                    height: 0,
                  ),
                  itemBuilder: (_, i) {
                    final candidate = candidates[i];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        foregroundImage: NetworkImage(candidate.imgUrl!),
                      ),
                      title: SelectableText(candidate.name),
                      isThreeLine: candidate.curriculum != null &&
                          candidate.curriculum!.isNotEmpty &&
                          true,
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(candidate.email),
                          Visibility(
                            visible: candidate.curriculum != null &&
                                candidate.curriculum!.isNotEmpty,
                            child: TextButton.icon(
                              onPressed: () async => await canLaunch(
                                      candidate.curriculum!)
                                  ? await launch(candidate.curriculum!)
                                  : throw 'Could not launch ${candidate.curriculum!}',
                              icon: const Icon(
                                Icons.picture_as_pdf,
                                color: Colors.red,
                              ),
                              label: const Text('Baixar currículo'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo inválido';
    }
  }

  Future<void> signOut() async {
    await _authService.logout();
    Modular.to.pushReplacementNamed('/login');
  }

  set changePage(int page) {
    final newState = state.copyWith();
    newState.selectPage = page;
    newState.scaffoldKey.currentState!.openEndDrawer();
    update(newState);
  }

  Future<void> setFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );
    if (result != null) {
      final newState = state.copyWith(
        notice: result.files.single.bytes,
        labelFile: result.files.single.name,
      );
      update(newState);
    }
  }

  Future<int> get totalVacancies async =>
      (await _vacancyRepository.getVacancies(userId: user.id)).length;

  Future<void> registerVacancy() async {
    setLoading(true);
    VacancyModel vacancy;
    if (state.formKey.currentState!.validate()) {
      vacancy = await _vacancyRepository.registerVacancy(
        fileName: state.labelFile,
        vacancy: VacancyModel(
          course: state.selectedCourse!,
          notice: state.notice,
          createdAt: DateTime.now(),
          title: state.titleController.text,
          desc: state.descController.text,
          qntVacancy: int.parse(state.qntVacancyController.text),
        ),
        userId: user.id,
      );
      final newState = state.copyWith(vacancies: state.vacancies..add(vacancy));
      newState.clear();
      update(newState);
    }
    setLoading(false);
  }

  void changeData({CourseModel? course}) {
    final newState = state.copyWith(
      selectedCourse: course,
    );
    update(newState);
  }

  UserModel get user => _userRepository.user;
}
