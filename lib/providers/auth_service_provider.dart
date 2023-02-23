import 'package:doomi/interfaces/auth.dart';
import 'package:doomi/services/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<IAuthService>((ref) => FirebaseAuthService());
