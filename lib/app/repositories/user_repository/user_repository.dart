import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:give_me_jobs_web/app/app_module.dart';
import 'package:give_me_jobs_web/app/repositories/user_repository/user_repository_interface.dart';
import 'package:give_me_jobs_web/app/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository implements IUserRepository {
  SharedPreferences? ps;
  final _user = ValueNotifier<UserModel?>(null);
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepository(this._firebaseAuth, this._firestore) {
    init();
  }

  UserModel get user => _user.value!;
  set user(UserModel value) => _user.value = value;

  @override
  Future<void> init() async {
    await Modular.isModuleReady<AppModule>();
    if (Modular.get<SharedPreferences>().getString("user") != null) {
      user = UserModel.fromJson(
          Modular.get<SharedPreferences>().getString("user")!);
    }
  }

  @override
  Future<void> createUser({
    required String email,
    required String name,
    required String pass,
  }) async {
    ps = await SharedPreferences.getInstance();
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((value) async {
        final aux =
            UserModel(id: value.user!.uid, name: name, email: email, type: 2);
        await _firestore
            .collection("users")
            .doc(value.user!.uid)
            .set(aux.toMap());

        user = aux;
        await persistUser(user);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> persistUser(UserModel user) async {
    ps = await SharedPreferences.getInstance();
    try {
      await ps!.setString("user", user.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
