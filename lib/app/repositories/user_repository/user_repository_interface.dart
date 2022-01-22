import 'package:give_me_jobs_web/app/shared/models/user_model.dart';

abstract class IUserRepository {
  Future<void> init();
  Future<void> createUser({
    required String email,
    required String name,
    required String pass,
  });
  Future<void> persistUser(UserModel user);
}
