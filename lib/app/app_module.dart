import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_web/app/core/login_guard.dart';
import 'package:give_me_jobs_web/app/core/router_guard.dart';
import 'package:give_me_jobs_web/app/modules/home/home_module.dart';
import 'package:give_me_jobs_web/app/modules/login/login_module.dart';
import 'package:give_me_jobs_web/app/repositories/course_repository/course_repository.dart';
import 'package:give_me_jobs_web/app/repositories/user_repository/user_repository.dart';
import 'package:give_me_jobs_web/app/repositories/vacancies_repository/vacancies_repository.dart';
import 'package:give_me_jobs_web/app/services/auth_service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    AsyncBind((i) => SharedPreferences.getInstance()),
    Bind.lazySingleton((i) => FirebaseFirestore.instance),
    Bind.lazySingleton((i) => FirebaseAuth.instance),
    Bind.lazySingleton((i) => FirebaseStorage.instance),
    Bind.lazySingleton((i) => CourseRepository(i())),
    Bind.lazySingleton((i) => UserRepository(i(), i())),
    Bind.lazySingleton((i) => AuthService(i(), i(), i(), i())),
    Bind.lazySingleton((i) => VacancyRepository(i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      '/',
      module: HomeModule(),
      guards: [RouterGuard()],
    ),
    ModuleRoute(
      '/login',
      module: LoginModule(),
      guards: [LoginGuard()],
    ),
  ];
}
