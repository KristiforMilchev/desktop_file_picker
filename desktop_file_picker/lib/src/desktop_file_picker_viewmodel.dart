import 'package:stacked/stacked.dart';

class DesktopFilePickerViewModel extends BaseViewModel {
  late List<String> _commonPaths = [];
  List<String> get commonPaths => _commonPaths;

  void commonPathSelected(value) {}

  initialize() {
    _commonPaths = ["C:", "D:", "E:"];
    notifyListeners();
  }
}
