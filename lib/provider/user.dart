import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/dummy_data/user.dart';
import 'package:logaluxe_users/model/user.dart';

class UserNotifier extends StateNotifier<List<UserModel>> {
  UserNotifier() : super(allUsers);
}

var userProvider = StateNotifierProvider<UserNotifier, List<UserModel>>(
  (ref) {
    return UserNotifier();
  },
);
