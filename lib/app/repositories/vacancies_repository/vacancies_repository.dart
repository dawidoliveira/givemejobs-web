import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:give_me_jobs_web/app/repositories/vacancies_repository/vacancies_repository_interface.dart';
import 'package:give_me_jobs_web/app/shared/models/candidate_model.dart';
import 'package:give_me_jobs_web/app/shared/models/course_model.dart';
import 'package:give_me_jobs_web/app/shared/models/vacancy_model.dart';
import 'package:uuid/uuid.dart';

class VacancyRepository implements IVacanciesRepository {
  final FirebaseStorage _firebaseStorage;
  final FirebaseFirestore _firebaseFirestore;

  VacancyRepository(this._firebaseStorage, this._firebaseFirestore);

  @override
  Future<List<VacancyModel>> getVacancies({required String userId}) async {
    try {
      final courses = (await _firebaseFirestore.collection('courses').get())
          .docs
          .map((e) => CourseModel.fromMap({
                'id': e.id,
                'name': e.get('name'),
              }))
          .toList();
      final vacancies = <VacancyModel>[];

      for (final course in courses) {
        final vacs = (await _firebaseFirestore
                .collection('vacancies')
                .doc(course.id)
                .collection(userId)
                .get())
            .docs
            .map((e) async {
          final candidates = (await _firebaseFirestore
                  .collection('vacancies')
                  .doc(course.id)
                  .collection(userId)
                  .doc(e.id)
                  .collection('candidates')
                  .get())
              .docs;
          return VacancyModel.fromMap({
            'id': e.id,
            'course': course,
            'title': e.get('title'),
            'desc': e.get('desc'),
            'qntVacancy': e.get('qntVacancy'),
            'urlFile': e.get('notice'),
            'createdAt': e.get('createdAt'),
            'candidates': candidates.map((e) {
              return CandidateModel.fromMap({
                'id': e.id,
                'name': e.get('name'),
                'imgUrl': e.get('imgUrl'),
                'curriculum': e.get('curriculum'),
                'email': e.get('email'),
              });
            }).toList(),
          });
        }).toList();
        for (final v in vacs) {
          final aux = await v;
          vacancies.add(aux);
        }
      }

      return vacancies;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VacancyModel> registerVacancy(
      {required VacancyModel vacancy,
      required String userId,
      required String fileName}) async {
    try {
      final vac = vacancy.copyWith(
        id: const Uuid().v4(),
      );
      var downloadUrl = "";
      if (vac.notice != null) {
        await _firebaseStorage
            .ref('/vacancies/${vac.course.id}/$userId/${vac.id}/$fileName')
            .putData(vacancy.notice!);
        downloadUrl = await _firebaseStorage
            .ref('/vacancies/${vac.course.id}/$userId/${vac.id}/$fileName')
            .getDownloadURL();
      }

      await _firebaseFirestore.collection('vacancies').doc(vac.course.id).set({
        't': '',
      }); // confirmar existencia da collection criada logo em seguida.

      await _firebaseFirestore
          .collection('vacancies')
          .doc(vac.course.id)
          .collection(userId)
          .doc(vac.id)
          .set({
        'title': vac.title,
        'createdAt': vac.createdAt,
        'desc': vac.desc,
        'qntVacancy': vac.qntVacancy,
        'notice': downloadUrl,
      });

      return vac;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeVacancy(
      {required String userId,
      required String courseId,
      required String vacancyId}) async {
    try {
      await _firebaseFirestore
          .collection('vacancies')
          .doc(userId)
          .collection(courseId)
          .doc(vacancyId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
