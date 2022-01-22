import 'package:flutter/material.dart';

class LoginState {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  LoginState();

  factory LoginState.initialState() {
    return LoginState();
  }
}
