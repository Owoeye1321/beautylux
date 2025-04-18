import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/auth/login.dart';
import 'package:logaluxe_users/provider/auth/verify_email.dart';

class ProfileNotifier extends StateNotifier<UserModel> {
  ProfileNotifier()
      : super(UserModel(
            first_name: '',
            bio: '',
            email: '',
            business_name: '',
            business_address: '',
            token: '',
            company_id: '',
            id: ''));
  authenticate(UserModel user) {
    state = user;
  }

  logOut() {
    state = UserModel(
        first_name: '', bio: '', email: '', business_name: '', business_address: '', token: '', company_id: '', id: '');
  }
}

var profileProvider = StateNotifierProvider<ProfileNotifier, UserModel>(
  (ref) {
    return ProfileNotifier();
  },
);
