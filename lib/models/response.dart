import 'package:doomi/utils/enums.dart';

class Response<T> {
  final T? data;
  final NetworkCallStatus status;
  final Exception? exception;

  Response({
    required this.data,
    required this.status,
    this.exception,
  });

  Response.loading({T? exisitingData})
      : exception = null,
        data = exisitingData,
        status = NetworkCallStatus.loading;

  Response.completed(this.data)
      : exception = null,
        status = NetworkCallStatus.success;

  Response.error({Exception? e})
      : status = NetworkCallStatus.error,
        exception = e,
        data = null;
}
