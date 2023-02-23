import 'package:doomi/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider =
    StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  // Used to set the current user object after
  // logging in, registering, or logging out.
  set user(User? user) => state = user;
}
