import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_web/app/modules/login/login_Page.dart';
import 'package:give_me_jobs_web/app/modules/login/login_store.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => LoginStore(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const LoginPage()),
  ];
}
