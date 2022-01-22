import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_web/app/modules/home/home_page.dart';
import 'package:give_me_jobs_web/app/modules/home/home_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore(i(), i(), i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
  ];
}
