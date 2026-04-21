import 'package:desktop_file_picker/src/application/converters/utilities.dart';
import 'package:desktop_file_picker/src/domain/models/select_binding.dart';
import 'package:desktop_file_picker/src/infrastructure/ifile_manager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import 'domain/models/theme_data.dart';

class DesktopFilePickerViewModel extends BaseViewModel {
  final GetIt getIt = GetIt.I;

  late final IFileManager _fileManager;
  late BuildContext _context;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  List<SelectBinding> _commonPaths = [];
  List<SelectBinding> get commonPaths => _commonPaths;

  bool _filterName = false;
  bool _filterDate = false;
  bool _filterSize = false;
  bool _filterType = false;

  SelectBinding? _selectedDomainFolder;
  SelectBinding? get selectedDomainFolder => _selectedDomainFolder;

  final List<SelectBinding> _originalContent = [];
  List<SelectBinding> _folderContent = [];
  List<SelectBinding> get folderContent => _folderContent;

  bool _isMountPointSelected = false;
  bool get isMountPointSelected => _isMountPointSelected;

  bool _isSingleFile = false;
  bool _isSingleFolder = false;
  bool _isMultipleFiles = false;

  List<String> _extensions = [];

  PickerThemeData? _themeSettings;
  PickerThemeData? get themeSettings => _themeSettings;

  late Function _callbackCancel;
  late Function _callbackConfirm;

  int _axieItemCount = 4;
  int get axieItemCount => _axieItemCount;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> initialize(
    bool? isSingleFile,
    bool? isSingleFolder,
    bool? isMultipleFiles,
    List<String>? extensions,
    PickerThemeData? themeSettings,
    Function callbackCancel,
    Function callbackConfirm,
    BuildContext context,
  ) async {
    _isSingleFile = isSingleFile ?? false;
    _isSingleFolder = isSingleFolder ?? false;
    _isMultipleFiles = isMultipleFiles ?? false;
    _extensions = List<String>.from(extensions ?? []);
    _callbackCancel = callbackCancel;
    _callbackConfirm = callbackConfirm;
    _context = context;
    _isMountPointSelected = false;

    _themeSettings = themeSettings != null
        ? Utilities.overrideDefault(themeSettings, context)
        : Utilities.getDefaultTheme(context);

    _filterDate = false;
    _filterSize = false;
    _filterName = false;
    _filterType = false;

    _fileManager = getIt.get<IFileManager>();

    _setLoading(true);

    final folders = await _fileManager.getDesktopDrives();
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

    final userDefault = _fileManager.getOsDefault();
    await openFolder(userDefault);

    _setLoading(false);
  }

  Future<void> openFolder(String path) async {
    _originalContent.clear();
    _folderContent = [];

    _selectedDomainFolder = SelectBinding(
      name: path,
      path: path,
      extension: "folder",
      size: "",
      icon: Icons.folder,
      isFolder: true,
      isSelected: false,
      isVisible: true,
    );

    final directories = await _fileManager.getDirectories(path);

    final mappedDirectories = await Future.wait(
      directories.map((e) async {
        final modifiedDate =
            await _fileManager.getDirectorylastModified(e.path);
        final size = await _fileManager.getDirectorySize(e.path);

        return SelectBinding(
          icon: Icons.folder,
          name: Utilities.getFolderName(e.path),
          extension: "folder",
          path: e.path,
          modifiedDate: modifiedDate,
          size: size,
          isFolder: true,
          isSelected: false,
          isVisible: true,
        );
      }),
    );

    _originalContent.addAll(mappedDirectories);

    if (!_isSingleFolder) {
      final files = await _fileManager.getFiles(_extensions, path);

      final mappedFiles = await Future.wait(
        files.map((e) async {
          final modifiedDate = await Utilities.convertDateAsync(e);
          final size = await Utilities.convertSizeAsync(e);

          return SelectBinding(
            icon: Utilities.getExtensionIcon(e.path),
            name: Utilities.getFileName(e.path),
            extension: Utilities.getFileExtension(e.path),
            path: e.path,
            modifiedDate: modifiedDate,
            size: size,
            isFolder: false,
            isSelected: false,
            isVisible: true,
          );
        }),
      );

      _originalContent.addAll(mappedFiles);
    }

    _folderContent = List<SelectBinding>.from(_originalContent);
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> returnFolder() async {
    final selected = _selectedDomainFolder;
    if (selected == null || selected.path.isEmpty) {
      return;
    }

    final prevDirectory = await _fileManager.getParentDirectory(selected.path);

    if (prevDirectory == null) {
      return;
    }

    _setLoading(true);
    await openFolder(prevDirectory.path);
    _setLoading(false);
  }

  Future<void> folderSelected(SelectBinding e) async {
    if (!e.isFolder) {
      return;
    }

    _setLoading(true);
    await openFolder(e.path);
    _setLoading(false);
  }

  Future<void> commonPathSelected(SelectBinding value) async {
    _clearCommonPathSelection();
    value.isSelected = true;

    _isMountPointSelected = false;
    _setLoading(true);
    notifyListeners();

    await openFolder(value.path);

    _setLoading(false);
  }

  void gridElementSelected(SelectBinding e) {
    if (_isSingleFile && !e.isFolder) {
      bool changed = false;

      for (final element in _folderContent) {
        if (identical(element, e)) {
          if (!element.isSelected) {
            element.isSelected = true;
            changed = true;
          }
        } else if (element.isSelected) {
          element.isSelected = false;
          changed = true;
        }
      }

      if (changed) {
        notifyListeners();
      }
      return;
    }

    if (_isMultipleFiles && !e.isFolder) {
      e.isSelected = !e.isSelected;
      notifyListeners();
      return;
    }

    if (_isSingleFolder && e.isFolder) {
      bool changed = false;

      for (final element in _folderContent) {
        if (identical(element, e)) {
          if (!element.isSelected) {
            element.isSelected = true;
            changed = true;
          }
        } else if (element.isSelected) {
          element.isSelected = false;
          changed = true;
        }
      }

      if (changed) {
        notifyListeners();
      }
    }
  }

  void searchChanged(String value) {
    final normalized = value.trim().toLowerCase();

    if (normalized.isEmpty) {
      _folderContent = List<SelectBinding>.from(_originalContent);
    } else {
      _folderContent = _originalContent
          .where((element) => element.name.toLowerCase().contains(normalized))
          .toList();
    }

    notifyListeners();
  }

  Future<void> confirmPressed() async {
    List<String> result = [];

    if (_isSingleFolder) {
      final selectedFolders =
          _folderContent.where((element) => element.isSelected).toList();

      if (selectedFolders.isEmpty) {
        return;
      }

      final folder = selectedFolders.first;
      final files = await _fileManager.getFiles(_extensions, folder.path);
      result = files.map((e) => e.path).toList();
    } else if (_isSingleFile) {
      final selectedFiles =
          _folderContent.where((element) => element.isSelected).toList();

      if (selectedFiles.isEmpty) {
        return;
      }

      result = [selectedFiles.first.path];
    } else if (_isMultipleFiles) {
      final selectedFiles =
          _folderContent.where((element) => element.isSelected).toList();
      result = selectedFiles.map((e) => e.path).toList();
    }

    _callbackConfirm.call(result);
  }

  void dialogCancel() {
    _callbackCancel.call();
  }

  void sortByName() {
    _folderContent = List<SelectBinding>.from(_folderContent)
      ..sort((a, b) => a.name.compareTo(b.name));

    if (!_filterName) {
      _folderContent = _folderContent.reversed.toList();
    }

    _filterName = !_filterName;
    notifyListeners();
  }

  void sortByDate() {
    _folderContent = List<SelectBinding>.from(_folderContent)
      ..sort((a, b) => dateSortComparison(a, b));

    if (!_filterDate) {
      _folderContent = _folderContent.reversed.toList();
    }

    _filterDate = !_filterDate;
    notifyListeners();
  }

  void sortBySize() {
    _folderContent = List<SelectBinding>.from(_folderContent)
      ..sort((a, b) => sizeComparison(a, b));

    if (!_filterSize) {
      _folderContent = _folderContent.reversed.toList();
    }

    _filterSize = !_filterSize;
    notifyListeners();
  }

  void sortByType() {
    _folderContent = List<SelectBinding>.from(_folderContent)
      ..sort((a, b) => a.extension.compareTo(b.extension));

    if (!_filterType) {
      _folderContent = _folderContent.reversed.toList();
    }

    _filterType = !_filterType;
    notifyListeners();
  }

  int dateSortComparison(SelectBinding a, SelectBinding b) {
    final aDate = a.modifiedDate ?? DateTime.fromMillisecondsSinceEpoch(0);
    final bDate = b.modifiedDate ?? DateTime.fromMillisecondsSinceEpoch(0);
    return aDate.compareTo(bDate);
  }

  int sizeComparison(SelectBinding a, SelectBinding b) {
    final aSize = int.tryParse(a.size) ?? 0;
    final bSize = int.tryParse(b.size) ?? 0;
    return aSize.compareTo(bSize);
  }

  void changeMountPoint() {
    _isMountPointSelected = !_isMountPointSelected;
    notifyListeners();
  }

  void gridResized() {
    final currentSize = MediaQuery.of(_context).size;

    int nextCount;
    if (currentSize.width < 400) {
      nextCount = 1;
    } else if (currentSize.width < 600) {
      nextCount = 2;
    } else if (currentSize.width < 900) {
      nextCount = 3;
    } else if (currentSize.width < 1600) {
      nextCount = 4;
    } else if (currentSize.width < 2200) {
      nextCount = 8;
    } else {
      nextCount = 12;
    }

    if (nextCount == _axieItemCount) {
      return;
    }

    _axieItemCount = nextCount;
    notifyListeners();
  }

  void _setLoading(bool value) {
    if (_isLoading == value) {
      return;
    }

    _isLoading = value;
    notifyListeners();
  }

  void _clearCommonPathSelection() {
    for (final item in _commonPaths) {
      item.isSelected = false;
    }
  }
}
