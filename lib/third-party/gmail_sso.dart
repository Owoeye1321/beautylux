import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logaluxe_users/model/user.dart';

class UserRepository {
  static Future<UserModel?> loginWithGoodgle() async {
    final googleAccount = await GoogleSignIn().signIn();
    final googleAuth = await googleAccount?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    return UserModel(
      first_name: userCredential.user?.displayName ?? '',
      id: userCredential.user?.uid ?? '',
      email: userCredential.user?.email ?? '',
      bio: '',
      image_url: userCredential.user?.photoURL ?? '',
      business_name: '',
      business_address: '',
      token: userCredential.user?.refreshToken ?? '',
      company_id: '',
    );
    // signing in with firebase auth
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
