import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_web/app/modules/login/login_state.dart';
import 'package:give_me_jobs_web/app/services/auth_service/auth_service.dart';

class LoginStore extends NotifierStore<Exception, LoginState> {
  final AuthService _authService;
  LoginStore(this._authService) : super(LoginState.initialState());

  Future<void> signIn() async {
    setLoading(true);
    try {
      await _authService
          .signInWithEmailAndPassword(
        email: state.emailController.text,
        pass: state.passController.text,
      )
          .then((value) {
        if (value.runtimeType == bool && value == true) {
          Modular.to.pushReplacementNamed('/');
        } else if (value.runtimeType == bool && value == false) {
          ScaffoldMessenger.of(state.scaffoldKey.currentContext!).showSnackBar(
            SnackBar(
              content: const Text('Você não tem permissão!'),
              backgroundColor:
                  Theme.of(state.scaffoldKey.currentContext!).errorColor,
            ),
          );
        }
      });
    } on Exception catch (e) {
      setError(Exception(e));
    } finally {
      setLoading(false);
    }
  }

  Future<void> resetPass(BuildContext context) async {
    try {
      await _authService
          .sendResetPass(email: state.emailController.text)
          .then((value) {
        if (value.runtimeType == bool && value == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('E-mail enviado, verifique sua caixa de entrada!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      });
    } on Exception catch (_) {
      setError(Exception(
          'Erro ao enviar o email, verifique se o e-mail está correto!'));
    }
  }
}
