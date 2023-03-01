import 'package:doomi/services/file_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filesServiceProvider = Provider.autoDispose((ref) {
  return FilesService();
});
