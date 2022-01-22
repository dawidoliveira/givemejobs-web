import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_web/app/app_module.dart';
import 'package:give_me_jobs_web/app/app_widget.dart';
import 'package:give_me_jobs_web/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ModularApp(module: AppModule(), child: AppWidget()),
  );
}
