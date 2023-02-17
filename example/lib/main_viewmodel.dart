import 'package:desktop_file_picker/desktop_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'models/changelog_data.dart';

class MainViewModel extends BaseViewModel {
  late BuildContext _context;
  String? _singleFileSelected;
  String? get singleFileSelected => _singleFileSelected;

  List<String?>? _folderSelected;
  List<String?>? get folderSelected => _folderSelected;

  List<String>? _filesSelected;
  get filesSelected => _filesSelected;

  List<ChangeLogData> _changeLogData = [];
  List<ChangeLogData> get changeLog => _changeLogData;

  ready(BuildContext context) {
    _context = context;

    _changeLogData = [
      ChangeLogData(
        version: "#0.0.1",
        changes: [
          "Filtering by name",
          "Filtering by drive",
          "Filtering by size",
          "Filtering by date",
          "Filtering by file type",
          "Customizable theme options",
          "Single file select mode",
          "Multiple files select mode",
          "Folder select mode",
          "MacOS support",
          "Windows Support",
          "Linux Support"
        ],
      ),
      ChangeLogData(
        version: "#0.0.2",
        changes: [
          "Scaling issue fixes for smaller and bigger devices",
          "Added an example application in the github repository",
          "Code refactoring to improve loading speed.",
          "Added text trimming to long file names to ensure the content grid doesn't break."
        ],
      )
    ];
  }

  selectSingleFile() {
    showDialog(
      context: _context,
      builder: (context) => Dialog(
        child: FileSelector(
          isSingleFile: true,
          callbackCancel: () => Navigator.of(context).pop(),
          callbackConfirm: singleFilePicked,
        ),
      ),
    );
  }

  selectFolder() {
    showDialog(
      context: _context,
      builder: (context) => Dialog(
        child: FileSelector(
          isSingleFolder: true,
          callbackCancel: () => Navigator.of(context).pop(),
          callbackConfirm: folderPicked,
        ),
      ),
    );
  }

  selectFiles() {
    showDialog(
      context: _context,
      builder: (context) => Dialog(
        child: FileSelector(
          isMultipleFiles: true,
          callbackCancel: () => Navigator.of(context).pop(),
          callbackConfirm: filesPicked,
        ),
      ),
    );
  }

  singleFilePicked(List<String> file) {
    Navigator.of(_context).pop();
    _singleFileSelected = file.first;
    notifyListeners();
  }

  folderPicked(List<String> data) {
    Navigator.of(_context).pop();
    _folderSelected = data;
    notifyListeners();
  }

  filesPicked(List<String> data) {
    Navigator.of(_context).pop();
    _filesSelected = data;
    notifyListeners();
  }
}
