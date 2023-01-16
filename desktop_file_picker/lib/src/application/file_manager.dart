import 'dart:io';

import 'package:desktop_file_picker/src/infrastructure/ifile_manager.dart';

class FileManager implements IFileManager {
  @override
  Future<List<Directory>> getDirectories(String path) async {
    var directory = Directory(path);
    var entries = await directory.list().toList();
    List<Directory> result = [];
    for (var element in entries) {
      var exists = await Directory(element.path).exists();
      if (exists) result.add(Directory(element.path));
    }

    return result;
  }

  @override
  Future<Directory?> getDirectory(String path) async {
    var exists = await Directory(path).exists();
    return exists ? Directory(path) : null;
  }

  @override
  Future<File?> getFile(String path) async {
    var exists = await File(path).exists();
    return exists ? File(path) : null;
  }

  @override
  Future<List<File>> getFiles(List<String> extensions, String path) async {
    var directory = Directory(path);
    var entries = await directory.list().toList();
    List<File> result = [];
    for (var element in entries) {
      var exists = await File(element.path).exists();
      if (exists) result.add(File(element.path));
    }

    return result;
  }

  String getOsDelimiter() {
    String? result = "";
    if (Platform.isMacOS) {
      result = "/";
    } else if (Platform.isLinux) {
      result = "/";
    } else if (Platform.isWindows) {
      result = "\\";
    }
    return result;
  }

  String getFileExtension(String file) {
    return file.split('.').last;
  }

  String getFileName(String file) {
    return file.split("/").last.split(".").first;
  }
}
