import 'package:doomi/interfaces/auth.dart';
import 'package:doomi/interfaces/local_storage.dart';
import 'package:doomi/interfaces/online_storage.dart';
import 'package:doomi/models/user.dart';
import 'package:doomi/providers/auth_service_provider.dart';
import 'package:doomi/providers/local_stoage_provider.dart';
import 'package:doomi/providers/locale_provider.dart';
import 'package:doomi/providers/online_storage_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/providers/user_provider.dart';
import 'package:doomi/utils/enums.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appInitializationProvider =
    FutureProvider.autoDispose<AppInitializationState>(
  (ref) async {
    final IOnlineStorage db = ref.watch(onlineStorageProvider);
    final IAuthService auth = ref.watch(authServiceProvider);
    final ILocalStorage localStorage = ref.watch(localStorageProvider);

    await localStorage.initialize();
    await Future.delayed(const Duration(seconds: 2));

    // Initialize the theming & language state
    // by invoking their providers.
    ref.read(themeProvider);
    ref.read(localProvider);

    return AppInitializationState.loggedIn;

    String? userId = auth.userId();

    if (userId == null) {
      return AppInitializationState.loggedOut;
    }

    User? user = await retry<User?>(() => db.getUser(userId));

    ref.read(userProvider.notifier).user = user;

    if (user == null) {
      return AppInitializationState.loggedOut;
    } else {
      return AppInitializationState.loggedIn;
    }
  },
);
