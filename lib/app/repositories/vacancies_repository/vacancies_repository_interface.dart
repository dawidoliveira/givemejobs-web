import 'package:give_me_jobs_web/app/shared/models/vacancy_model.dart';

abstract class IVacanciesRepository {
  Future<VacancyModel> registerVacancy(
      {required VacancyModel vacancy,
      required String userId,
      required String fileName});
  Future<List<VacancyModel>> getVacancies({required String userId});
  Future<void> removeVacancy({
    required String userId,
    required String courseId,
    required String vacancyId,
  });
}
