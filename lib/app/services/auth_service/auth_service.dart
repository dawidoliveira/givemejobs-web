import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:give_me_jobs_web/app/repositories/user_repository/user_repository.dart';
import 'package:give_me_jobs_web/app/services/auth_service/auth_service_interface.dart';
import 'package:give_me_jobs_web/app/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService implements IAuthService {
  final UserRepository _userRepository;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final SharedPreferences _ps;

  AuthService(
      this._userRepository, this._firebaseAuth, this._firestore, this._ps);

  @override
  Future<dynamic> signInWithEmailAndPassword(
      {required String email, required String pass}) async {
    try {
      final existsAndIsAdmin = await verifyingUser(email);
      if (existsAndIsAdmin) {
        await _firebaseAuth
            .signInWithEmailAndPassword(email: email, password: pass)
            .then((value) async {
          final aux =
              await _firestore.collection("users").doc(value.user!.uid).get();
          _userRepository.user = UserModel(
            id: value.user!.uid,
            name: aux.get('name').toString(),
            email: aux.get('email').toString(),
            type: aux.get('type') as int,
          );
          await _userRepository.persistUser(_userRepository.user);
        });
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyingUser(String email) async {
    for (final user in (await _firestore.collection('users').get()).docs) {
      if (user.get('email') == email && user.get('type') == 2) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<dynamic> sendResetPass({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      await _ps.remove('user');
    } catch (e) {
      rethrow;
    }
  }
}
