import 'package:flutter/material.dart';
import 'package:give_me_jobs_web/app/core/app_text_styles.dart';
import 'package:give_me_jobs_web/app/modules/login/login_store.dart';
import 'package:give_me_jobs_web/app/modules/login/widgets/input_field/input_field_widget.dart';
import 'package:give_me_jobs_web/app/shared/widgets/button/button_widget.dart';

class FormLoginWidget extends StatelessWidget {
  const FormLoginWidget({
    Key? key,
    required Size size,
    required this.store,
  })  : _size = size,
        super(key: key);

  final Size _size;
  final LoginStore store;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          InputFieldWidget(
            hintText: 'E-mail',
            textController: store.state.emailController,
            textInputType: TextInputType.emailAddress,
          ),
          InputFieldWidget.pass(
            hintText: 'Senha',
            textController: store.state.passController,
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () async {
                await store.resetPass(context);
              },
              child: Text(
                'Esqueceu a senha?',
                style: AppTextStyles.button,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: _size.width,
            height: 40,
            child: ButtonWidget(
              label: 'Acessar',
              store: store,
              onPressed: () {
                store.signIn();
              },
            ),
          ),
        ],
      ),
    );
  }
}
