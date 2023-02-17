import 'package:desktop_file_picker/src/application/converters/utilities.dart';
import 'package:desktop_file_picker/src/domain/models/select_binding.dart';
import 'package:desktop_file_picker/src/infrastructure/ifile_manager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import 'domain/models/theme_data.dart';

class DesktopFilePickerViewModel extends BaseViewModel {
  GetIt getIt = GetIt.I;
  late IFileManager _fileManager;
  late BuildContext _context;

  late List<SelectBinding> _commonPaths = [];
  List<SelectBinding> get commonPaths => _commonPaths;

  late bool _filterName;
  late bool _filterDate;
  late bool _filterSize;
  late bool _filterType;

  late SelectBinding? _selectedDomainFolder = SelectBinding(
    name: "name",
    path: "",
    extension: "folder",
    modifiedDate: null,
    size: "",
    icon: Icons.folder,
    isFolder: true,
    isSelected: false,
    isVisible: true,
  );

  late bool _isMountPointSelected = false;
  bool get isMountPointSelected => _isMountPointSelected;

  SelectBinding? get selectedDomainFolder => _selectedDomainFolder;
  late List<SelectBinding> _originalContent = [];
  late List<SelectBinding> _folderContent = [];
  List<SelectBinding> get folderContent => _folderContent;
  late bool _isSingleFile;
  late bool _isSingleFolder;
  late bool _isMultipleFiles;
  List<String> _extensions = [];
  late PickerThemeData? _themeSettings;
  late Function _callbackCancel;
  late Function _callbackConfirm;

  PickerThemeData? get themeSettings => _themeSettings;

  late int _axieItemCount = 4;
  get axieItemCount => _axieItemCount;

  void initialize(
    bool? isSingleFile,
    bool? isSingleFolder,
    bool? isMultipleFiles,
    List<String>? extensions,
    PickerThemeData? themeSettings,
    Function callbackCancel,
    Function callbackConfirm,
    BuildContext context,
  ) async {
    _isSingleFile = isSingleFile == null ? false : true;
    _isMultipleFiles = isMultipleFiles == null ? false : true;
    _isSingleFolder = isSingleFolder == null ? false : true;
    _extensions = extensions ?? [];
    _callbackCancel = callbackCancel;
    _callbackConfirm = callbackConfirm;
    _isMountPointSelected = false;
    if (themeSettings != null) {
      _themeSettings = Utilities.overrideDefault(themeSettings);
    } else {
      _themeSettings = Utilities.getDefaultTheme();
    }

    _context = context;

    _filterDate = false;
    _filterSize = false;
    _filterName = false;
    _filterType = false;

    _fileManager = getIt.get<IFileManager>();
    var folders = await _fileManager.getDesktopDrives();
    _commonPaths = folders
        .map(
          (e) => SelectBinding(
            name: e.path,
            extension: "hardrive",
            path: e.path,
            size: "",
            icon: Icons.storage,
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
    _originalContent.clear();
    _folderContent.clear();
    _selectedDomainFolder = SelectBinding(
      name: path,
      path: path,
      extension: "folder",
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
          extension: "folder",
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
            extension: Utilities.getFileExtension(e.path),
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

  void commonPathSelected(SelectBinding value) async {
    _isMountPointSelected = !isMountPointSelected;
    await openFolder(value.path);
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

  sortByName() {
    if (!_filterName) {
      _folderContent = (_folderContent
            ..sort((a, b) => a.name.compareTo(b.name)))
          .reversed
          .toList();
      _filterName = true;
    } else {
      _folderContent.sort((a, b) => a.name.compareTo(b.name));
      _filterName = false;
    }

    notifyListeners();
  }

  sortByDate() {
    if (!_filterDate) {
      _folderContent = (_folderContent
            ..sort((a, b) => dateSortComparison(a, b)))
          .reversed
          .toList();
      _filterDate = true;
    } else {
      _folderContent.sort((a, b) => dateSortComparison(a, b));

      _filterDate = false;
    }

    notifyListeners();
  }

  sortBySize() {
    if (!_filterSize) {
      _folderContent = (_folderContent..sort((a, b) => sizeComparison(a, b)))
          .reversed
          .toList();
      _filterSize = true;
    } else {
      _folderContent.sort((a, b) => sizeComparison(a, b));

      _filterSize = false;
    }

    notifyListeners();
  }

  sortByType() {
    if (!_filterType) {
      _folderContent = (_folderContent
            ..sort((a, b) => a.extension.compareTo(b.extension)))
          .reversed
          .toList();
      _filterType = true;
    } else {
      _folderContent.sort((a, b) => a.extension.compareTo(b.extension));
      _filterType = false;
    }

    notifyListeners();
  }

  dateSortComparison(SelectBinding a, SelectBinding b) {
    var aDate = a.modifiedDate ?? DateTime.now();
    var bDate = b.modifiedDate ?? DateTime.now();
    var isBefore = aDate.isBefore(bDate);
    if (isBefore) {
      return 1;
    } else {
      return -1;
    }
  }

  sizeComparison(SelectBinding a, SelectBinding b) {
    var isBefore = int.parse(a.size) > int.parse(b.size);
    if (isBefore) {
      return 1;
    } else {
      return -1;
    }
  }

  changeMountPoint() {
    _isMountPointSelected = !_isMountPointSelected;
    notifyListeners();
  }

  gridResized() {
    var currentSize = MediaQuery.of(_context).size;

    if (currentSize.width < 400) {
      _axieItemCount = 1;
    } else if (currentSize.width < 600) {
      _axieItemCount = 2;
    } else if (currentSize.width < 900) {
      _axieItemCount = 3;
    } else if (currentSize.width > 900 && currentSize.width < 1600) {
      _axieItemCount = 4;
    } else if (currentSize.width > 1600 && currentSize.width < 2200) {
      _axieItemCount = 8;
    } else if (currentSize.width > 2300) {
      _axieItemCount = 12;
    }

    notifyListeners();
  }
}
