import 'package:doomi/interfaces/online_storage.dart';
import 'package:doomi/services/firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onlineStorageProvider = Provider<IOnlineStorage>(
  (ref) => FirestoreService(),
);
