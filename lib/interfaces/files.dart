import 'dart:io';

abstract class IFilesService {
  Future<File> writeFile(String path, String content);
}
