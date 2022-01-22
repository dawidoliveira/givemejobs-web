abstract class IAuthService {
  Future<dynamic> signInWithEmailAndPassword(
      {required String email, required String pass});

  Future<dynamic> sendResetPass({required String email});

  Future<void> logout();
}
