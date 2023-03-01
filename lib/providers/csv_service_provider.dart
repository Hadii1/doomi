import 'package:doomi/services/csv_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final csvServiceProvider = Provider.autoDispose((ref) {
  return CsvService();
});
