import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_web/app/core/app_themes.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GiveMeJobs - Painel de Controle',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeLight,
    ).modular();
  }
}
