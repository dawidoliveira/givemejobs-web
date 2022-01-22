import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_web/app/core/app_themes.dart';

class AppWidget extends StatelessWidget {
  final Future<FirebaseApp> _initFirebaseCore = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: _initFirebaseCore,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Icon(
                    Icons.close,
                    color: Theme.of(context).errorColor,
                  ),
                  const Text('Erro ao iniciar o Firebase.'),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return MaterialApp(
            title: 'GiveMeJobs - Painel de Controle',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.themeLight,
          ).modular();
        });
  }
}
