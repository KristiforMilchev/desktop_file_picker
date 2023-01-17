import 'dart:io';

import 'package:desktop_file_picker/src/infrastructure/ifile_manager.dart';
import 'package:flutter/material.dart';

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
    var entries = await directory.list().toList();
    List<File> result = [];
    for (var element in entries) {
      var exists = await File(element.path).exists();
      if (exists) result.add(File(element.path));
    }

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
    for (var element in files) {
      var bytes = await element.length();
      folderTotal += bytes;
    }

    return folderTotal.toString();
  }

  @override
  Future<String> getDirectorylastModified(String directory) async {
    var files = await getFiles([], directory);
    DateTime? lastModified;
    for (var element in files) {
      var current = await element.lastModified();
      if (lastModified == null) {
        lastModified = current;
      } else if (lastModified.isBefore(current)) {
        lastModified = current;
      }
    }

    return lastModified != null ? lastModified.toIso8601String() : "";
  }
}
