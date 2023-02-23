import 'package:doomi/models/user.dart';

abstract class IOnlineStorage {
  Future<User?> getUser(String id);

  Future<User> saveUser(User user);
}
