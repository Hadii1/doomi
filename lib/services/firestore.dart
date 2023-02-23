import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doomi/interfaces/online_storage.dart';
import 'package:doomi/models/user.dart';

class FirestoreService extends IOnlineStorage {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<User?> getUser(String id) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await _db.collection('users').doc(id).get();

    if (data.data() == null) return null;
    return User.fromMap(data.data()!);
  }

  @override
  Future<void> saveUser(User user) async {
    await _db.collection('users').doc().set(user.toMap());
  }
}
