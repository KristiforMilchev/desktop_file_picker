import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class NavigationControlsViewModel extends BaseViewModel {
  late BuildContext _context;

  int _viewState = 1;
  int get viewState => _viewState;

  ready(BuildContext context) {
    _context = context;
  }

  void panelResized() {
    var currentSize = MediaQuery.of(_context).size;

    if (currentSize.width > 1300) {
      _viewState = 1;
    }

    if (currentSize.width < 1300) {
      _viewState = 2;
    }

    if (currentSize.width < 700) {
      _viewState = 3;
    }

    notifyListeners();
  }
}
