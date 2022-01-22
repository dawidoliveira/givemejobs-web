import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_web/app/app_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouterGuard implements RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    await Modular.isModuleReady<AppModule>();
    if (Modular.get<SharedPreferences>().getString("user") != null &&
        Modular.get<SharedPreferences>().getString("user")!.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  // TODO: implement guardedRoute
  String? get guardedRoute => '/login';
}
