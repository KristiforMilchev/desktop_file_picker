import 'dart:io';

import 'package:desktop_file_picker/src/application/converters/utilities.dart';
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
  Future<Directory?> getParentDirectory(String path) async {
    var exists = await Directory(path).exists();
    return exists ? Directory(path).parent : null;
  }

  @override
  Future<File?> getFile(String path) async {
    var exists = await File(path).exists();
    return exists ? File(path) : null;
  }

  @override
  Future<List<File>> getFiles(List<String> extensions, String path) async {
    var directory = Directory(path);
    List<File> result = [];

    try {
      var entries = await directory.list().toList();
      for (var element in entries) {
        var exists = await File(element.path).exists();

        if (exists) {
          var extension = Utilities.getFileExtension(element.path);
          if (extensions.isNotEmpty) {
            var contains = extensions.contains(extension);
            if (contains) result.add(File(element.path));
          } else {
            result.add(File(element.path));
          }
        }
      }
    } catch (Exception) {}

    return result;
  }

  @override
  String getOsDefault() {
    String? home = "";
    Map<String, String> envVars = Platform.environment;
    if (Platform.isMacOS) {
      home = envVars['HOME'];
    } else if (Platform.isLinux) {
      home = envVars['HOME'];
    } else if (Platform.isWindows) {
      home = envVars['UserProfile'];
    }

    return home!;
  }

  @override
  String? getOsFolders() {
    String? path = "";
    Map<String, String> envVars = Platform.environment;
    var user;
    if (Platform.isMacOS) {
      user = envVars['USERNAME'];
      path = "/media/$user";
    } else if (Platform.isLinux) {
      user = envVars['USERNAME'];
      path = "/media/$user";
    } else if (Platform.isWindows) {
      user = envVars['USERNAME'];
      path = "/media/$user";
    }

    return path;
  }

  @override
  Future<String> getDirectorySize(String directory) async {
    var files = await getFiles([], directory);
    var folderTotal = 0;
    try {
      for (var element in files) {
        var bytes = await element.length();
        folderTotal += bytes;
      }
    } catch (Exception) {}
    return folderTotal.toString();
  }

  @override
  Future<DateTime?> getDirectorylastModified(String directory) async {
    var files = await getFiles([], directory);
    DateTime? lastModified;
    try {
      for (var element in files) {
        var current = await element.lastModified();
        if (lastModified == null) {
          lastModified = current;
        } else if (lastModified.isBefore(current)) {
          lastModified = current;
        }
      }
    } catch (Exception) {}

    return lastModified ?? null;
  }
}
