import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_web/app/modules/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:give_me_jobs_web/app/modules/login/widgets/card_login/card_login_widget.dart';
import 'widgets/background/background_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ModularState<LoginPage, LoginStore> {
  @override
  void initState() {
    super.initState();
    store.observer(
      onError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString().split(': ')[1]),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      key: store.state.scaffoldKey,
      body: Stack(
        alignment: Alignment.center,
        children: [
          const BackgroundWidget(),
          CardLoginWidget(size: _size, store: store),
        ],
      ),
    );
  }
}
