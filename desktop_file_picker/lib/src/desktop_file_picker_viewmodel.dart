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
    name: "name",
    path: "",
    modifiedDate: "",
    size: "",
    icon: Icons.folder,
    isFolder: true,
    isSelected: false,
    isVisible: true,
  );

  SelectBinding? get selectedDomainFolder => _selectedDomainFolder;
  late List<SelectBinding> _originalContent = [];
  late List<SelectBinding> _folderContent = [];
  List<SelectBinding> get folderContent => _folderContent;
  late bool _isSingleFile;
  late bool _isSingleFolder;
  late bool _isMultipleFiles;
  List<String> _extensions = [];
  late Function _callbackCancel;
  late Function _callbackConfirm;

  void commonPathSelected(value) {}

  void initialize(
      bool? isSingleFile,
      bool? isSingleFolder,
      bool? isMultipleFiles,
      List<String>? extensions,
      Function callbackCancel,
      Function callbackConfirm) async {
    _isSingleFile = isSingleFile == null ? false : true;
    _isMultipleFiles = isMultipleFiles == null ? false : true;
    _isSingleFolder = isSingleFolder == null ? false : true;
    _extensions = extensions ?? [];

    _callbackCancel = callbackCancel;
    _callbackConfirm = callbackConfirm;

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
            isFolder: true,
            isSelected: false,
            isVisible: true,
          ),
        )
        .toList();
    var userDefault = _fileManager.getOsDefault();
    await openFolder(userDefault);
    notifyListeners();
  }

  Future openFolder(String path) async {
    _folderContent.clear();
    _selectedDomainFolder = SelectBinding(
      name: path,
      path: path,
      modifiedDate: "",
      size: "",
      icon: Icons.abc,
      isFolder: true,
      isSelected: false,
      isVisible: true,
    );
    var content = await _fileManager.getDirectories(path);
    List<SelectBinding> mappedContent = [];

    for (var e in content) {
      mappedContent.add(
        SelectBinding(
          icon: Icons.folder,
          name: Utilities.getFolderName(e.path),
          path: e.path,
          modifiedDate: await _fileManager.getDirectorylastModified(e.path),
          size: await _fileManager.getDirectorySize(e.path),
          isFolder: true,
          isSelected: false,
          isVisible: true,
        ),
      );
    }

    _originalContent.addAll(mappedContent);

    if (!_isSingleFolder) {
      var files = await _fileManager.getFiles(_extensions, path);
      List<SelectBinding> mappedFiles = [];
      for (var e in files) {
        mappedFiles.add(
          SelectBinding(
            icon: Utilities.getExtensionIcon(e.path),
            name: Utilities.getFileName(e.path),
            path: e.path,
            modifiedDate: await Utilities.convertDateAsync(e),
            size: await Utilities.convertSizeAsync(e),
            isFolder: false,
            isSelected: false,
            isVisible: true,
          ),
        );
      }

      _originalContent.addAll(mappedFiles);
    }

    _folderContent = _originalContent;
  }

  returnFolder() async {
    var prevDirectory =
        await _fileManager.getParentDirectory(_selectedDomainFolder!.path);

    await openFolder(prevDirectory!.path);
    notifyListeners();
  }

  folderSelected(SelectBinding e) async {
    if (!e.isFolder) return;

    await openFolder(e.path);
    notifyListeners();
  }

  gridElementSelected(SelectBinding e) async {
    if (_isSingleFile && !e.isFolder) {
      _folderContent.where((element) => element.isSelected).forEach((element) {
        element.isSelected = false;
      });
      _folderContent.firstWhere((element) => element == e).isSelected = true;
    } else if (_isMultipleFiles && !e.isFolder) {
      _folderContent.firstWhere((element) => element == e).isSelected =
          !e.isSelected;
    } else if (_isSingleFolder && e.isFolder) {
      _folderContent.where((element) => element.isSelected).forEach((element) {
        element.isSelected = false;
      });
      _folderContent.firstWhere((element) => element == e).isSelected = true;
    }

    notifyListeners();
  }

  searchChanged(String value) {
    if (value.isEmpty) {
      _folderContent = _originalContent;
    } else {
      var copy = _originalContent
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();

      _folderContent = copy;
    }

    notifyListeners();
  }

  confirmPressed() async {
    List<String> result = [];
    if (_isSingleFolder) {
      var folder = _folderContent.where((element) => element.isSelected).first;
      var files = await _fileManager.getFiles(_extensions, folder.path);
      result = files.map((e) => e.path).toList();
    } else if (_isSingleFile) {
      var file = _folderContent.where((element) => element.isSelected).first;
      result = [file.path];
    } else if (_isMultipleFiles) {
      var folder =
          _folderContent.where((element) => element.isSelected).toList();
      result = folder.map((e) => e.path).toList();
    }
    _callbackConfirm.call(result);
  }

  dialogCancel() {
    _callbackCancel.call();
  }
}
