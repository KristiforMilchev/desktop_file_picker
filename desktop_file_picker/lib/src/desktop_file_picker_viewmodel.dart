import 'package:desktop_file_picker/src/application/converters/utilities.dart';
import 'package:desktop_file_picker/src/domain/models/select_binding.dart';
import 'package:desktop_file_picker/src/infrastructure/ifile_manager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

class DesktopFilePickerViewModel extends BaseViewModel {
  GetIt getIt = GetIt.I;
  late IFileManager _fileManager;

  late List<SelectBinding> _commonPaths = [];
  List<SelectBinding> get commonPaths => _commonPaths;

  late SelectBinding? _selectedDomainFolder = SelectBinding(
      name: "name", path: "", modifiedDate: "", size: "", icon: Icons.folder);
  SelectBinding? get selectedDomainFolder => _selectedDomainFolder;

  late List<SelectBinding> _folderContent = [];
  List<SelectBinding> get folderContent => _folderContent;

  void commonPathSelected(value) {}

  void initialize() async {
    _fileManager = getIt.get<IFileManager>();
    var getName = _fileManager.getOsFolders();
    var folders = await _fileManager.getDirectories(getName!);
    _commonPaths = folders
        .map(
          (e) => SelectBinding(
            name: Utilities.getFileName(e.path),
            path: e.path,
            modifiedDate: "",
            size: "",
            icon: Icons.folder,
          ),
        )
        .toList();

    var userDefault = _fileManager.getOsDefault();
    _selectedDomainFolder = SelectBinding(
        name: userDefault,
        path: userDefault,
        modifiedDate: "",
        size: "",
        icon: Icons.abc);

    var content = await _fileManager.getDirectories(userDefault);
    var files = await _fileManager.getFiles([], userDefault);
    List<SelectBinding> mappedContent = [];
    List<SelectBinding> mappedFiles = [];

    for (var e in content) {
      mappedContent.add(
        SelectBinding(
          icon: Icons.folder,
          name: Utilities.getFolderName(e.path),
          path: e.path,
          modifiedDate: await _fileManager.getDirectorylastModified(e.path),
          size: await _fileManager.getDirectorySize(e.path),
        ),
      );
    }

    for (var e in files) {
      mappedFiles.add(
        SelectBinding(
          icon: Utilities.getExtensionIcon(e.path),
          name: Utilities.getFileName(e.path),
          path: e.path,
          modifiedDate: await Utilities.convertDateAsync(e),
          size: await Utilities.convertSizeAsync(e),
        ),
      );
    }

    _folderContent.addAll(mappedContent);
    _folderContent.addAll(mappedFiles);
    notifyListeners();
  }
}
