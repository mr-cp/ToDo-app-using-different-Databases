import 'package:flutter/material.dart';


class ScreenModel with ChangeNotifier {
// Dark Mode:
  bool _liteMode = true;

  get liteMode => _liteMode;

  toggleMode() {
    _liteMode = !_liteMode;

    notifyListeners();
  }

}
