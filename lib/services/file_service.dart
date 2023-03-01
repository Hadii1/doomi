import 'dart:io';

import 'package:doomi/interfaces/files.dart';
import 'package:path_provider/path_provider.dart';

class FilesService implements IFilesService {
  @override
  Future<File> writeFile(String name, String content) async {
    final Directory? directory = Platform.isIOS
        ? await getApplicationDocumentsDirectory()
        : await getExternalStorageDirectory();
    if (await directory!.exists() == false) {
      await directory.create(recursive: true);
    }

    final String filename = '${directory.path}/$name';

    // Check if the file already exists
    final file = File(filename);
    final fileExists = await file.exists();

    // If the file doesn't exist, create it
    if (!fileExists) {
      await file.create(recursive: true);
    }

    // Write the CSV data to a file

    File f = await file.writeAsString(content);
    return f;
  }
}
