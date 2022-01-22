import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:give_me_jobs_web/app/shared/models/course_model.dart';

class CourseRepository {
  final FirebaseFirestore _firestore;

  CourseRepository(this._firestore);

  Future<List<CourseModel>> getAllCourses() async {
    try {
      final response = await _firestore.collection("courses").get();
      final list = response.docs
          .map((e) => CourseModel.fromMap({
                'id': e.id,
                'name': e.get('name'),
              }))
          .toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
