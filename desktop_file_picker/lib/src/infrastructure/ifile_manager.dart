import 'dart:io';

abstract class IFileManager {
  Future<List<File>> getFiles(List<String> extensions, String path);
  Future<File?> getFile(String path);
  Future<List<Directory>> getDirectories(String path);
  Future<Directory?> getDirectory(String path);
  Future<Directory?> getParentDirectory(String path);
  String getOsDefault();
  String? getOsFolders();
  Future<String> getDirectorySize(String directory);
  Future<DateTime?> getDirectorylastModified(String directory);
  Future<List<Directory>> getDesktopDrives();
}
